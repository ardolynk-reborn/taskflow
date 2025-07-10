package com.ardolynk.taskflow.services;

import com.ardolynk.taskflow.dao.NoteEntity;
import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.exceptions.UserMismatchException;
import com.ardolynk.taskflow.mappers.NoteMapper;
import com.ardolynk.taskflow.model.NoteDTO;
import com.ardolynk.taskflow.repositories.NoteRepository;
import com.ardolynk.taskflow.repositories.UserRepository;
import com.ardolynk.taskflow.specifications.NoteSpecifications;

import lombok.RequiredArgsConstructor;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class NoteService {

    private final NoteRepository noteRepository;
    private final UserRepository userRepository;
    private final NoteMapper mapper;

    public Page<NoteDTO> getNotes(
        Long taskId,
     
        int page,
        int size,
        String[] sort
    ) {
        List<Specification<NoteEntity>> specs = new ArrayList<>();
        if (taskId != null) {
            specs.add(NoteSpecifications.byTaskId(taskId));
        }

        List<Sort.Order> orders = new ArrayList<>();
        for (String sortOrder : sort) {
            String[] _sort = sortOrder.split(":");
            orders.add(new Sort.Order((_sort. length > 1 && _sort[1].equalsIgnoreCase("desc"))
                    ? Sort.Direction.DESC
                    : Sort.Direction.ASC,
                _sort[0]));
        }

        var result = noteRepository.findAll(
            Specification.allOf(specs),
            PageRequest.of(page, size, Sort.by(orders))
        );
        
        if (result.getContent().isEmpty()) {
        return Page.empty();
}
        return result.map(mapper::toDto);
    }

    public NoteDTO getNote(long id) throws NotFoundException {
        NoteEntity note = noteRepository.findById(id).orElseThrow(() -> new NotFoundException());
        return mapper.toDto(note);
    }

    public NoteDTO newNote(String keycloakId, long taskId, String text) throws MissingEntityException {
        NoteEntity note = NoteEntity.builder()
            .user(userRepository.findByKeycloakId(keycloakId))
            .taskId(taskId)
            .note(text)
            .build();
        note = noteRepository.save(note);
        return mapper.toDto(note);
    }

    public NoteDTO updateNote(String keycloakId, long id, String text) throws NotFoundException, UserMismatchException {
        NoteEntity note = noteRepository.findById(id).orElseThrow(() -> new NotFoundException());
        if (!note.getUser().getKeycloakId().equals(keycloakId)) {
            throw new UserMismatchException("You don't have permission to update this note");
        }
        note.setNote(text);
        note = noteRepository.save(note);
        return mapper.toDto(note);
    }

    public void deleteNote(String keycloakId, long id) throws NotFoundException, UserMismatchException {
        NoteEntity note = noteRepository.findById(id).orElseThrow(() -> new NotFoundException());
        if (!note.getUser().getKeycloakId().equals(keycloakId)) {
            throw new UserMismatchException("You don't have permission to delete this note");
        }
        noteRepository.delete(note);
    }
}
