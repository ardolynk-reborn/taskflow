package com.ardolynk.taskflow.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Repository;

import com.ardolynk.taskflow.dao.NoteEntity;


@Repository
public interface NoteRepository extends JpaRepository<NoteEntity, Long>, JpaSpecificationExecutor<NoteEntity> {
    @EntityGraph(attributePaths = "user")
    @NonNull
    List<NoteEntity> findAll();
}
