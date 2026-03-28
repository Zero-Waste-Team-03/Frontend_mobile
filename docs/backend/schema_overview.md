# GraphQL Backend Schema Details

This folder contains the complete up-to-date `.json` introspected schema dump of your GraphQL API endpoint (`https://api.gaspzero.qzz.io/graphql`).
The complete schema has been downloaded into `full_schema.json`.

## Quick Reference for Authentication Mutations
Below is the accurate specification of the Mutations to be used for implementing authentication in Flutter properly.

### 1. `sendVerification(email: String!)`
**Description**: Sends an OTP code to the provided email.
```graphql
mutation SendVerification($email: String!) {
  sendVerification(email: $email) {
    message
  }
}
```

### 2. `register(otp: String!, registerInput: RegisterInput!)`
**Description**: Completes user registration by validating the OTP alongside registration credentials.
```graphql
mutation Register($otp: String!, $registerInput: RegisterInput!) {
  register(otp: $otp, registerInput: $registerInput) {
    message
  }
}
```

### 3. `login(loginInput: LoginInput!)`
**Description**: Logs in an existing user mapping and returns the authentication response payload including access tokens.
```graphql
mutation Login($loginInput: LoginInput!) {
  login(loginInput: $loginInput) {
    accessToken
    refreshToken
    user {
      id
      name
      email
    }
  }
}
```

### 4. `changePassword(changePasswordInput: ChangePasswordInput!)`
**Description**: Changes the password for an authenticated user.
```graphql
mutation ChangePassword($changePasswordInput: ChangePasswordInput!) {
  changePassword(changePasswordInput: $changePasswordInput) {
    message
  }
}
```

### 5. `resetPassword(resetPasswordInput: ResetPasswordInput!)`
**Description**: Resets the password for a user using a forgotten-password flow payload.
```graphql
mutation ResetPassword($resetPasswordInput: ResetPasswordInput!) {
  resetPassword(resetPasswordInput: $resetPasswordInput) {
    message
  }
}
```

### Introspection Extractor Script
The schema can be re-fetched directly inside `<gaspzero>` root via Python on Windows using simple python code:
```bash
python -c "import urllib.request, json; query='{__schema {types {name fields {name}}}}'; req=urllib.request.Request('https://api.gaspzero.qzz.io/graphql', data=json.dumps({'query': query}).encode(), headers={'Content-Type': 'application/json'}); res=urllib.request.urlopen(req); open('docs/backend/schema.json', 'w').write(res.read().decode())"
```
