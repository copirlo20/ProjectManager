package com.copirlo.ProjectManager.service;

import org.springframework.stereotype.Service;
import com.copirlo.ProjectManager.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
}