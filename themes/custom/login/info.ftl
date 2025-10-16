<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title><#if messageHeader??>${msg(messageHeader)}<#else>${msg("loginAccountTitle")!"Info"}</#if></title>
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
              <h1 class="h5 mb-3">
                <#if messageHeader??>
                  ${msg(messageHeader)}
                <#else>
                  ${msg("loginAccountTitle")!"Info"}
                </#if>
              </h1>

              <div class="alert alert-info" role="alert">${message.summary}</div>

              <div class="d-flex gap-2 mt-2">
                <#if pageRedirectUri?has_content>
                  <a class="btn btn-primary" href="${pageRedirectUri}">${msg("backToApplication")}</a>
                <#elseif actionUri?has_content>
                  <a class="btn btn-primary" href="${actionUri}">${msg("proceedWithAction")}</a>
                <#elseif (client.baseUrl)?has_content>
                  <a class="btn btn-primary" href="${client.baseUrl}">${msg("backToApplication")}</a>
                <#else>
                  <#if url.logoutUrl??>
                    <a class="btn btn-outline-secondary" href="${url.logoutUrl}">${msg("backToLogin")?no_esc}</a>
                  <#elseif url.loginRestartFlowUrl??>
                    <a class="btn btn-outline-secondary" href="${url.loginRestartFlowUrl}">${msg("backToLogin")?no_esc}</a>
                  <#else>
                    <a class="btn btn-outline-secondary" href="${url.loginUrl}">${msg("backToLogin")?no_esc}</a>
                  </#if>
                </#if>
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
