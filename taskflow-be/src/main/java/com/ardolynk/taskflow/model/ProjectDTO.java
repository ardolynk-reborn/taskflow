package com.ardolynk.taskflow.model;

import java.util.List;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ProjectDTO {
    private long id;
    private long ownerId;
    private String ownerUuid;
    private String ownerUsername;
    private String name;
    private String description;
    private List<TaskDTO> tasks;
}