package com.ardolynk.taskflow.specifications;

import org.springframework.data.jpa.domain.Specification;

import com.ardolynk.taskflow.dao.NoteEntity;
import com.ardolynk.taskflow.dao.NoteEntity_;

public class NoteSpecifications {
    public static Specification<NoteEntity> byTaskId(long taskId) {
        return (root, query, cb) -> cb.equal(root.get(NoteEntity_.TASK_ID), taskId);
    }
}
