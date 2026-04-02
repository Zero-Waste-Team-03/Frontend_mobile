"""
Upload the built APK to MediaFire and write the download link to a file.

Required environment variables (set via GitHub Secrets):
  MEDIAFIRE_EMAIL      – MediaFire account email
  MEDIAFIRE_PASSWORD   – MediaFire account password
  MEDIAFIRE_APP_ID     – MediaFire application ID (default: 42511)
  MEDIAFIRE_FOLDER_KEY – (optional) destination folder key on MediaFire
  APK_NAME             – filename of the APK to upload
"""

import os
import sys
import time
import requests

# ── Configuration ────────────────────────────────────────────────
EMAIL = (os.environ.get("MEDIAFIRE_EMAIL") or "").strip()
PASSWORD = (os.environ.get("MEDIAFIRE_PASSWORD") or "").strip()
APP_ID = (os.environ.get("MEDIAFIRE_APP_ID") or "42511").strip() or "42511"
FOLDER_KEY = (os.environ.get("MEDIAFIRE_FOLDER_KEY") or "").strip()
APK_NAME = os.environ.get("APK_NAME", "app-release.apk")

API_BASE = "https://www.mediafire.com/api/1.5"

# ── Helpers ──────────────────────────────────────────────────────

def fail(msg: str):
    print(f"::error::{msg}")
    sys.exit(1)


def api_call(endpoint: str, params: dict | None = None, method: str = "GET") -> dict:
    """Make a MediaFire API call and return the JSON response."""
    url = f"{API_BASE}/{endpoint}"
    params = params or {}
    params["response_format"] = "json"

    headers = {
        "User-Agent": "gaspzero-ci-mediafire-uploader/1.0",
    }

    if method == "POST":
        resp = requests.post(url, data=params, headers=headers, timeout=120)
    else:
        resp = requests.get(url, params=params, headers=headers, timeout=120)

    try:
        resp.raise_for_status()
    except requests.HTTPError as exc:
        body = resp.text[:500]
        fail(
            f"HTTP {resp.status_code} calling {endpoint}: {exc}. "
            f"Response body (first 500 chars): {body}"
        )

    try:
        data = resp.json()
    except ValueError:
        fail(f"Non-JSON response from {endpoint}: {resp.text[:500]}")
        return {}

    result = data.get("response", {}).get("result", "Error")
    if result != "Success":
        msg = data.get("response", {}).get("message", "Unknown error")
        fail(f"API {endpoint} failed: {result} – {msg}")

    return data["response"]


# ── 1. Authenticate ─────────────────────────────────────────────

def get_session_token() -> str:
    print("🔑 Authenticating with MediaFire…")
    if not EMAIL or not PASSWORD:
        fail("MEDIAFIRE_EMAIL and MEDIAFIRE_PASSWORD must be set as GitHub Secrets.")
    if not APP_ID:
        fail("MEDIAFIRE_APP_ID resolved to empty value.")

    print(f"ℹ️ Using MediaFire application_id={APP_ID}")

    resp = api_call("user/get_session_token.php", {
        "email": EMAIL,
        "password": PASSWORD,
        "application_id": APP_ID,
        "token_version": "2",
    })
    token = resp.get("session_token")
    if not token:
        fail("Failed to obtain session token.")
    token = str(token)
    print("✅ Authenticated successfully.")
    return token


# ── 2. Upload via simple upload endpoint ────────────────────────

def upload_simple(session_token: str, file_path: str) -> str:
    """
    Use MediaFire's simple upload (single request, good for files < 4 GB).
    Returns the quick_key of the uploaded file.
    """
    print(f"📤 Uploading {file_path}…")
    file_size = os.path.getsize(file_path)
    file_name = os.path.basename(file_path)
    print(f"   File size: {file_size / (1024*1024):.1f} MB")

    url = f"{API_BASE}/upload/simple.php"
    params = {
        "session_token": session_token,
        "response_format": "json",
        "action_on_duplicate": "replace",
    }
    if FOLDER_KEY:
        params["folder_key"] = FOLDER_KEY

    headers = {
        "x-filename": file_name,
        "x-filesize": str(file_size),
        "Content-Type": "application/octet-stream",
    }

    with open(file_path, "rb") as f:
        resp = requests.post(url, params=params, headers=headers, data=f, timeout=600)

    resp.raise_for_status()
    data = resp.json()

    doupload = data.get("response", {}).get("doupload", {})
    upload_key = doupload.get("key")
    if not upload_key:
        fail(f"Upload failed – no upload key in response: {data}")

    print(f"✅ Upload queued (key: {upload_key}). Polling status…")
    return poll_upload(session_token, upload_key)


def poll_upload(session_token: str, upload_key: str, max_retries: int = 30) -> str:
    """Poll the upload/poll_upload endpoint until the file is ready."""
    for attempt in range(max_retries):
        time.sleep(5)
        resp = api_call("upload/poll_upload.php", {
            "session_token": session_token,
            "key": upload_key,
        })
        doupload = resp.get("doupload", {})
        status = doupload.get("status")
        # status codes: 2=error, 6=in progress, 99=complete
        if status == 99 or str(status) == "99":
            quick_key = doupload.get("quickkey")
            if not quick_key:
                fail(f"Upload complete but no quickkey: {doupload}")
            print(f"✅ Upload complete! quickkey={quick_key}")
            return quick_key
        elif status == 2 or str(status) == "2":
            fail(f"Upload error: {doupload}")
        else:
            progress = doupload.get("description", "processing…")
            print(f"   ⏳ [{attempt+1}/{max_retries}] {progress}")

    fail("Upload timed out after polling.")
    return ""


# ── 3. Get download link ────────────────────────────────────────

def get_download_link(session_token: str, quick_key: str) -> str:
    print(f"🔗 Fetching download link for {quick_key}…")
    resp = api_call("file/get_info.php", {
        "session_token": session_token,
        "quick_key": quick_key,
    })
    file_info = resp.get("file_info", {})
    links = file_info.get("links", {})
    normal_download = links.get("normal_download", "")

    if not normal_download:
        # Fallback: construct the link manually
        normal_download = f"https://www.mediafire.com/file/{quick_key}"

    print(f"✅ Download link: {normal_download}")
    return normal_download


# ── Main ─────────────────────────────────────────────────────────

def main():
    print("=" * 60)
    print("  MediaFire APK Uploader")
    print("=" * 60)

    if not os.path.isfile(APK_NAME):
        fail(f"APK file not found: {APK_NAME}")

    session_token = get_session_token()
    quick_key = upload_simple(session_token, APK_NAME)
    download_link = get_download_link(session_token, quick_key)

    # Write link to file so the workflow can read it
    with open("mediafire_link.txt", "w") as f:
        f.write(download_link)

    # Also set as GitHub Actions output
    github_output = os.environ.get("GITHUB_OUTPUT", "")
    if github_output:
        with open(github_output, "a") as f:
            f.write(f"mediafire_link={download_link}\n")

    print("\n🎉 Done! APK uploaded successfully.")
    print(f"   📥 {download_link}")


if __name__ == "__main__":
    main()
