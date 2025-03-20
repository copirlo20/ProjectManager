package com.copirlo.ProjectManager.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.copirlo.ProjectManager.entity.Task;

public interface TaskRepository extends JpaRepository<Task, Integer> {
}
