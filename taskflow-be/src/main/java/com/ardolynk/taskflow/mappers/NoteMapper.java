package com.ardolynk.taskflow.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import com.ardolynk.taskflow.dao.NoteEntity;
import com.ardolynk.taskflow.model.NoteDTO;

@Mapper(componentModel = "spring", uses = { UserMapper.class })
public interface NoteMapper {

    @Mapping(target = "userUuid", source = "user.keycloakId")
    @Mapping(target = "username", source = "user.username")
    NoteDTO toDto(NoteEntity note);
}
