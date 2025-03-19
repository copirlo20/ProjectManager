package com.copirlo.ProjectManager.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.copirlo.ProjectManager.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByEmail(String email);
}