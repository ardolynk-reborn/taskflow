package com.ardolynk.taskflow.specifications;

import java.time.Instant;

import org.springframework.data.jpa.domain.Specification;

import com.ardolynk.taskflow.dao.ProjectEntity_;
import com.ardolynk.taskflow.dao.TaskEntity;
import com.ardolynk.taskflow.dao.TaskEntity_;
import com.ardolynk.taskflow.dao.TaskStatus;
import com.ardolynk.taskflow.dao.UserEntity_;

public class TaskSpecifications {
    public static Specification<TaskEntity> assignedBykeycloakId(String uuid) {
        if (uuid == null) {
            return null;
        }
        return (root, query, cb) -> cb.equal(root.get(TaskEntity_.ASSIGNEE).get(UserEntity_.KEYCLOAK_ID), uuid);
    }

    public static Specification<TaskEntity> byProjectId(long projectId) {
        return (root, query, cb) -> cb.equal(root.get(TaskEntity_.PROJECT).get(ProjectEntity_.ID), projectId);
    }

    public static Specification<TaskEntity> byStatuses(TaskStatus[] statuses) {
        return (root, query, cb) -> cb.in(root.get(TaskEntity_.STATUS)).value(statuses);
    }

    public static Specification<TaskEntity> byNameSubstring(String str) {
        return (root, query, cb) -> cb.like(cb.lower(root.get(TaskEntity_.NAME)), "%" + str.toLowerCase() + "%");
    }

    public static Specification<TaskEntity> byDescriptionSubstring(String str) {
        return (root, query, cb) -> cb.like(cb.lower(root.get(TaskEntity_.DESCRIPTION)), "%" + str.toLowerCase() + "%");
    }

    public static Specification<TaskEntity> updatedSince(Instant since) {
        return (root, query, cb) -> cb.greaterThanOrEqualTo(root.get(TaskEntity_.UPDATED_AT), since);
    }

    public static Specification<TaskEntity> updatedBefore(Instant before) {
        return (root, query, cb) -> cb.lessThan(root.get(TaskEntity_.UPDATED_AT), before);
    }
}
