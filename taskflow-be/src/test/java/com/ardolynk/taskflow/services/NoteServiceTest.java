package com.ardolynk.taskflow.services;

import com.ardolynk.taskflow.dao.NoteEntity;
import com.ardolynk.taskflow.dao.UserEntity;
import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.exceptions.UserMismatchException;
import com.ardolynk.taskflow.mappers.NoteMapper;
import com.ardolynk.taskflow.model.NoteDTO;
import com.ardolynk.taskflow.repositories.NoteRepository;
import com.ardolynk.taskflow.repositories.UserRepository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

public class NoteServiceTest {

    private NoteRepository noteRepository;
    private UserRepository userRepository;
    private NoteMapper noteMapper;
    private NoteService noteService;

    @BeforeEach
    void setUp() {
        noteRepository = mock(NoteRepository.class);
        userRepository = mock(UserRepository.class);
        noteMapper = mock(NoteMapper.class);
        noteService = new NoteService(noteRepository, userRepository, noteMapper);
    }

    @SuppressWarnings("unchecked")
    @Test
    void getNotes_shouldReturnPagedResults() {
        NoteEntity entity = NoteEntity.builder()
                .id(1L)
                .note("Sample Note")
                .taskId(5L)
                .build();

        NoteDTO dto = NoteDTO.builder().id(1L).note("Sample Note").build();

        Page<NoteEntity> page = new PageImpl<>(List.of(entity));
        when(noteRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(page);
        when(noteMapper.toDto(entity)).thenReturn(dto);

        Page<NoteDTO> result = noteService.getNotes(5L, 0, 10, new String[]{"id:asc"});

        assertThat(result).hasSize(1);
        assertThat(result.getContent().get(0).getNote()).isEqualTo("Sample Note");

        verify(noteRepository).findAll(any(Specification.class), any(Pageable.class));
    }

    @SuppressWarnings("unchecked")
    @Test
    void getNotes_shouldReturnEmptyPageIfNoResults() {
        when(noteRepository.findAll(any(Specification.class), any(Pageable.class))).thenReturn(Page.empty());

        Page<NoteDTO> result = noteService.getNotes(5L, 0, 10, new String[]{"id:asc"});

        assertThat(result).isEmpty();
    }

    @Test
    void getNote_shouldReturnNoteDto() throws NotFoundException {
        NoteEntity entity = NoteEntity.builder().id(2L).note("Test Note").build();
        NoteDTO dto = NoteDTO.builder().id(2L).note("Test Note").build();

        when(noteRepository.findById(2L)).thenReturn(Optional.of(entity));
        when(noteMapper.toDto(entity)).thenReturn(dto);

        NoteDTO result = noteService.getNote(2L);

        assertThat(result.getId()).isEqualTo(2L);
        assertThat(result.getNote()).isEqualTo("Test Note");
    }

    @Test
    void getNote_shouldThrowNotFound() {
        when(noteRepository.findById(anyLong())).thenReturn(Optional.empty());

        assertThatThrownBy(() -> noteService.getNote(1L))
                .isInstanceOf(NotFoundException.class);
    }

    @Test
    void newNote_shouldCreateNote() throws MissingEntityException {
        String keycloakId = "user-123";
        long taskId = 99L;
        String text = "New note";

        UserEntity user = new UserEntity();
        user.setId(1L);
        user.setKeycloakId(keycloakId);

        NoteEntity saved = NoteEntity.builder().id(10L).note(text).user(user).taskId(taskId).build();
        NoteDTO dto = NoteDTO.builder().id(10L).note(text).build();

        when(userRepository.findByKeycloakId(keycloakId)).thenReturn(user);
        when(noteRepository.save(any(NoteEntity.class))).thenReturn(saved);
        when(noteMapper.toDto(saved)).thenReturn(dto);

        NoteDTO result = noteService.newNote(keycloakId, taskId, text);

        assertThat(result.getId()).isEqualTo(10L);
        assertThat(result.getNote()).isEqualTo(text);
    }

    @Test
    void updateNote_shouldUpdateText() throws NotFoundException, UserMismatchException {
        String keycloakId = "user-123";
        String newText = "Updated note";

        UserEntity user = new UserEntity();
        user.setKeycloakId(keycloakId);

        NoteEntity entity = NoteEntity.builder()
                .id(1L)
                .note("Old note")
                .user(user)
                .build();

        NoteEntity saved = NoteEntity.builder()
                .id(1L)
                .note(newText)
                .user(user)
                .build();

        NoteDTO dto = NoteDTO.builder().id(1L).note(newText).build();

        when(noteRepository.findById(1L)).thenReturn(Optional.of(entity));
        when(noteRepository.save(any(NoteEntity.class))).thenReturn(saved);
        when(noteMapper.toDto(saved)).thenReturn(dto);

        NoteDTO result = noteService.updateNote(keycloakId, 1L, newText);

        assertThat(result.getNote()).isEqualTo(newText);
    }

    @Test
    void updateNote_shouldThrowUserMismatch() {
        NoteEntity entity = NoteEntity.builder()
                .id(1L)
                .note("Something")
                .user(UserEntity.builder().keycloakId("different-id").build())
                .build();

        when(noteRepository.findById(1L)).thenReturn(Optional.of(entity));

        assertThatThrownBy(() -> noteService.updateNote("wrong-id", 1L, "text"))
                .isInstanceOf(UserMismatchException.class);
    }

    @Test
    void updateNote_shouldThrowNotFound() {
        when(noteRepository.findById(1L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> noteService.updateNote("any", 1L, "text"))
                .isInstanceOf(NotFoundException.class);
    }

    @Test
    void deleteNote_shouldDeleteNote() throws NotFoundException, UserMismatchException {
        String keycloakId = "user-123";

        NoteEntity entity = NoteEntity.builder()
                .id(1L)
                .note("To delete")
                .user(UserEntity.builder().keycloakId(keycloakId).build())
                .build();

        when(noteRepository.findById(1L)).thenReturn(Optional.of(entity));

        noteService.deleteNote(keycloakId, 1L);

        verify(noteRepository).delete(entity);
    }

    @Test
    void deleteNote_shouldThrowUserMismatch() {
        NoteEntity entity = NoteEntity.builder()
                .id(1L)
                .user(UserEntity.builder().keycloakId("original-user").build())
                .build();

        when(noteRepository.findById(1L)).thenReturn(Optional.of(entity));

        assertThatThrownBy(() -> noteService.deleteNote("unauthorized", 1L))
                .isInstanceOf(UserMismatchException.class);
    }

    @Test
    void deleteNote_shouldThrowNotFound() {
        when(noteRepository.findById(1L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> noteService.deleteNote("any", 1L))
                .isInstanceOf(NotFoundException.class);
    }
}
