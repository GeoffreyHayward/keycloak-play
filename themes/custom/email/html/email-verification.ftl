<#import "template.ftl" as layout>
<@layout.emailLayout>
  <h1 style="margin:0 0 12px;font-size:20px;">${msg("emailVerifyTitle")!"Verify your email"}</h1>
  <p style="margin:0 0 16px;line-height:1.5;color:#334155;">
    ${msg("emailVerificationBodyHtml", link, linkExpiration, realmName, linkExpirationFormatter(linkExpiration))?no_esc}
  </p>
  <div style="margin:20px 0;">
    <a href="${link}"
       style="display:inline-block;background:#2563eb;color:#ffffff;text-decoration:none;padding:10px 16px;border-radius:6px;font-weight:600;"
    >${msg("verifyEmailAction")!"Verify Email"}</a>
  </div>
  <p style="margin:16px 0 0;color:#64748b;font-size:12px;">${msg("emailLinkButtonAlternative")!"If the button doesn’t work, copy and paste this URL into your browser:"}</p>
  <p style="margin:8px 0 0;word-break:break-all;color:#334155;font-size:12px;">${link}</p>
</@layout.emailLayout>

