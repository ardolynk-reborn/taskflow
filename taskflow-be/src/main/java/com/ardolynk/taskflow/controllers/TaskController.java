package com.ardolynk.taskflow.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ardolynk.taskflow.dao.TaskStatus;
import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.model.TaskDTO;
import com.ardolynk.taskflow.model.TaskRequest;
import com.ardolynk.taskflow.services.TaskService;

import lombok.RequiredArgsConstructor;

import java.time.Instant;
import java.util.List;

import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/api/tasks")
@RequiredArgsConstructor
public class TaskController {

    private final TaskService taskService;

    @GetMapping
    public ResponseEntity<List<TaskDTO>> getAssignedTasks(
        @AuthenticationPrincipal Jwt jwt,
        @RequestParam(required = false) Boolean mineOnly,
        @RequestParam(required = false) Long projectId,
        @RequestParam(required = false) TaskStatus[] statuses,
        @RequestParam(required = false) String searchString,
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) Instant since,
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) Instant before
    ) {
        return ResponseEntity.ok().body(taskService.getTasks(
            (mineOnly != null && mineOnly) ? jwt.getSubject() : null,
            projectId,
            statuses,
            searchString,
            since,
            before
        ));
    }
    
    @GetMapping("/{taskId}")
    public ResponseEntity<TaskDTO> getTask(@AuthenticationPrincipal Jwt jwt, @PathVariable long taskId) throws NotFoundException {
        return ResponseEntity.ok().body(taskService.getTask(taskId));
    }
    
    @PostMapping
    public ResponseEntity<TaskDTO> newTask(@AuthenticationPrincipal Jwt jwt, @RequestParam long projectId, @RequestBody TaskRequest entity) throws MissingEntityException {
        return ResponseEntity.ok().body(taskService.newTask(projectId, entity));
    }

    @PutMapping("/{taskId}")
    public ResponseEntity<TaskDTO> updateTask(@AuthenticationPrincipal Jwt jwt, @PathVariable long taskId, @RequestBody TaskRequest entity) throws MissingEntityException {
        return ResponseEntity.ok().body(taskService.updateTask(taskId, entity));
    }

    @DeleteMapping("/{taskId}")
    public ResponseEntity<Void> deleteTask(@AuthenticationPrincipal Jwt jwt, @PathVariable long taskId) throws NotFoundException {
        taskService.deleteTask(taskId);
        return ResponseEntity.noContent().build();
    }
}
