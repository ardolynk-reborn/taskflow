package com.ardolynk.taskflow.model;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserDTO {
    private long id;
    private String username;
    private String email;
    private String keycloakId;
}
