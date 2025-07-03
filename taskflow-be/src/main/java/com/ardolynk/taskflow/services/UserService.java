package com.ardolynk.taskflow.services;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ardolynk.taskflow.mappers.UserMapper;
import com.ardolynk.taskflow.model.UserDTO;
import com.ardolynk.taskflow.repositories.UserRepository;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class UserService {
    private final UserRepository repository;
    private final UserMapper mapper;

    public List<UserDTO> getAllUsers() {
        return repository.findAll().stream().map(mapper::toDto).toList();
    }
}
