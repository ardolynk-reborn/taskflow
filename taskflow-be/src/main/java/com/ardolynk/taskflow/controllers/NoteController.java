package com.ardolynk.taskflow.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.model.NoteDTO;
import com.ardolynk.taskflow.services.NoteService;

import lombok.RequiredArgsConstructor;

import org.springframework.core.task.TaskRejectedException;
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;




@RestController
@RequestMapping("/api/notes")
@RequiredArgsConstructor
public class NoteController {

    private final NoteService service;

    @GetMapping
    public ResponseEntity<Page<NoteDTO>> getMethodName(
        @RequestParam(required = false) Long taskId,
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "10") int size,
        @RequestParam(defaultValue = "createdAt:desc") String[] sort
    ) {
        var result = service.getNotes(taskId, page, size, sort);
        return ResponseEntity.ok().body(result);
    }
 
    @PostMapping
    public ResponseEntity<NoteDTO> postMethodName(
        @AuthenticationPrincipal Jwt jwt,
        @RequestParam(required = true) long taskId,
        @RequestBody String text
    ) throws MissingEntityException {
        var result = service.newNote(jwt.getSubject(), taskId, text);
        return ResponseEntity.ok().body(result);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<NoteDTO> putMethodName(
        @PathVariable long id,
        @RequestBody String entity
    ) throws TaskRejectedException, NotFoundException {
        var result = service.updateNote(id, entity);
        return ResponseEntity.ok().body(result);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMethodName(@PathVariable long id) throws NotFoundException {
        service.deleteNote(id);
        return ResponseEntity.noContent().build();
    }
}