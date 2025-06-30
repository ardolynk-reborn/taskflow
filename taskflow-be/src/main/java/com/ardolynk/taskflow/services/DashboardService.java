package com.ardolynk.taskflow.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.stereotype.Service;

import com.ardolynk.taskflow.dao.ProjectEntity;
import com.ardolynk.taskflow.dao.UserEntity;
import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.mappers.ProjectMapper;
import com.ardolynk.taskflow.model.ProjectDTO;
import com.ardolynk.taskflow.model.ProjectRequest;
import com.ardolynk.taskflow.repositories.ProjectRepository;
import com.ardolynk.taskflow.repositories.UserRepository;
import com.ardolynk.taskflow.specifications.ProjectSpecifications;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DashboardService {
    private final UserRepository userRepository;
    private final ProjectRepository projectRepository;
    private final ProjectMapper mapper;

    //Logger logger = LoggerFactory.getLogger(DashboardService.class);
    Logger logger = LoggerFactory.getLogger(DashboardService.class);

    public List<ProjectDTO> getProjects(String keycloakId) {
        var result = projectRepository.findAll(ProjectSpecifications.byKeycloakId(keycloakId));
        logger.info("Found {} projects", result.size());
        return result
            .stream()
            .map(mapper::toDto)
            .toList();
    }

    public ProjectDTO getProject(long id) throws NotFoundException {
        ProjectEntity project = projectRepository.findById(id).orElseThrow(() -> new NotFoundException());
        // TODO: check permissions (user should be owner or admin)
        return mapper.toDto(project);
    }

    public ProjectDTO newProject(String keycloakId, ProjectRequest request) throws MissingEntityException {
        UserEntity owner = userRepository.findByKeycloakId(keycloakId);
        if (owner == null) {
            throw new MissingEntityException("User", keycloakId);
        }
        ProjectEntity project = projectRepository.save((ProjectEntity.builder()
            .name(request.getName()))
            .description(request.getDescription())
            .owner(owner)
            .build());
        return mapper.toDto(project);
    }

    public ProjectDTO updateProject(long id, ProjectRequest request) throws NotFoundException {
        ProjectEntity project = projectRepository.findById(id).orElseThrow(() -> new NotFoundException());
        // TODO: check permissions (user should be owner or admin)

        String name = request.getName();
        if (name != null) {
            project.setName(name);
        }
        String description = request.getDescription();
        if (description != null) {
            project.setDescription(description);
        }
        ProjectEntity savedProject = projectRepository.save(project);
        return mapper.toDto(savedProject);
    }

    public void deleteProject(long id) throws NotFoundException {
        ProjectEntity project = projectRepository.findById(id).orElseThrow(() -> new NotFoundException());
        projectRepository.delete(project);
    }
}
