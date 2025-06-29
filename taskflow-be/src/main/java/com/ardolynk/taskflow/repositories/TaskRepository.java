package com.ardolynk.taskflow.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ardolynk.taskflow.dao.TaskEntity;

public interface TaskRepository extends JpaRepository<TaskEntity, Long> {
}
