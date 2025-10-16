<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("emailForgotTitle")!msg("doForgotPassword")}</title>
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

              <p class="text-muted">${msg("emailInstruction")!msg("doForgotPassword")}</p>

              <form id="kc-reset-password-form" action="${url.loginAction}" method="post" novalidate>
                <div class="mb-3">
                  <label for="username" class="form-label">
                    <#if realm.loginWithEmailAllowed && !realm.registrationEmailAsUsername>
                      ${msg("usernameOrEmail")}
                    <#elseif realm.registrationEmailAsUsername>
                      ${msg("email")}
                    <#else>
                      ${msg("username")}
                    </#if>
                  </label>
                  <input id="username" name="username" type="text" class="form-control" value="${(auth.attemptedUsername)!}" autocomplete="username email" />
                </div>

                <button class="btn btn-primary w-100" type="submit">${msg("doSubmit")!msg("doForgotPassword")}</button>
              </form>

              <hr class="my-4" />
              <div class="text-center">
                <a class="btn btn-outline-secondary btn-sm" href="${url.loginUrl}">${msg("backToLogin")?no_esc}</a>
              </div>
            </div>
          </div>
          <p class="text-center text-muted small mt-3">Powered by Keycloak</p>
        </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/js/bootstrap.bundle.min.js"></script>
  </body>
  </html>
