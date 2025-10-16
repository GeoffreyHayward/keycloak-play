<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("doLogIn")}</title>
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
              <h1 class="h4 mb-3">${msg("doLogIn")}</h1>

              <#if message?has_content>
                <div class="alert <#if message.type == 'error'>alert-danger<#elseif message.type == 'warning'>alert-warning<#else>alert-info</#if>">
                  ${message.summary}
                </div>
              </#if>

              <form id="kc-otp-login-form" action="${url.loginAction}" method="post" onsubmit="login.disabled = true; return true;" novalidate>
                <#if otpLogin.userOtpCredentials?size gt 1>
                  <div class="mb-3">
                    <label class="form-label">${msg("loginOtpOneTime")}</label>
                    <#list otpLogin.userOtpCredentials as otpCredential>
                      <div class="form-check">
                        <input class="form-check-input" type="radio" id="kc-otp-credential-${otpCredential?index}" name="selectedCredentialId" value="${otpCredential.id}" <#if otpCredential.id == otpLogin.selectedCredentialId>checked</#if> />
                        <label class="form-check-label" for="kc-otp-credential-${otpCredential?index}">${otpCredential.userLabel}</label>
                      </div>
                    </#list>
                  </div>
                </#if>

                <div class="mb-3">
                  <label for="otp" class="form-label">${msg("loginOtpOneTime")}</label>
                  <input id="otp" name="otp" type="text" class="form-control" autocomplete="one-time-code" dir="ltr" />
                  <#if messagesPerField?has_content && messagesPerField.existsError('totp')>
                    <div class="invalid-feedback d-block">${messagesPerField.get('totp')}</div>
                  </#if>
                </div>

                <div class="d-grid">
                  <input class="btn btn-primary" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}" />
                </div>
              </form>
              <div class="text-center mt-3">
                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                  <input type="hidden" name="tryAnotherWay" value="on" />
                  <a href="#" class="link-secondary" onclick="document.getElementById('kc-select-try-another-way-form').submit();return false;">${msg("doTryAnotherWay")}</a>
                </form>
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
