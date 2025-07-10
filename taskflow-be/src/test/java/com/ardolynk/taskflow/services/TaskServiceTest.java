package com.ardolynk.taskflow.services;

import com.ardolynk.taskflow.dao.*;
import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.exceptions.UserMismatchException;
import com.ardolynk.taskflow.mappers.TaskMapper;
import com.ardolynk.taskflow.model.TaskDTO;
import com.ardolynk.taskflow.model.TaskRequest;
import com.ardolynk.taskflow.repositories.ProjectRepository;
import com.ardolynk.taskflow.repositories.TaskRepository;
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

public class TaskServiceTest {

    private TaskRepository taskRepository;
    private ProjectRepository projectRepository;
    private UserRepository userRepository;
    private TaskMapper mapper;
    private TaskService taskService;

    @BeforeEach
    void setUp() {
        taskRepository = mock(TaskRepository.class);
        projectRepository = mock(ProjectRepository.class);
        userRepository = mock(UserRepository.class);
        mapper = mock(TaskMapper.class);
        taskService = new TaskService(taskRepository, projectRepository, userRepository, mapper);
    }

    @SuppressWarnings("unchecked")
    @Test
    void getTasks_shouldReturnPagedResults() {
        // Given
        TaskEntity entity = TaskEntity.builder()
                .id(1L)
                .name("Task 1")
                .build();

        Page<TaskEntity> page = new PageImpl<>(List.of(entity));

        when(taskRepository.findAll(any(Specification.class), any(Pageable.class)))
                .thenReturn(page);

        TaskDTO dto = TaskDTO.builder().id(1L).name("Task 1").build();
        when(mapper.toDto(entity)).thenReturn(dto);

        // When
        Page<TaskDTO> result = taskService.getTasks(
                null,
                null,
                null,
                null,
                null,
                null,
                0,
                10,
                new String[] {"name:asc"}
        );

        // Then
        assertThat(result).hasSize(1);
        assertThat(result.getContent().get(0).getName()).isEqualTo("Task 1");

        verify(taskRepository).findAll(any(Specification.class), any(Pageable.class));
    }

    @Test
    void getTask_shouldReturnTaskDto() {
        // Given
        TaskEntity entity = TaskEntity.builder()
                .id(42L)
                .name("Test Task")
                .build();

        when(taskRepository.findById(42L)).thenReturn(Optional.of(entity));

        TaskDTO dto = TaskDTO.builder().id(42L).name("Test Task").build();
        when(mapper.toDto(entity)).thenReturn(dto);

        // When
        TaskDTO result = taskService.getTask(42L);

        // Then
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(42L);
        assertThat(result.getName()).isEqualTo("Test Task");
    }

    @Test
    void getTask_shouldReturnNull_whenNotFound() {
        when(taskRepository.findById(anyLong())).thenReturn(Optional.empty());

        TaskDTO result = taskService.getTask(1L);

        assertThat(result).isNull();
    }

    @Test
    void newTask_shouldCreateTaskWithoutAssignee() throws MissingEntityException {
        // Given
        ProjectEntity project = ProjectEntity.builder()
                .id(10L)
                .name("My Project")
                .build();

        when(projectRepository.findById(10L)).thenReturn(Optional.of(project));

        TaskRequest request = TaskRequest.builder()
                .name("New Task")
                .description("Description")
                .build();

        TaskEntity savedEntity = TaskEntity.builder()
                .id(99L)
                .name("New Task")
                .description("Description")
                .project(project)
                .status(TaskStatus.TODO)
                .build();

        TaskDTO dto = TaskDTO.builder().id(99L).name("New Task").build();

        when(taskRepository.save(any(TaskEntity.class))).thenReturn(savedEntity);
        when(mapper.toDto(savedEntity)).thenReturn(dto);

        // When
        TaskDTO result = taskService.newTask(10L, request);

        // Then
        assertThat(result.getId()).isEqualTo(99L);
        assertThat(result.getName()).isEqualTo("New Task");

        verify(taskRepository).save(any(TaskEntity.class));
    }

    @Test
    void newTask_shouldCreateTaskWithAssignee() throws MissingEntityException {
        // Given
        ProjectEntity project = ProjectEntity.builder()
                .id(10L)
                .name("My Project")
                .build();

        UserEntity assignee = UserEntity.builder()
                .id(5L)
                .keycloakId("user-123")
                .build();

        when(projectRepository.findById(10L)).thenReturn(Optional.of(project));
        when(userRepository.findById(5L)).thenReturn(Optional.of(assignee));

        TaskRequest request = TaskRequest.builder()
                .name("New Task")
                .description("Description")
                .assigneeId(5L)
                .build();

        TaskEntity savedEntity = TaskEntity.builder()
                .id(99L)
                .name("New Task")
                .description("Description")
                .project(project)
                .assignee(assignee)
                .status(TaskStatus.TODO)
                .build();

        TaskDTO dto = TaskDTO.builder().id(99L).name("New Task").build();

        when(taskRepository.save(any(TaskEntity.class))).thenReturn(savedEntity);
        when(mapper.toDto(savedEntity)).thenReturn(dto);

        // When
        TaskDTO result = taskService.newTask(10L, request);

        // Then
        assertThat(result.getId()).isEqualTo(99L);
        assertThat(result.getName()).isEqualTo("New Task");
        assertThat(savedEntity.getAssignee()).isEqualTo(assignee);
    }

