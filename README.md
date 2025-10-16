# keycloak-play
Keycloak + Docker Compose playground with a Bootstrap-themed login flow and a demo Vue 3 SPA wired to Keycloak.

**What’s Included**
- Themed Keycloak login pages (login, register, forgot/update password, OTP, recovery codes, delete credential, error)
- MailHog for dev SMTP testing
- Demo Vue 3 app built with Vite and `keycloak-js`

**Run The Stack**
- Start: `docker compose up -d --build`
- Keycloak Admin Console: `http://localhost:8080/auth/` (admin/admin)
- MailHog: `http://localhost:8025`
- Demo app: `http://localhost:3000`

**Keycloak: Create Realm And Client**
- Realm: create `play` (Realm selector → Create → name `play`).
- Client (`vue-app`): Clients → Create
  - Client type: OpenID Connect
  - Client ID: `vue-app`
  - Client authentication: OFF (public)
  - Standard Flow: ON
  - Root URL: `http://localhost:3000`
  - Redirect URIs: `http://localhost:3000/*`, `http://localhost:3000`
  - Post‑logout Redirect URIs: `http://localhost:3000/*`, `http://localhost:3000`
  - Web Origins: `+` (or `http://localhost:3000`)
  - Advanced → PKCE: `S256`

**Demo App Build Notes**
- App lives in `app/` and is built as the `vueapp` service.
- The Dockerfile uses `npm ci` when `package-lock.json` exists, otherwise falls back to `npm install`.
  - To lock dependencies, run `npm install` once in `app/` to generate `package-lock.json`.
- Build args are set in compose and passed to Vite:
  - `VITE_KEYCLOAK_URL=http://localhost:8080/auth`
  - `VITE_KEYCLOAK_REALM=play`
  - `VITE_KEYCLOAK_CLIENT_ID=vue-app`

**Email + Themes**
- SMTP is already configured to use MailHog. Test at: Realm Settings → Email → Test connection.
- Login theme: set to `custom` under Realm Settings → Themes.
- Email theme: set to `custom` to use branded templates. Configure a logo in `themes/custom/email/theme.properties` via `emailLogoUrl` or `emailLogoDataUri`.

**2FA (Optional)**
- Recovery Codes feature enabled via compose (`KC_FEATURES: "recovery-codes"`).
- To enforce OTP and/or Recovery Codes: Authentication → Flows → duplicate Browser → add “OTP Form” and “Recovery Authentication Codes” as `ALTERNATIVE` under the OTP subflow → Bind the flow.

**Quick Links**
- Admin Console: `http://localhost:8080/auth/`
- Account Console (play): `http://localhost:8080/auth/realms/play/account/`
- Demo App: `http://localhost:3000`

Files to check
- Compose: `docker-compose.yml:1`
- Demo app: `app/Dockerfile:1`, `app/package.json:1`, `app/vite.config.js:1`
- Theme root: `themes/README.md:1`
