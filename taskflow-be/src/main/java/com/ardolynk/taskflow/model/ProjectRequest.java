package com.ardolynk.taskflow.model;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ProjectRequest {
    private String name;
    private String description;
}
