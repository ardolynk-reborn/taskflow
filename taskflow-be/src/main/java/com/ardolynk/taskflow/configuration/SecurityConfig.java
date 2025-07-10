package com.ardolynk.taskflow.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.server.resource.web.authentication.BearerTokenAuthenticationFilter;
import org.springframework.security.web.SecurityFilterChain;

@Configuration

public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, UserInitializationFilter userInitializationFilter) throws Exception {
        http.cors(Customizer.withDefaults()).authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/public/**", "/swagger-ui/**", "/v3/api-docs/**").permitAll()
                .requestMatchers("/api/admin/**").hasRole("ADMIN")
                .anyRequest().authenticated())
            .csrf(csrf -> csrf.disable())
            .oauth2ResourceServer(oauth2 -> oauth2.jwt(Customizer.withDefaults()));
            http.addFilterAfter(userInitializationFilter, BearerTokenAuthenticationFilter.class);
        return http.build();
    }
}
