package com.copirlo.ProjectManager.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import com.copirlo.ProjectManager.entity.Task;

public interface TaskRepository extends JpaRepository<Task, Integer> {
    @Query("SELECT COALESCE(MAX(t.position), 0) FROM Task t WHERE t.taskList.id = :taskListId")
    int findByTaskListPositionMax(@Param("taskListId") int taskListId);

    /*
     * Update position of all tasks in a task list when a task is moved or deleted
     */
    @Modifying
    @Transactional
    @Query("UPDATE Task task SET task.position = task.position + 1 WHERE task.taskList.id = :taskListId AND task.position >= :start AND task.position < :end")
    void incrementPositions(int taskListId, int start, int end);

    @Modifying
    @Transactional
    @Query("UPDATE Task task SET task.position = task.position - 1 WHERE task.taskList.id = :taskListId AND task.position > :start AND task.position <= :end")
    void decrementPositions(int taskListId, int start, int end);

    /*
     * Update position of a task when it is moved to a new position
     */
    @Modifying
    @Transactional
    @Query("UPDATE Task task SET task.position = :newPosition WHERE task.id = :taskId")
    void updateTaskPosition(int taskId, int newPosition);
}
