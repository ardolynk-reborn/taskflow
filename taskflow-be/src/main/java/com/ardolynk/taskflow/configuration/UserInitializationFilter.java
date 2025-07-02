package com.ardolynk.taskflow.configuration;

import java.io.IOException;

import org.springframework.lang.NonNull;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.ardolynk.taskflow.repositories.UserRepository;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class UserInitializationFilter extends OncePerRequestFilter {

    private final UserRepository repository;

    @Override
    protected void doFilterInternal(@NonNull HttpServletRequest request, @NonNull HttpServletResponse response, @NonNull FilterChain filterChain)
            throws ServletException, IOException {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication instanceof JwtAuthenticationToken jwtAuth) {
            String keycloakId = jwtAuth.getToken().getSubject();
            if (repository.findByKeycloakId(keycloakId) == null) {
                String username = jwtAuth.getTokenAttributes().get("preferred_username").toString();
                String email = jwtAuth.getTokenAttributes().get("email").toString();
                repository.save(com.ardolynk.taskflow.dao.UserEntity.builder()
                    .keycloakId(keycloakId)
                    .username(username)
                    .email(email)
                    .build());
            }
            filterChain.doFilter(request, response);
        }
    }
}