package com.ardolynk.taskflow.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.model.ProjectDTO;
import com.ardolynk.taskflow.model.ProjectRequest;
import com.ardolynk.taskflow.services.ProjectService;

import lombok.RequiredArgsConstructor;

import java.time.Instant;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.format.annotation.DateTimeFormat;
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
    private Logger logger = LoggerFactory.getLogger(ProjectController.class);

    @GetMapping
    public ResponseEntity<Page<ProjectDTO>> getDashboard(
        @AuthenticationPrincipal Jwt jwt,
        @RequestParam(required = false) Boolean mineOnly,
        @RequestParam(required = false) String searchString,
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) Instant since,
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) Instant before,

        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size,
        @RequestParam(defaultValue = "createdAt:desc") String[] sort
    ) {
        logger.info("Getting projects");
        return ResponseEntity.ok().body(dashboardService.getProjects(
            (mineOnly != null && mineOnly) ? jwt.getSubject() : null,
            searchString,
            since,
            before,

            page,
            size,
            sort
        ));
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
