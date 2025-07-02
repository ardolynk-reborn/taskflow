package com.ardolynk.taskflow.model;

import com.ardolynk.taskflow.dao.TaskStatus;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TaskRequest {
    String name;
    String description;
    TaskStatus status;
    Long assigneeId;
}
