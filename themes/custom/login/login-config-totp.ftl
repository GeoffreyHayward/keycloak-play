<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("loginTotpTitle")}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${url.resourcesPath}/css/styles.css" rel="stylesheet" />
  </head>
  <body class="bg-light" style="min-height: 100vh;">
    <#include "partials/navbar.ftl">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-sm-10 col-md-8 col-lg-7 col-xl-6">
          <div class="card shadow-sm">
            <div class="card-body p-4">
              <h1 class="h4 mb-3">${msg("loginTotpTitle")}</h1>

              <#if message?has_content>
                <div class="alert <#if message.type == 'error'>alert-danger<#elseif message.type == 'warning'>alert-warning<#else>alert-info</#if>">
                  ${message.summary}
                </div>
              </#if>

              <ol class="mb-4">
                <li>
                  <p class="mb-2">${msg("loginTotpStep1")}</p>
                  <ul>
                    <#list totp.supportedApplications as app>
                      <li>${msg(app)}</li>
                    </#list>
                  </ul>
                </li>

                <#if mode?? && mode == "manual"> 
                  <li>
                    <p class="mb-2">${msg("loginTotpManualStep2")}</p>
                    <p class="fw-semibold"><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                    <p><a href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                  </li>
                  <li>
                    <p class="mb-2">${msg("loginTotpManualStep3")}</p>
                    <ul>
                      <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                      <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                      <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                      <#if totp.policy.type == "totp">
                        <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                      <#elseif totp.policy.type == "hotp">
                        <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                      </#if>
                    </ul>
                  </li>
                <#else>
                  <li>
                    <p class="mb-2">${msg("loginTotpStep2")}</p>
                    <div class="text-center mb-2">
                      <img id="kc-totp-secret-qr-code" class="img-fluid" style="max-width: 220px" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="QR Code" />
                    </div>
                    <p><a href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                  </li>
                </#if>

                <li>
                  <p class="mb-2">${msg("loginTotpStep3")}</p>
                  <p class="mb-0">${msg("loginTotpStep3DeviceName")}</p>
                </li>
              </ol>

              <form id="kc-totp-settings-form" action="${url.loginAction}" method="post" novalidate>
                <div class="mb-3">
                  <label for="totp" class="form-label">${msg("authenticatorCode")} <span class="text-danger">*</span></label>
                  <input type="text" id="totp" name="totp" class="form-control" autocomplete="one-time-code" inputmode="numeric" dir="ltr" />
                  <#if messagesPerField?has_content && messagesPerField.existsError('totp')>
                    <div class="invalid-feedback d-block">${messagesPerField.get('totp')}</div>
                  </#if>
                </div>

                <div class="mb-3">
                  <label for="userLabel" class="form-label">${msg("loginTotpDeviceName")} <#if totp.otpCredentials?size gte 1><span class="text-danger">*</span></#if></label>
                  <input type="text" id="userLabel" name="userLabel" class="form-control" autocomplete="off" dir="ltr" />
                  <#if messagesPerField?has_content && messagesPerField.existsError('userLabel')>
                    <div class="invalid-feedback d-block">${messagesPerField.get('userLabel')}</div>
                  </#if>
                </div>

                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}" /></#if>

                <div class="d-flex gap-2">
                  <button type="submit" id="saveTOTPBtn" class="btn btn-primary">${msg("doSubmit")}</button>
                  <#if isAppInitiatedAction??>
                    <button type="submit" id="cancelTOTPBtn" name="cancel-aia" value="true" class="btn btn-outline-secondary">${msg("doCancel")}</button>
                  </#if>
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

