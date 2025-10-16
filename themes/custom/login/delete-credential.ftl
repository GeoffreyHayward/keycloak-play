<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("deleteCredentialTitle", credentialLabel)}</title>
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
              <h1 class="h5 mb-3">${msg("deleteCredentialTitle", credentialLabel)}</h1>

              <p class="mb-4">${msg("deleteCredentialMessage", credentialLabel)}</p>

              <form action="${url.loginAction}" method="post" class="d-flex gap-2">
                <input class="btn btn-danger" name="accept" id="kc-accept" type="submit" value="${msg("doConfirmDelete")}" />
                <input class="btn btn-outline-secondary" name="cancel-aia" id="kc-decline" type="submit" value="${msg("doCancel")}" />
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

