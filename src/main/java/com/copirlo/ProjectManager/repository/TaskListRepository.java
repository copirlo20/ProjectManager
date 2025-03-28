package com.copirlo.ProjectManager.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.copirlo.ProjectManager.entity.TaskList;

public interface TaskListRepository extends JpaRepository<TaskList, Integer> {
    @Query("SELECT COALESCE(MAX(t.position), 0) FROM TaskList t WHERE t.board.id = :boardId")
    int findByBoardIdMaxPosition(@Param("boardId") Integer boardId);
}