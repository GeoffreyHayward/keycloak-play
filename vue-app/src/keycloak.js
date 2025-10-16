import Keycloak from "keycloak-js";

const keycloak = new Keycloak({
    url: import.meta.env.VITE_KEYCLOAK_URL,   // e.g. http://localhost:8080/auth
    realm: import.meta.env.VITE_KEYCLOAK_REALM, // keyclock
    clientId: import.meta.env.VITE_KEYCLOAK_CLIENT_ID // vue-app
});

export async function initKeycloak() {
    // Use check-sso so the app loads without forcing login
    const authenticated = await keycloak.init({
        onLoad: "check-sso",
        pkceMethod: "S256",
        silentCheckSsoRedirectUri: window.location.origin + "/silent-check-sso.html"
    }).catch((e) => {
        console.error("Keycloak init error:", e);
        return false;
    });

    return { keycloak, authenticated };
}

export default keycloak;