    @Test
    void newTask_shouldThrowMissingEntity_whenProjectNotFound() {
        when(projectRepository.findById(anyLong())).thenReturn(Optional.empty());

        TaskRequest request = TaskRequest.builder().name("Test").build();

        assertThatThrownBy(() -> taskService.newTask(1L, request))
                .isInstanceOf(MissingEntityException.class);
    }

    @Test
    void updateTask_shouldUpdateFields() throws MissingEntityException, UserMismatchException {
        // Given
        String ownerKeycloakId = "owner-123";
        UserEntity owner = UserEntity.builder().id(10L).keycloakId(ownerKeycloakId).build();

        ProjectEntity project = ProjectEntity.builder()
                .id(20L)
                .owner(owner)
                .build();

        UserEntity assignee = UserEntity.builder().id(5L).keycloakId("assignee-456").build();

        TaskEntity entity = TaskEntity.builder()
                .id(1L)
                .name("Old Name")
                .description("Old Desc")
                .status(TaskStatus.TODO)
                .project(project)
                .assignee(assignee)
                .build();

        when(taskRepository.findById(1L)).thenReturn(Optional.of(entity));

        UserEntity newAssignee = UserEntity.builder().id(99L).keycloakId("assignee-new").build();
        when(userRepository.findById(99L)).thenReturn(Optional.of(newAssignee));

        TaskRequest request = TaskRequest.builder()
                .name("New Name")
                .description("New Desc")
                .status(TaskStatus.DONE)
                .assigneeId(99L)
                .build();

        TaskEntity savedEntity = TaskEntity.builder()
                .id(1L)
                .name("New Name")
                .description("New Desc")
                .status(TaskStatus.DONE)
                .project(project)
                .assignee(newAssignee)
                .build();

        TaskDTO dto = TaskDTO.builder().id(1L).name("New Name").build();

        when(taskRepository.save(any(TaskEntity.class))).thenReturn(savedEntity);
        when(mapper.toDto(savedEntity)).thenReturn(dto);

        // When
        TaskDTO result = taskService.updateTask(ownerKeycloakId, 1L, request);

        // Then
        assertThat(result.getId()).isEqualTo(1L);
        assertThat(result.getName()).isEqualTo("New Name");
    }

    @Test
    void updateTask_shouldThrowMissingEntity_whenTaskNotFound() {
        when(taskRepository.findById(anyLong())).thenReturn(Optional.empty());

        TaskRequest request = TaskRequest.builder().name("X").build();

        assertThatThrownBy(() ->
                taskService.updateTask("abc", 1L, request)
        ).isInstanceOf(MissingEntityException.class);
    }

    @Test
    void updateTask_shouldThrowUserMismatch_onNameChange() {
        ProjectEntity project = ProjectEntity.builder()
                .id(1L)
                .owner(UserEntity.builder().keycloakId("owner-id").build())
                .build();

        TaskEntity entity = TaskEntity.builder()
                .id(1L)
                .name("Old Name")
                .description("Old Desc")
                .status(TaskStatus.TODO)
                .project(project)
                .assignee(UserEntity.builder().keycloakId("assignee-id").build())
                .build();

        when(taskRepository.findById(1L)).thenReturn(Optional.of(entity));

        TaskRequest request = TaskRequest.builder().name("New Name").build();

        assertThatThrownBy(() ->
                taskService.updateTask("someone-else", 1L, request)
        ).isInstanceOf(UserMismatchException.class);
    }

    @Test
    void deleteTask_shouldDeleteWhenOwnerMatches() throws NotFoundException {
        String keycloakId = "owner-123";

        ProjectEntity project = ProjectEntity.builder()
                .id(10L)
                .owner(UserEntity.builder().keycloakId(keycloakId).build())
                .build();

        TaskEntity entity = TaskEntity.builder()
                .id(1L)
                .project(project)
                .build();

        when(taskRepository.findById(1L)).thenReturn(Optional.of(entity));

        // When
        taskService.deleteTask(keycloakId, 1L);

        // Then
        verify(taskRepository).delete(entity);
    }

    @Test
    void deleteTask_shouldThrowUserMismatch() {
        ProjectEntity project = ProjectEntity.builder()
                .id(10L)
                .owner(UserEntity.builder().keycloakId("owner-id").build())
                .build();

        TaskEntity entity = TaskEntity.builder()
                .id(1L)
                .project(project)
                .build();

        when(taskRepository.findById(1L)).thenReturn(Optional.of(entity));

        assertThatThrownBy(() ->
                taskService.deleteTask("other-user", 1L)
        ).isInstanceOf(UserMismatchException.class);
    }

    @Test
    void deleteTask_shouldThrowNotFound() {
        when(taskRepository.findById(anyLong())).thenReturn(Optional.empty());

        assertThatThrownBy(() ->
                taskService.deleteTask("abc", 1L)
        ).isInstanceOf(NotFoundException.class);
    }
}
