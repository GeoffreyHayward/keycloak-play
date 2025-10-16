<#-- Shared Bootstrap navbar with logo and realm name -->
<nav class="navbar navbar-light bg-white border-bottom">
  <div class="container">
    <a class="navbar-brand d-flex align-items-center" href="${url.loginUrl}">
      <img alt="Logo" src="${url.resourcesPath}/img/demo-logo.png" height="28" class="me-2"/>
      <span class="fw-semibold">${realm.displayNameHtml!realm.name}</span>
    </a>
  </div>
</nav>
