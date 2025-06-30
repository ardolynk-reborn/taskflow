package com.ardolynk.taskflow.exceptions;

import org.apache.coyote.BadRequestException;

public class MissingEntityException extends BadRequestException {
    public MissingEntityException(String entityName, String key) {
        super(String.format("%s with ID or key %s not found", entityName, key));
    }
}
