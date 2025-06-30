package com.ardolynk.taskflow.model;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TaskDTO {
    private long id;
    private long projectId;
    private String title;
    private String description;
    private String status;
    private Long assigneeId;
    private String assigneeUsername;
}