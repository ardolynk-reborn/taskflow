package com.ardolynk.taskflow.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.ardolynk.taskflow.exceptions.MissingEntityException;
import com.ardolynk.taskflow.exceptions.UserMismatchException;

@RestControllerAdvice
public class TaskflowExceptionHandler {
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MissingEntityException.class)
    public void handleMissingEntityException(MissingEntityException e) {}

    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ExceptionHandler(UserMismatchException.class)
    public void handleTaskRejectedException(UserMismatchException e) {}
}
