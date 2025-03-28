package com.copirlo.ProjectManager.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import com.copirlo.ProjectManager.entity.Task;

public interface TaskRepository extends JpaRepository<Task, Integer> {
    @Query("SELECT COALESCE(MAX(t.position), 0) FROM Task t WHERE t.taskList.id = :taskListId")
    int findByTaskListIdMaxPosition(@Param("taskListId") Integer taskListId);

    /*
     * Update position of all tasks in a task list when a task is moved up
     */
    @Modifying
    @Transactional
    @Query("UPDATE Task task SET task.position = task.position + 1 WHERE task.taskList.id = :taskListId AND task.position >= :start AND task.position < :end")
    void incrementPositions(Integer taskListId, Integer start, Integer end);

    /*
     * Update position of all tasks in a task list when a task is moved down
     */
    @Modifying
    @Transactional
    @Query("UPDATE Task task SET task.position = task.position - 1 WHERE task.taskList.id = :taskListId AND task.position > :start AND task.position <= :end")
    void decrementPositions(Integer taskListId, Integer start, Integer end);

    /*
     * Update position of a task when it is moved to a new position
     */
    @Modifying
    @Transactional
    @Query("UPDATE Task task SET task.position = :newPosition WHERE task.id = :taskId")
    void updateCardPosition(Integer taskId, Integer newPosition);
}
