<#-- Bootstrap-based register page for Declarative User Profile -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${msg("registerTitle")!msg("doRegister")}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${url.resourcesPath}/css/styles.css" rel="stylesheet" />
  </head>
  <body class="bg-light" style="min-height: 100vh;">
    <#include "partials/navbar.ftl">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-sm-8 col-md-7 col-lg-6 col-xl-5">
          <div class="card shadow-sm">
            <div class="card-body p-4">
              

              <#if message?has_content>
                <div class="alert <#if message.type == 'error'>alert-danger<#elseif message.type == 'warning'>alert-warning<#else>alert-info</#if>" role="alert">
                  ${message.summary}
                </div>
              </#if>

              <form id="kc-register-form" action="${url.registrationAction}" method="post" novalidate>
                <#-- Dynamic attributes from user profile -->
                <#if attributes??>
                  <#list attributes as attr>
                    <#assign name = attr.name>
                    <#assign label = (attr.displayName!name)>
                    <#assign required = attr.required!?c>
                    <#assign type = (attr.annotations?has_content && attr.annotations["inputType"]??) ? then (attr.annotations["inputType"]) : ("text")>
                    <#assign autocomplete = (attr.autocomplete!"")>
                    <#assign value = (attr.value!"")>

                    <#-- Skip username if realm uses email as username -->
                    <#if name == 'username' && realm.registrationEmailAsUsername>
                      <#-- skip -->
                    <#else>
                      <div class="mb-3">
                        <#if type == 'checkbox'>
                          <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="${name}" name="${name}" <#if value?string == 'true' || value?string == 'on'>checked</#if> />
                            <label class="form-check-label" for="${name}">${label}<#if required=='true'> *</#if></label>
                          </div>
                        <#elseif type == 'textarea'>
                          <label class="form-label" for="${name}">${label}<#if required=='true'> *</#if></label>
                          <textarea id="${name}" name="${name}" class="form-control" rows="3" <#if autocomplete?has_content>autocomplete="${autocomplete}"</#if>>${value}</textarea>
                        <#else>
                          <label class="form-label" for="${name}">${label}<#if required=='true'> *</#if></label>
                          <input id="${name}" name="${name}" type="text" class="form-control" value="${value}" <#if autocomplete?has_content>autocomplete="${autocomplete}"</#if> />
                        </#if>
                      </div>
                    </#if>
                  </#list>
                </#if>

                <div class="mb-3">
                  <label class="form-label" for="password">${msg("password")}</label>
                  <input id="password" name="password" type="password" class="form-control" autocomplete="new-password" />
                </div>

                <div class="mb-3">
                  <label class="form-label" for="password-confirm">${msg("passwordConfirm")}</label>
                  <input id="password-confirm" name="password-confirm" type="password" class="form-control" autocomplete="new-password" />
                </div>

                <button class="btn btn-primary w-100" type="submit">${msg("doRegister")}</button>
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
