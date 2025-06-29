package com.ardolynk.taskflow.specifications;

import org.springframework.data.jpa.domain.Specification;

import com.ardolynk.taskflow.dao.ProjectEntity;
import com.ardolynk.taskflow.dao.ProjectEntity_;
import com.ardolynk.taskflow.dao.UserEntity_;

public class ProjectSpecifications {
    public static Specification<ProjectEntity> byUserKeycloakUuid(String uuid) {
        if (uuid == null) {
            return null;
        }
        return (root, query, cb) -> cb.equal(root.get(ProjectEntity_.OWNER).get(UserEntity_.KEYCLOAK_ID), uuid);
    }
}
