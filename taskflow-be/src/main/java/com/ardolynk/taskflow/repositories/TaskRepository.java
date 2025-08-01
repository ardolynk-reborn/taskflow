package com.ardolynk.taskflow.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import com.ardolynk.taskflow.dao.TaskEntity;

import io.micrometer.common.lang.NonNull;

@Repository
public interface TaskRepository extends JpaRepository<TaskEntity, Long>, JpaSpecificationExecutor<TaskEntity> {
    @EntityGraph(attributePaths = "project.owner,assignee")
    @NonNull
    List<TaskEntity> findAll();
}
