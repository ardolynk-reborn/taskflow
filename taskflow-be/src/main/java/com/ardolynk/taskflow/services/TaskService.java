package com.ardolynk.taskflow.services;

import java.util.List;

import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.stereotype.Service;

import com.ardolynk.taskflow.dao.ProjectEntity;
import com.ardolynk.taskflow.dao.TaskEntity;
import com.ardolynk.taskflow.dao.TaskStatus;
import com.ardolynk.taskflow.dao.UserEntity;
import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.mappers.TaskMapper;
import com.ardolynk.taskflow.model.TaskDTO;
import com.ardolynk.taskflow.model.TaskRequest;
import com.ardolynk.taskflow.repositories.ProjectRepository;
import com.ardolynk.taskflow.repositories.TaskRepository;
import com.ardolynk.taskflow.repositories.UserRepository;
import com.ardolynk.taskflow.specifications.TaskSpecification;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TaskService {
    private final TaskRepository taskRepository;
    private final ProjectRepository projectRepository;
    private final UserRepository userRepository;
    private final TaskMapper mapper;

    public List<TaskDTO> getAssignedTasks(String keycloakId) {
        return taskRepository.findAll(TaskSpecification.assignedBykeycloakId(keycloakId)).stream().map(mapper::toDto).toList();
    }

    public TaskDTO getTask(long id) {
        return taskRepository.findById(id).map(mapper::toDto).orElse(null);
    }

    public TaskDTO newTask(long projectId, TaskRequest request) throws MissingEntityException {
        ProjectEntity project = projectRepository.findById(projectId).orElseThrow(() ->
            new MissingEntityException("Project", String.valueOf(projectId)));
        TaskEntity.TaskEntityBuilder taskBuilder = TaskEntity.builder()
            .project(project)
            .name(request.getName())
            .description(request.getDescription())
            .status(request.getStatus() != null ? request.getStatus() : TaskStatus.TODO);
        Long assigneeId = request.getAssigneeId();
        if (assigneeId != null) {
            UserEntity assignee = userRepository.findById(assigneeId).orElseThrow(() -> new MissingEntityException("User", String.valueOf(assigneeId)));
            taskBuilder = taskBuilder.assignee(assignee);
        }
        TaskEntity task = taskBuilder.build();
        TaskEntity savedTask = taskRepository.save(task);
        return mapper.toDto(savedTask);
    }

    public TaskDTO updateTask(long id, TaskRequest request) throws MissingEntityException {
        TaskEntity task = taskRepository.findById(id).orElseThrow(() -> new MissingEntityException("Task", String.valueOf(id)));
        String name = request.getName();
        if (name != null) {
            task.setName(name);
        }
        String description = request.getDescription();
        if (description != null) {
            task.setDescription(description);
        }
        TaskStatus status = request.getStatus();
        if (status != null) {
            task.setStatus(status);
        }
        Long assigneeId = request.getAssigneeId();
        if (assigneeId != null) {
            UserEntity assignee = userRepository.findById(assigneeId).orElseThrow(() -> new MissingEntityException("User", String.valueOf(assigneeId)));
            task.setAssignee(assignee);
        }
        TaskEntity savedTask = taskRepository.save(task);
        return mapper.toDto(savedTask);
    }

    public void deleteTask(long id) throws NotFoundException {
        TaskEntity task = taskRepository.findById(id).orElseThrow(() -> new NotFoundException());
        taskRepository.delete(task);
    }
}
