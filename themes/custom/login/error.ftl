<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("errorTitle")!"We are sorry..."}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${url.resourcesPath}/css/styles.css" rel="stylesheet" />
  </head>
  <body class="bg-light" style="min-height: 100vh;">
    <#include "partials/navbar.ftl">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-sm-10 col-md-8 col-lg-7 col-xl-6">
          <div class="card shadow-sm mt-4">
            <div class="card-body p-4">
              <h1 class="h4 mb-3">${msg("errorTitle")!"We are sorry..."}</h1>

              <#if message?has_content>
                <div class="alert alert-danger" role="alert">
                  ${message.summary}
                </div>
              <#else>
                <p class="text-muted">${msg("unexpectedError")!"An unexpected error occurred."}</p>
              </#if>

              <div class="d-flex gap-2 mt-3">
                <a class="btn btn-primary" href="${url.loginUrl}">${msg("backToLogin")?no_esc}</a>
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

