import { createApp, ref } from "vue";
import App from "./App.vue";
import { initKeycloak } from "./keycloak";

(async () => {
    // Log resolved VITE_* config to help validate environment
    // Note: contains no secrets; safe to log in dev
    console.info("[health] VITE_KEYCLOAK_URL=", import.meta.env.VITE_KEYCLOAK_URL);
    console.info("[health] VITE_KEYCLOAK_REALM=", import.meta.env.VITE_KEYCLOAK_REALM);
    console.info("[health] VITE_KEYCLOAK_CLIENT_ID=", import.meta.env.VITE_KEYCLOAK_CLIENT_ID);

    const { keycloak } = await initKeycloak();

    const app = createApp(App);
    app.provide("kc", keycloak);
    app.mount("#app");
})();
