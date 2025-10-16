<#-- Custom Bootstrap-based login page -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("loginTitle", realm.displayName?default(""))}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${url.resourcesPath}/css/styles.css" rel="stylesheet" />
  </head>
  <body class="bg-light" style="min-height: 100vh;">
    <#include "partials/navbar.ftl">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
          <div class="card shadow-sm">
            <div class="card-body p-4">
              

              <#if message?has_content>
                <div class="alert <#if message.type == 'error'>alert-danger<#elseif message.type == 'warning'>alert-warning<#else>alert-info</#if>" role="alert">
                  ${message.summary}
                </div>
              </#if>

              <form id="kc-form-login" action="${url.loginAction}" method="post" novalidate>
                <div class="mb-3">
                  <label for="username" class="form-label">
                    <#if realm.loginWithEmailAllowed && !realm.registrationEmailAsUsername>
                      ${msg("usernameOrEmail")}
                    <#else>
                      ${msg("username")}
                    </#if>
                  </label>
                  <input tabindex="1" id="username" class="form-control" name="username" type="text" value="${login.username!}" autofocus autocomplete="username"/>
                </div>

                <div class="mb-3">
                  <label for="password" class="form-label">${msg("password")}</label>
                  <input tabindex="2" id="password" class="form-control" name="password" type="password" autocomplete="current-password" />
                </div>

                <div class="d-flex justify-content-between align-items-center mb-3">
                  <div class="form-check">
                    <#if realm.rememberMe>
                      <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe" <#if login.rememberMe?? && login.rememberMe>checked</#if> />
                      <label class="form-check-label" for="rememberMe">${msg("rememberMe")}</label>
                    </#if>
                  </div>
                  <div>
                    <#if realm.resetPasswordAllowed>
                      <a href="${url.loginResetCredentialsUrl}" class="link-secondary">${msg("doForgotPassword")}</a>
                    </#if>
                  </div>
                </div>

                <button tabindex="3" class="btn btn-primary w-100" type="submit">${msg("doLogIn")}</button>
              </form>

              <#if realm.registrationAllowed>
                <hr class="my-4" />
                <div class="text-center">
                  <span class="text-muted me-2">${msg("noAccount")}</span>
                  <a class="btn btn-outline-secondary btn-sm" href="${url.registrationUrl}">${msg("doRegister")}</a>
                </div>
              </#if>
            </div>
          </div>
          <p class="text-center text-muted small mt-3">Powered by Keycloak</p>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/js/bootstrap.bundle.min.js"></script>
  </body>
  </html>
