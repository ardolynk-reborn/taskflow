package com.ardolynk.taskflow.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ardolynk.taskflow.dao.UserEntity;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {
    UserEntity findByKeycloakId(String keycloakId);
}
