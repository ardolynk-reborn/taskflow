package com.ardolynk.taskflow.exceptions;

public class MissingEntityException extends RuntimeException {
    public MissingEntityException(String entityName, String key) {
        super(String.format("%s with ID or key %s not found", entityName, key));
    }
}
