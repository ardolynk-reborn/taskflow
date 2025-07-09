package com.ardolynk.taskflow.services;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
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
public class ProjectService {
    private final UserRepository userRepository;
    private final ProjectRepository projectRepository;
    private final ProjectMapper mapper;

    //Logger logger = LoggerFactory.getLogger(DashboardService.class);
    Logger logger = LoggerFactory.getLogger(ProjectService.class);

    public Page<ProjectDTO> getProjects(
        String keycloakId,
        String searchSubstring,
        Instant since,
        Instant before,

        int page,
        int size,
        String[] sort
    ) {
        // Start with an empty specification
        List<Specification<ProjectEntity>> specs = new ArrayList<>();
        if (keycloakId != null) {
            specs.add(ProjectSpecifications.byKeycloakId(keycloakId));
        }
        if (searchSubstring != null) {
            specs.add(Specification.anyOf(
                ProjectSpecifications.byNameSubstring(searchSubstring),
                ProjectSpecifications.byDescriptionSubstring(searchSubstring)
            ));
        }
        if (since != null) {
            specs.add(ProjectSpecifications.updatedSince(since));
        }
        if (before != null) {
            specs.add(ProjectSpecifications.updatedBefore(before));
        }

        List<Sort.Order> orders = new ArrayList<>();
        for (String sortOrder : sort) {
            String[] _sort = sortOrder.split(":");
            orders.add(new Sort.Order((_sort.length > 1 && _sort[1].equalsIgnoreCase("desc"))
                    ? Sort.Direction.DESC
                    : Sort.Direction.ASC,
                _sort[0]));
        }

        var result = projectRepository.findAll(
            Specification.allOf(specs),
            PageRequest.of(page, size, Sort.by(orders))
        );

        return result.map(mapper::toDto);
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
        // TODO: check permissions (user should be owner or admin)

        ProjectEntity project = projectRepository.findById(id).orElseThrow(() -> new NotFoundException());
        projectRepository.delete(project);
    }
}
