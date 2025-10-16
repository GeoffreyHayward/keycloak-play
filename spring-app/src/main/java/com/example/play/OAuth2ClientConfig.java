package com.example.play;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;

@Configuration
public class OAuth2ClientConfig {

    @Bean
    ClientRegistrationRepository clientRegistrationRepository(Environment env,
            @Value("${spring.security.oauth2.client.registration.keycloak.client-id}") String clientId,
            @Value("${spring.security.oauth2.client.registration.keycloak.client-authentication-method:none}") String authMethod,
            @Value("${spring.security.oauth2.client.registration.keycloak.redirect-uri:{baseUrl}/login/oauth2/code/{registrationId}}") String redirectUri,
            @Value("${spring.security.oauth2.client.registration.keycloak.scope:openid,profile,email}") String scopesCsv,
            @Value("${spring.security.oauth2.client.provider.keycloak.authorization-uri}") String authorizationUri,
            @Value("${spring.security.oauth2.client.provider.keycloak.token-uri}") String tokenUri,
            @Value("${spring.security.oauth2.client.provider.keycloak.jwk-set-uri}") String jwkSetUri,
            @Value("${spring.security.oauth2.client.provider.keycloak.user-info-uri}") String userInfoUri,
            @Value("${spring.security.oauth2.client.provider.keycloak.user-name-attribute:sub}") String userNameAttribute,
            @Value("${spring.security.oauth2.client.registration.keycloak.client-secret:}") String clientSecret,
            @Value("${spring.security.oauth2.client.provider.keycloak.end-session-uri:http://localhost:8080/auth/realms/play/protocol/openid-connect/logout}") String endSessionUri
    ) {
        List<String> scopes = Arrays.asList(scopesCsv.split("\\s*,\\s*"));

        ClientAuthenticationMethod cam = ClientAuthenticationMethod.NONE;
        if ("client_secret_basic".equalsIgnoreCase(authMethod)) {
            cam = ClientAuthenticationMethod.CLIENT_SECRET_BASIC;
        } else if ("client_secret_post".equalsIgnoreCase(authMethod)) {
            cam = ClientAuthenticationMethod.CLIENT_SECRET_POST;
        }

        Map<String, Object> metadata = new HashMap<>();
        metadata.put("end_session_endpoint", endSessionUri);

        ClientRegistration registration = ClientRegistration
                .withRegistrationId("keycloak")
                .clientId(clientId)
                .clientSecret(clientSecret)
                .clientAuthenticationMethod(cam)
                .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
                .redirectUri(redirectUri)
                .scope(scopes)
                .authorizationUri(authorizationUri)
                .tokenUri(tokenUri)
                .jwkSetUri(jwkSetUri)
                .userInfoUri(userInfoUri)
                .userNameAttributeName(userNameAttribute)
                .providerConfigurationMetadata(metadata)
                .build();

        return new InMemoryClientRegistrationRepository(registration);
    }
}


