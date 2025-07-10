package com.ardolynk.taskflow.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.ardolynk.taskflow.dao.TaskEntity;
import com.ardolynk.taskflow.model.TaskDTO;

@Mapper(componentModel = "spring")
public interface TaskMapper {

    @Mapping(target = "projectId", source = "project.id")
    @Mapping(target = "ownerId", source = "project.owner.id")
    @Mapping(target = "ownerUuid", source = "project.owner.keycloakId")
    @Mapping(target = "ownerUsername", source = "project.owner.username")
    @Mapping(target = "assigneeId", source = "assignee.id")
    @Mapping(target = "assigneeUuid", source = "assignee.keycloakId")
    @Mapping(target = "assigneeUsername", source = "assignee.username")
    TaskDTO toDto(TaskEntity task);
}
