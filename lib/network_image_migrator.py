import re
from pathlib import Path

IMPORT_LINE = (
    "import 'package:gaspzero/shared/widgets/network_image.dart';"
)

NETWORK_IMAGE_PATTERN = re.compile(
    r"\bNetworkImage\s*\(",
    re.MULTILINE,
)


def find_matching_paren(text, open_idx):
    depth = 0

    for i in range(open_idx, len(text)):
        ch = text[i]

        if ch == "(":
            depth += 1

        elif ch == ")":
            depth -= 1

            if depth == 0:
                return i

    return -1


def insert_import(text):
    if IMPORT_LINE in text:
        return text

    imports = list(
        re.finditer(
            r"^import\s+['\"].*?['\"]\s*;",
            text,
            re.MULTILINE,
        )
    )

    if imports:
        last_import = imports[-1]

        return (
            text[: last_import.end()]
            + "\n"
            + IMPORT_LINE
            + text[last_import.end() :]
        )

    return IMPORT_LINE + "\n\n" + text


def migrate_file(path):
    text = path.read_text(encoding="utf-8")

    replacements = 0
    offset = 0

    while True:
        match = NETWORK_IMAGE_PATTERN.search(text, offset)

        if not match:
            break

        open_paren = text.find("(", match.start())

        close_paren = find_matching_paren(
            text,
            open_paren,
        )

        if close_paren == -1:
            offset = match.end()
            continue

        args = text[
            open_paren + 1 : close_paren
        ]

        replacement = (
            f"AppNetworkImage({args})"
        )

        text = (
            text[: match.start()]
            + replacement
            + text[close_paren + 1 :]
        )

        offset = (
            match.start()
            + len(replacement)
        )

        replacements += 1

    if replacements > 0:
        text = insert_import(text)

        path.write_text(
            text,
            encoding="utf-8",
        )

        print(
            f"[UPDATED] {path} ({replacements} replacements)"
        )

    return replacements


def main():
    root = Path.cwd()

    total_files = 0
    total_replacements = 0

    for file in root.rglob("*.dart"):
        total_files += 1

        try:
            total_replacements += migrate_file(
                file
            )
        except Exception as e:
            print(f"[ERROR] {file}")
            print(e)

    print()
    print(f"Files scanned: {total_files}")
    print(
        f"Replacements: {total_replacements}"
    )


if __name__ == "__main__":
    main()