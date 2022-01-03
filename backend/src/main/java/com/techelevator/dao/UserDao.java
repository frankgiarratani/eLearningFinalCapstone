package com.techelevator.dao;

import com.techelevator.model.User;

import java.util.List;

public interface UserDao {

    List<User> findAll();

    User getUserById(Long userId);

    User findByUsername(String username);

    int findIdByUsername(String username);

    boolean findIfUsernameIsTeacher(String username);

    boolean create(String username, String firstName, String lastName, boolean isTeacher, String password, String role);
}
