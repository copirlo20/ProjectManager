package com.copirlo.ProjectManager.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.copirlo.ProjectManager.entity.TaskList;

public interface TaskListRepository extends JpaRepository<TaskList, Integer> {
}
