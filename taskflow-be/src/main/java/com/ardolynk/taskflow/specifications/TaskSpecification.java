package com.ardolynk.taskflow.specifications;

import org.springframework.data.jpa.domain.Specification;

import com.ardolynk.taskflow.dao.TaskEntity;
import com.ardolynk.taskflow.dao.TaskEntity_;
import com.ardolynk.taskflow.dao.UserEntity_;

public class TaskSpecification {
    public static Specification<TaskEntity> assignedBykeycloakId(String uuid) {
        if (uuid == null) {
            return null;
        }
        return (root, query, cb) -> cb.equal(root.get(TaskEntity_.ASSIGNEE).get(UserEntity_.KEYCLOAK_ID), uuid);
    }
}
