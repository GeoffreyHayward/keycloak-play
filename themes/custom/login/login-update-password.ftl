<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("updatePasswordTitle")!msg("updatePassword")}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${url.resourcesPath}/css/styles.css" rel="stylesheet" />
  </head>
  <body class="bg-light d-flex align-items-center" style="min-height: 100vh;">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
          <div class="card shadow-sm">
            <div class="card-body p-4">
              <h1 class="h4 text-center mb-3">${realm.displayNameHtml?default("Keycloak")}</h1>

              <#if message?has_content>
                <div class="alert <#if message.type == 'error'>alert-danger<#elseif message.type == 'warning'>alert-warning<#else>alert-info</#if>" role="alert">
                  ${message.summary}
                </div>
              </#if>

              <form id="kc-passwd-update-form" action="${url.loginAction}" method="post" novalidate>
                <div class="mb-3">
                  <label class="form-label" for="password-new">${msg("passwordNew")!msg("password")}</label>
                  <input id="password-new" name="password-new" type="password" class="form-control" autocomplete="new-password" />
                </div>
                <div class="mb-3">
                  <label class="form-label" for="password-confirm">${msg("passwordConfirm")}</label>
                  <input id="password-confirm" name="password-confirm" type="password" class="form-control" autocomplete="new-password" />
                </div>
                <button class="btn btn-primary w-100" type="submit">${msg("doSubmit")!msg("updatePassword")}</button>
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

