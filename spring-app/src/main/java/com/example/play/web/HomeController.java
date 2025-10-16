package com.example.play.web;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.Duration;
import java.time.Instant;
import java.util.Map;

@Controller
public class HomeController {

    private final OAuth2AuthorizedClientService clientService;

    public HomeController(OAuth2AuthorizedClientService clientService) {
        this.clientService = clientService;
    }

    @Value("${app.keycloak.url:http://localhost:8080/auth}")
    private String kcUrl;

    @Value("${app.keycloak.realm:play}")
    private String kcRealm;

    @Value("${app.keycloak.client:spring-client}")
    private String kcClient;

    @GetMapping("/")
    public String home(Model model, @AuthenticationPrincipal OidcUser oidcUser) {
        boolean authenticated = oidcUser != null;
        model.addAttribute("authenticated", authenticated);

        if (authenticated) {
            String username = oidcUser.getPreferredUsername();
            String email = oidcUser.getEmail();
            Instant exp = oidcUser.getIdToken().getExpiresAt();
            long expiresIn = exp != null ? Math.max(0, Duration.between(Instant.now(), exp).getSeconds()) : -1;

            model.addAttribute("username", username);
            model.addAttribute("email", email);
            model.addAttribute("expiresIn", expiresIn);
        }

        model.addAttribute("envUrl", kcUrl);
        model.addAttribute("envRealm", kcRealm);
        model.addAttribute("envClient", kcClient);
        String accountUrl = kcUrl + "/realms/" + kcRealm + "/account";
        model.addAttribute("accountUrl", accountUrl);

        return "index";
    }
}
