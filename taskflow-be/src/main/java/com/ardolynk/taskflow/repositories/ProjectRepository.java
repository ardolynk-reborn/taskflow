package com.ardolynk.taskflow.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.lang.NonNull;

import com.ardolynk.taskflow.dao.ProjectEntity;

public interface ProjectRepository extends JpaRepository<ProjectEntity, Long>, JpaSpecificationExecutor<ProjectEntity> {
    @EntityGraph(attributePaths = "tasks")
    @NonNull
    List<ProjectEntity> findAll();
}
