package com.ardolynk.taskflow.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.model.ProjectDTO;
import com.ardolynk.taskflow.model.ProjectRequest;
import com.ardolynk.taskflow.services.ProjectService;

import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;


@RestController
@RequestMapping("/api/projects")
@RequiredArgsConstructor
public class ProjectController {
    private final ProjectService dashboardService;

    @GetMapping
    public ResponseEntity<List<ProjectDTO>> getDashboard(@AuthenticationPrincipal Jwt jwt) {
        return ResponseEntity.ok().body(dashboardService.getProjects(jwt.getSubject()));
    }
    
    @GetMapping("/{projectId}")
    public ResponseEntity<ProjectDTO> getProject(@AuthenticationPrincipal Jwt jwt, @PathVariable long projectId) throws NotFoundException {
        return ResponseEntity.ok().body(dashboardService.getProject(projectId));
    }

    @PostMapping
    public ResponseEntity<ProjectDTO> newProject(@AuthenticationPrincipal Jwt jwt, @RequestBody ProjectRequest entity) throws MissingEntityException {
        return ResponseEntity.ok().body(dashboardService.newProject(jwt.getSubject(), entity));
    }
    
    @PutMapping("/{projectId}")
    public ResponseEntity<ProjectDTO> updateProject(@AuthenticationPrincipal Jwt jwt, @PathVariable long projectId, @RequestBody ProjectRequest entity) throws NotFoundException {
        return ResponseEntity.ok().body(dashboardService.updateProject(projectId, entity));
    }

    @DeleteMapping("/{projectId}")
    public ResponseEntity<Void> deleteProject(@AuthenticationPrincipal Jwt jwt, @PathVariable long projectId) throws NotFoundException {
        dashboardService.deleteProject(projectId);
        return ResponseEntity.noContent().build();
    }
}
