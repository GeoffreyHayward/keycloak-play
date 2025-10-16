# Keycloak Themes (local mount)

This folder is mounted into the Keycloak container at `/opt/keycloak/themes`.

- Add your themes under a subfolder, e.g. `themes/custom`.
- Each theme can have subtypes like `login`, `account`, `email`.
- Minimum for a login theme: a `theme.properties` file.

## Start the stack

1) `docker compose up -d`
2) Admin Console: http://localhost:8080/auth/ (admin / admin)

## Create realm "play"

1) Top-left realm selector -> Create realm
2) Realm name: `play` -> Create

## Configure email (MailHog)

Realm Settings -> Email:
- From: `no-reply@example.com`
- From display name: `Example Identity (DEV)`
- Host: `mailhog`
- Port: `1025`
- Enable SSL: Off
- Enable StartTLS: Off
- Authentication: leave blank
- Save, then click "Test connection"

MailHog UI: http://localhost:8025

## Enable login features

Realm Settings -> Login:
- User registration: On
- Forgot password: On
- Remember me: On
- Verify email: On
- Save

## Apply the custom login theme

Realm Settings -> Themes:
- Login theme: `custom`
- Save

This custom theme overrides the login page to use Bootstrap 5 (via CDN) and a small custom stylesheet at `${url.resourcesPath}/css/styles.css`.

## Hide first/last name on registration

Use User Profile to exclude these fields from the registration form:
1) Realm Settings -> User Profile
2) Open `firstName` and `lastName`
   - Required: Off
   - Permissions: remove `anonymous` from Edit/View (so they don’t appear during registration)
   - Save

Note: Users and admins can still edit these later if you keep `user`/`admin` permissions.

## Add Terms & Conditions

Option A — built-in page (simple, no stored attribute):
1) Authentication -> Flows -> select "Registration"
2) Add execution -> "Terms and Conditions" -> Add
3) Set it to `Required`
4) Add your text at Realm Settings -> Login -> "Terms and conditions" (or theme content)

This enforces acceptance but does not store a user attribute or date by default. You can enable Events to see an acceptance event with a timestamp:
- Realm Settings -> Events -> Save events: On; select user events; Save

Option B — user profile checkbox (stores a boolean attribute):
1) Realm Settings -> User Profile -> Add attribute
   - Name: `termsAccepted`
   - Display name: `I accept the Terms & Conditions`
   - Type: Boolean
   - Required on registration: On
   - Permissions: allow Edit/View for `anonymous`, `user`, `admin`
   - (Optional) Display description with a link to your T&C
2) Save

To also store the acceptance date automatically requires a custom Required Action or authenticator. As a lightweight alternative, rely on Events (Option A) to get a timestamped record, or add a second attribute `termsAcceptedAt` that you populate manually if needed.

## Create your first user

Realm: `play`

1) Users -> Add user
   - Username: choose a username
   - Email: your email (to see verification in MailHog)
   - Email verified: leave Off (so you can test verification)
   - First/Last name: optional or hidden per steps above
   - Create
2) Credentials tab -> Set password
   - New password: set a temporary password
   - Temporary: On (forces update on first login)
   - Save
3) Send verification email (to test MailHog)
   - With the user selected, click Actions -> Send email -> Verify email
   - Open http://localhost:8025 and complete verification

Now visit the login page at http://localhost:8080/auth/realms/play/account or a protected app to test login, password update, remember-me, and email verification flows.

## Docs

Keycloak themes: https://www.keycloak.org/docs/latest/server_development/#_themes

## Branding & Logo

- Shared navbar partial: `themes/custom/login/partials/navbar.ftl`
- Demo logo file: `themes/custom/login/resources/img/logo.svg`
- Replace `logo.svg` with your own (same filename) or update the `<img>` `src` in the partial to point to a different asset.
- The navbar uses `${realm.displayNameHtml!realm.name}` as the brand text next to the logo.

## Optional: Two‑Factor (TOTP) Setup

Enable user setup (prompt users to configure OTP):
- Authentication -> Required Actions
  - Toggle `Configure OTP` to Enabled
  - Optional: check `Default Action` to force all users to set up OTP on next login

Enforce 2FA for logins (all users or by condition):
1) Authentication -> Flows
2) Create a copy of the `Browser` flow (Actions -> Duplicate) and open the copy
3) Ensure there is an `OTP Form` (or `Conditional OTP`) execution after Username/Password
   - To require for all users: set `OTP Form` to `Required`
   - To apply conditionally: keep `Conditional OTP` and configure its condition (e.g., require if user has OTP, by role, or attribute)
4) Authentication -> Bindings: set `Browser Flow` to your copied flow

Tune OTP policy (algorithms, digits, period):
- Authentication -> OTP Policy
  - Type: `Time-based (TOTP)`
  - Algorithm: `HmacSHA1` (common default) or stronger
  - Digits: `6`
  - Period: `30s`
  - Look-ahead window: as needed for clock skew

End‑user setup (what users do):
- After login (if required action is set) they’ll see the OTP setup screen with a QR code
- Or via Account Console -> Security -> Signing in -> Two‑factor -> Set up authenticator
- Supported apps: Google Authenticator, Authy, 1Password, Microsoft Authenticator, etc.

Test the flow:
- Log out, then log in to the `play` realm
- Enter username/password, then complete OTP with your authenticator app

## Optional: Backup/Recovery Codes

Allow users to generate single‑use recovery codes they can use when they lose access to their authenticator app.

Admin steps
- Authentication -> Required Actions
  - Enable: "Configure Recovery Codes" (names can vary slightly by version)
  - Optional: set as "Default Action" to force setup on next login
- Authentication -> Flows
  - Duplicate the `Browser` flow and open the copy
  - In the OTP step area, add an execution for recovery codes (e.g., "Recovery Codes" or "Recovery Authenticator") and set it to `ALTERNATIVE`
  - Ensure `OTP Form` is also present (ALTERNATIVE or REQUIRED, per your policy)
  - Bindings -> set `Browser Flow` to your copied flow

User steps
- Account Console -> Security -> Signing in -> Recovery codes
- Generate codes, then download or copy them and store safely
- During login when prompted for OTP, choose the recovery code option (e.g., "Use recovery code" / "Try another way") and enter one of the codes

Notes
- Each recovery code is single use; users can regenerate a fresh set any time (old unused codes are invalidated)
- Keep codes secure; treat them like passwords
- If your Keycloak version hides recovery codes behind a feature flag, set `KC_FEATURES=recovery-codes` in the Keycloak container environment
