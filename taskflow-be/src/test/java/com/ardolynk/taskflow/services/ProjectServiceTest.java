package com.ardolynk.taskflow.services;

import com.ardolynk.taskflow.model.ProjectDTO;
import com.ardolynk.taskflow.model.ProjectRequest;
import com.ardolynk.taskflow.dao.ProjectEntity;
import com.ardolynk.taskflow.dao.UserEntity;
import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.exceptions.UserMismatchException;
import com.ardolynk.taskflow.mappers.ProjectMapper;
import com.ardolynk.taskflow.repositories.ProjectRepository;
import com.ardolynk.taskflow.repositories.UserRepository;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;
import static org.assertj.core.api.Assertions.*;

import java.util.*;

import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;

public class ProjectServiceTest {

    private ProjectRepository projectRepository;
    private UserRepository userRepository;
    private ProjectMapper mapper;
    private ProjectService projectService;

    @BeforeEach
    void setUp() {
        projectRepository = mock(ProjectRepository.class);
        userRepository = mock(UserRepository.class);
        mapper = mock(ProjectMapper.class);
        projectService = new ProjectService(userRepository, projectRepository, mapper);
    }

    @SuppressWarnings("unchecked")
    @Test
    void getProjects_shouldReturnPagedResults() {
        // Given
        ProjectEntity entity = ProjectEntity.builder()
                .id(1L)
                .name("Project 1")
                .description("Description")
                .build();

        Page<ProjectEntity> page = new PageImpl<>(List.of(entity));

        when(projectRepository.findAll(any(Specification.class), any(Pageable.class)))
                .thenReturn(page);

        ProjectDTO dto = ProjectDTO.builder().id(1L).name("Project 1").build();
        when(mapper.toDto(entity)).thenReturn(dto);

        // When
        Page<ProjectDTO> result = projectService.getProjects(
                null,
                null,
                null,
                null,
                0,
                10,
                new String[] { "name:asc" }
        );

        // Then
        assertThat(result).hasSize(1);
        assertThat(result.getContent().get(0).getName()).isEqualTo("Project 1");

        verify(projectRepository).findAll(any(Specification.class), any(Pageable.class));
    }

    @Test
    void getProject_shouldReturnProjectDto() throws NotFoundException {
        // Given
        ProjectEntity entity = ProjectEntity.builder()
                .id(42L)
                .name("Test Project")
                .build();

        when(projectRepository.findById(42L)).thenReturn(Optional.of(entity));

        ProjectDTO dto = ProjectDTO.builder().id(42L).name("Test Project").build();
        when(mapper.toDto(entity)).thenReturn(dto);

        // When
        ProjectDTO result = projectService.getProject(42L);

        // Then
        assertThat(result.getId()).isEqualTo(42L);
        assertThat(result.getName()).isEqualTo("Test Project");
    }

    @Test
    void getProject_shouldThrowNotFound() {
        when(projectRepository.findById(anyLong())).thenReturn(Optional.empty());

        assertThatThrownBy(() -> projectService.getProject(1L))
                .isInstanceOf(NotFoundException.class);
    }

    @Test
    void newProject_shouldCreateProject() throws MissingEntityException {
        // Given
        String keycloakId = "abc-123";
        ProjectRequest request = ProjectRequest.builder().name("New Project").description("Description").build();

        UserEntity owner = new UserEntity();
        owner.setId(10L);
        owner.setKeycloakId(keycloakId);

        ProjectEntity savedEntity = ProjectEntity.builder()
                .id(99L)
                .name("New Project")
                .description("Description")
                .owner(owner)
                .build();

        ProjectDTO dto = ProjectDTO.builder().id(99L).name("New Project").build();

        when(userRepository.findByKeycloakId(keycloakId)).thenReturn(owner);
        when(projectRepository.save(any(ProjectEntity.class))).thenReturn(savedEntity);
        when(mapper.toDto(savedEntity)).thenReturn(dto);

        // When
        ProjectDTO result = projectService.newProject(keycloakId, request);

        // Then
        assertThat(result.getId()).isEqualTo(99L);
        assertThat(result.getName()).isEqualTo("New Project");

        verify(projectRepository).save(any(ProjectEntity.class));
    }

