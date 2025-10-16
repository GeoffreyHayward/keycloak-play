<#-- Custom email layout with simple, inline-styled header and footer. -->
<#macro emailLayout>
<html>
  <body style="margin:0;padding:0;background-color:#f6f7f9;">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#f6f7f9;padding:24px 0;">
      <tr>
        <td align="center">
          <table role="presentation" width="600" cellspacing="0" cellpadding="0" border="0" style="background:#ffffff;border-radius:8px;overflow:hidden;font-family:Segoe UI, Roboto, Helvetica, Arial, sans-serif;color:#0f172a;">
            <tr>
              <td style="padding:16px 20px;border-bottom:1px solid #e5e7eb;">
                <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0">
                  <tr>
                    <td valign="middle" style="width:40px;">
                      <#if properties.emailLogoUrl?has_content>
                        <img src="${properties.emailLogoUrl}" alt="Logo" width="32" height="32" style="display:block;border:0;width:32px;height:32px;" />
                      <#elseif properties.emailLogoDataUri?has_content>
                        <img src="${properties.emailLogoDataUri}" alt="Logo" width="32" height="32" style="display:block;border:0;width:32px;height:32px;" />
                      <#else>
                        <span style="display:inline-block;width:32px;height:32px;border-radius:6px;background:#e5e7eb;"></span>
                      </#if>
                    </td>
                    <td valign="middle" style="text-align:left;font-size:16px;font-weight:600;">${realmName!""}</td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td style="padding:24px;">
                <#nested>
              </td>
            </tr>
            <tr>
              <td style="padding:16px 20px;border-top:1px solid #e5e7eb;color:#64748b;font-size:12px;">
                <div>
                  <span>${realmName!""}</span>
                </div>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </body>
  </html>
</#macro>
