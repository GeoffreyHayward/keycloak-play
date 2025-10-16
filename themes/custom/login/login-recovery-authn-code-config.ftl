<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("recovery-code-config-header")}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${url.resourcesPath}/css/styles.css" rel="stylesheet" />
  </head>
  <body class="bg-light" style="min-height: 100vh;">
    <#include "partials/navbar.ftl">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-md-10 col-lg-8 col-xl-7">
          <div class="card shadow-sm">
            <div class="card-body p-4">
              <h1 class="h4 mb-3">${msg("recovery-code-config-header")}</h1>

              <#if message?has_content>
                <div class="alert <#if message.type == 'error'>alert-danger<#elseif message.type == 'warning'>alert-warning<#else>alert-info</#if>">
                  ${message.summary}
                </div>
              </#if>

              <div class="alert alert-warning" role="alert">
                <h2 class="h6 mb-2">${msg("recovery-code-config-warning-title")}</h2>
                <p class="mb-0">${msg("recovery-code-config-warning-message")}</p>
              </div>

              <#-- Codes list from recoveryAuthnCodesConfigBean -->
              <#if recoveryAuthnCodesConfigBean?? && recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesList?has_content>
                <div class="row g-2 row-cols-2 row-cols-sm-3 row-cols-md-4 mb-3" id="kc-recovery-codes">
                  <#list recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesList as code>
                    <#-- Format as groups like 1234-5678-9012 -->
                    <div class="col">
                      <code class="d-inline-block px-2 py-1 border rounded w-100 text-center">${code[0..3]}-${code[4..7]}-${code[8..]}</code>
                    </div>
                  </#list>
                </div>
              <#else>
                <p class="text-muted">${msg("recovery-codes-label-default")}</p>
              </#if>

              <div class="d-flex flex-wrap gap-2 mb-3">
                <button id="kc-rc-copy" type="button" class="btn btn-outline-secondary" <#if !(recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesList?has_content)>disabled</#if>>${msg("recovery-codes-copy")}</button>
                <button id="kc-rc-print" type="button" class="btn btn-outline-secondary" <#if !(recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesList?has_content)>disabled</#if>>${msg("recovery-codes-print")}</button>
                <button id="kc-rc-download" type="button" class="btn btn-outline-secondary" <#if !(recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesList?has_content)>disabled</#if>>${msg("recovery-codes-download")}</button>
                <span id="kc-rc-copied" class="text-success align-self-center d-none">${msg("recovery-codes-copied")}</span>
              </div>

              <form id="kc-recovery-codes-form" action="${url.loginAction}" method="post" class="d-flex flex-column gap-3">
                <input type="hidden" name="generatedRecoveryAuthnCodes" value="${recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesAsString}" />
                <input type="hidden" name="generatedAt" value="${recoveryAuthnCodesConfigBean.generatedAt?c}" />
                <input type="hidden" id="userLabel" name="userLabel" value="${msg("recovery-codes-label-default")}" />

                <div class="form-check">
                  <input class="form-check-input" type="checkbox" id="kc-rc-confirm" />
                  <label class="form-check-label" for="kc-rc-confirm">${msg("recovery-codes-confirmation-message")}</label>
                </div>

                <div class="d-flex gap-2">
                  <button type="submit" id="kc-rc-complete" class="btn btn-primary" disabled>${msg("recovery-codes-action-complete")}</button>
                  <#if isAppInitiatedAction??>
                    <button type="submit" class="btn btn-outline-secondary" name="cancel-aia" value="true">${msg("recovery-codes-action-cancel")}</button>
                  </#if>
                </div>
              </form>
            </div>
          </div>
          <p class="text-center text-muted small mt-3">Powered by Keycloak</p>
        </div>
      </div>
    </div>
    <script>
      (function(){
        const confirm = document.getElementById('kc-rc-confirm');
        const complete = document.getElementById('kc-rc-complete');
        if (confirm && complete) {
          confirm.addEventListener('change', function(){ complete.disabled = !this.checked; });
        }
        function getCodes() {
          return Array.from(document.querySelectorAll('#kc-recovery-codes code')).map(c => c.textContent.trim()).filter(Boolean);
        }
        const copyBtn = document.getElementById('kc-rc-copy');
        const copied = document.getElementById('kc-rc-copied');
        if (copyBtn) {
          copyBtn.addEventListener('click', async function(){
            const list = getCodes();
            if (!list.length) return;
            try { await navigator.clipboard.writeText(list.join('\n')); if (copied) { copied.classList.remove('d-none'); setTimeout(()=>copied.classList.add('d-none'), 1500); } } catch(e) {}
          });
        }
        const printBtn = document.getElementById('kc-rc-print');
        if (printBtn) { printBtn.addEventListener('click', function(){ window.print(); }); }
        const dlBtn = document.getElementById('kc-rc-download');
        if (dlBtn) {
          dlBtn.addEventListener('click', function(){
            const list = getCodes();
            if (!list.length) return;
            const now = new Date();
            const blob = new Blob([
              '${msg("recovery-codes-download-file-header")}\n\n',
              '${msg("recovery-codes-download-file-description")}\n',
              '${msg("recovery-codes-download-file-date")} ' + now.toISOString() + '\n\n',
              list.join('\n')
            ], { type: 'text/plain' });
            const a = document.createElement('a');
            a.href = URL.createObjectURL(blob);
            a.download = 'recovery-codes.txt';
            a.click();
            URL.revokeObjectURL(a.href);
          });
        }
      })();
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/js/bootstrap.bundle.min.js"></script>
  </body>
  </html>

