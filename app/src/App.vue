<template>
  <main style="max-width: 800px; margin: 2rem auto; font-family: system-ui, sans-serif;">
    <div v-if="showHealth" style="background:#fffbeb;border:1px solid #fcd34d;color:#78350f;padding:8px 12px;border-radius:8px;margin-bottom:12px;font-size:14px;">
      <div style="display:flex;justify-content:space-between;align-items:center;gap:8px;">
        <div>
          <strong>Health</strong>
          <div>KC URL: {{ envUrl }}</div>
          <div>Realm: {{ envRealm }} | Client: {{ envClient }}</div>
        </div>
        <button @click="dismissHealth" style="border:0;background:#f59e0b;color:#fff;padding:4px 8px;border-radius:6px;cursor:pointer;">Hide</button>
      </div>
    </div>
    <h1>Vue + Keycloak Demo</h1>

    <div style="margin: 1rem 0;">
      <button @click="login" :disabled="busy">Sign in</button>
      <button @click="logout" :disabled="busy" style="margin-left: 1rem;">Sign out</button>
    </div>

    <section v-if="isAuthenticated">
      <h2>Welcome!</h2>
      <p><strong>User:</strong> {{ tokenParsed?.preferred_username }}</p>
      <p><strong>Email:</strong> {{ tokenParsed?.email }}</p>
      <p><strong>Expires in:</strong> {{ Math.max(0, (kc.tokenParsed?.exp * 1000 - Date.now())/1000).toFixed(0) }}s</p>
      <div style="margin-top: 1rem;">
        <button @click="account">Open Account Console</button>
      </div>
    </section>

    <section v-else>
      <p>Not signed in.</p>
    </section>
  </main>
</template>

<script setup>
import { inject, ref, onMounted } from "vue";

const kc = inject("kc");
const isAuthenticated = ref(!!kc?.authenticated);
const tokenParsed = ref(kc?.tokenParsed || null);
const busy = ref(false);

// Health banner state and env resolution
const params = new URLSearchParams(window.location.search);
const envUrl = import.meta.env.VITE_KEYCLOAK_URL;
const envRealm = import.meta.env.VITE_KEYCLOAK_REALM;
const envClient = import.meta.env.VITE_KEYCLOAK_CLIENT_ID;
const showHealth = ref(params.get('health') === '1' && sessionStorage.getItem('hideHealth') !== '1');
function dismissHealth(){ showHealth.value = false; sessionStorage.setItem('hideHealth','1'); }

async function login() {
  busy.value = true;
  try {
    await kc.login({
      redirectUri: window.location.origin + "/"
    });
  } finally {
    busy.value = false;
  }
}

async function logout() {
  busy.value = true;
  try {
    await kc.logout({
      redirectUri: window.location.origin + "/"
    });
  } finally {
    busy.value = false;
  }
}

function account() {
  kc.accountManagement();
}

onMounted(() => {
  // Keep local state in sync (and refresh token periodically)
  if (kc) {
    isAuthenticated.value = !!kc.authenticated;
    tokenParsed.value = kc.tokenParsed || null;

    // optional auto-refresh
    setInterval(async () => {
      if (!kc.authenticated) return;
      try {
        const refreshed = await kc.updateToken(30);
        if (refreshed) {
          tokenParsed.value = kc.tokenParsed;
        }
      } catch (e) {
        console.warn("Token refresh failed", e);
      }
    }, 10000);
  }
});
</script>

<style>
button {
  padding: 0.6rem 1rem;
  border-radius: 8px;
  border: 1px solid #ddd;
  cursor: pointer;
}
button:disabled { opacity: 0.6; cursor: not-allowed; }
</style>

