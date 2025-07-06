package com.ardolynk.taskflow.specifications;

import java.time.Instant;

import org.springframework.data.jpa.domain.Specification;

import com.ardolynk.taskflow.dao.ProjectEntity;
import com.ardolynk.taskflow.dao.ProjectEntity_;
import com.ardolynk.taskflow.dao.UserEntity_;

public class ProjectSpecifications {
    public static Specification<ProjectEntity> byKeycloakId(String uuid) {
        if (uuid == null) {
            return null;
        }
        return (root, query, cb) -> cb.equal(root.get(ProjectEntity_.OWNER).get(UserEntity_.KEYCLOAK_ID), uuid);
    }
    public static Specification<ProjectEntity> byNameSubstring(String str) {
        return (root, query, cb) -> cb.like(cb.lower(root.get(ProjectEntity_.NAME)), "%" + str.toLowerCase() + "%");
    }

    public static Specification<ProjectEntity> byDescriptionSubstring(String str) {
        return (root, query, cb) -> cb.like(cb.lower(root.get(ProjectEntity_.DESCRIPTION)), "%" + str.toLowerCase() + "%");
    }

    public static Specification<ProjectEntity> updatedSince(Instant since) {
        return (root, query, cb) -> cb.greaterThanOrEqualTo(root.get(ProjectEntity_.UPDATED_AT), since);
    }

    public static Specification<ProjectEntity> updatedBefore(Instant before) {
        return (root, query, cb) -> cb.lessThan(root.get(ProjectEntity_.UPDATED_AT), before);
    }
}
