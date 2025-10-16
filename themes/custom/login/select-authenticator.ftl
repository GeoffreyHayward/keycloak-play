<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("loginChooseAuthenticator")}</title>
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
              <h1 class="h5 mb-3">${msg("loginChooseAuthenticator")}</h1>

              <#if message?has_content>
                <div class="alert <#if message.type == 'error'>alert-danger<#elseif message.type == 'warning'>alert-warning<#else>alert-info</#if>">
                  ${message.summary}
                </div>
              </#if>

              <form id="kc-select-credential-form" action="${url.loginAction}" method="post">
                <div class="list-group">
                  <#list auth.authenticationSelections as authenticationSelection>
                    <button type="submit" name="authenticationExecution" value="${authenticationSelection.authExecId}"
                            class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                      <div>
                        <div class="fw-semibold">${msg('${authenticationSelection.displayName}')}</div>
                        <div class="small text-muted">${msg('${authenticationSelection.helpText}')}</div>
                      </div>
                      <span class="ms-3">&rsaquo;</span>
                    </button>
                  </#list>
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

