package com.ardolynk.taskflow.mappers;

import org.mapstruct.Mapper;

import com.ardolynk.taskflow.model.UserDTO;

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserDTO toDto(com.ardolynk.taskflow.dao.UserEntity user);
}
