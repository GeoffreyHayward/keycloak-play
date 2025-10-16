<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("auth-recovery-code-header")}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${url.resourcesPath}/css/styles.css" rel="stylesheet" />
  </head>
  <body class="bg-light d-flex align-items-start" style="min-height: 100vh;">
    <#include "partials/navbar.ftl">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
          <div class="card shadow-sm">
            <div class="card-body p-4">
              <h1 class="h5 mb-3">${msg("auth-recovery-code-header")}</h1>

              <#if message?has_content>
                <div class="alert <#if message.type == 'error'>alert-danger<#elseif message.type == 'warning'>alert-warning<#else>alert-info</#if>">
                  ${message.summary}
                </div>
              </#if>

              <form id="kc-recovery-code-login-form" action="${url.loginAction}" method="post" novalidate>
                <div class="mb-3">
                  <label for="recoveryCodeInput" class="form-label">${msg("auth-recovery-code-prompt", recoveryAuthnCodesInputBean.codeNumber?c)}</label>
                  <input id="recoveryCodeInput" name="recoveryCodeInput" type="text" class="form-control" autocomplete="one-time-code" dir="ltr" />
                  <#if messagesPerField?has_content && messagesPerField.existsError('recoveryCodeInput')>
                    <div class="invalid-feedback d-block">${messagesPerField.get('recoveryCodeInput')}</div>
                  </#if>
                </div>
                <div class="d-grid">
                  <button class="btn btn-primary" id="kc-login" name="login" type="submit">${msg("doLogIn")}</button>
                </div>
              </form>
            </div>
          </div>
          <p class="text-center text-muted small mt-3">Powered by Keycloak</p>
        </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/js/bootstrap.bundle.min.js"></script>
  </body>
  </html>

