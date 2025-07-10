package com.ardolynk.taskflow.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.ardolynk.taskflow.dao.ProjectEntity;
import com.ardolynk.taskflow.model.ProjectDTO;

@Mapper(componentModel = "spring", uses = { TaskMapper.class })
public interface ProjectMapper {
    @Mapping(target = "ownerId", source = "owner.id")
    @Mapping(target = "ownerUuid", source = "owner.keycloakId")
    @Mapping(target = "ownerUsername", source = "owner.username")
    ProjectDTO toDto(ProjectEntity project);
}
