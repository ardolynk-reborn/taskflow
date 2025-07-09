package com.ardolynk.taskflow.model;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class NoteDTO {
    private long id;
    private long taskId;
    private long userId;
    private String userUuid;
    private String username;
    private String note;
}