    @Test
    void newProject_shouldThrowMissingEntity() {
        when(userRepository.findByKeycloakId(anyString())).thenReturn(null);

        ProjectRequest request = ProjectRequest.builder().name("Test").description("Test").build();

        assertThatThrownBy(() -> projectService.newProject("abc-123", request))
                .isInstanceOf(MissingEntityException.class);
    }

    @Test
    void updateProject_shouldUpdateFields() throws NotFoundException, UserMismatchException {
        // Given
        String keycloakId = "abc-123";
        ProjectEntity entity = ProjectEntity.builder()
                .id(1L)
                .name("Old Name")
                .description("Old Description")
                .owner(UserEntity.builder().keycloakId(keycloakId).build())
                .build();

        when(projectRepository.findById(1L)).thenReturn(Optional.of(entity));

        ProjectRequest request = ProjectRequest.builder().name("New Name").description("New Description").build();

        ProjectEntity savedEntity = ProjectEntity.builder()
                .id(1L)
                .name("New Name")
                .description("New Description")
                .owner(entity.getOwner())
                .build();

        ProjectDTO dto = ProjectDTO.builder().id(1L).name("New Name").build();

        when(projectRepository.save(any(ProjectEntity.class))).thenReturn(savedEntity);
        when(mapper.toDto(savedEntity)).thenReturn(dto);

        // When
        ProjectDTO result = projectService.updateProject(keycloakId, 1L, request);

        // Then
        assertThat(result.getId()).isEqualTo(1L);
        assertThat(result.getName()).isEqualTo("New Name");
    }

    @Test
    void updateProject_shouldThrowNotFound() {
        when(projectRepository.findById(anyLong())).thenReturn(Optional.empty());

        ProjectRequest request = ProjectRequest.builder().name("X").build();

        assertThatThrownBy(() ->
                projectService.updateProject("abc", 1L, request)
        ).isInstanceOf(NotFoundException.class);
    }

    @Test
    void updateProject_shouldThrowUserMismatch() {
        ProjectEntity entity = ProjectEntity.builder()
                .id(1L)
                .name("Project")
                .owner(UserEntity.builder().keycloakId("owner-id").build())
                .build();

        when(projectRepository.findById(1L)).thenReturn(Optional.of(entity));

        ProjectRequest request = ProjectRequest.builder().name("Updated Name").build();

        assertThatThrownBy(() ->
                projectService.updateProject("different-user", 1L, request)
        ).isInstanceOf(UserMismatchException.class);
    }

    @Test
    void deleteProject_shouldDeleteWhenOwnerMatches() throws NotFoundException, UserMismatchException {
        String keycloakId = "abc-123";
        ProjectEntity entity = ProjectEntity.builder()
                .id(1L)
                .name("Test Project")
                .owner(UserEntity.builder().keycloakId(keycloakId).build())
                .build();

        when(projectRepository.findById(1L)).thenReturn(Optional.of(entity));

        // When
        projectService.deleteProject(keycloakId, 1L);

        // Then
        verify(projectRepository).delete(entity);
    }

    @Test
    void deleteProject_shouldThrowUserMismatch() {
        ProjectEntity entity = ProjectEntity.builder()
                .id(1L)
                .name("Test Project")
                .owner(UserEntity.builder().keycloakId("owner-id").build())
                .build();

        when(projectRepository.findById(1L)).thenReturn(Optional.of(entity));

        assertThatThrownBy(() ->
                projectService.deleteProject("other-user", 1L)
        ).isInstanceOf(UserMismatchException.class);
    }

    @Test
    void deleteProject_shouldThrowNotFound() {
        when(projectRepository.findById(anyLong())).thenReturn(Optional.empty());

        assertThatThrownBy(() ->
                projectService.deleteProject("abc", 1L)
        ).isInstanceOf(NotFoundException.class);
    }
}
