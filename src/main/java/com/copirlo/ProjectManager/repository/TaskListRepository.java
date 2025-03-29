package com.copirlo.ProjectManager.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import com.copirlo.ProjectManager.entity.TaskList;

public interface TaskListRepository extends JpaRepository<TaskList, Integer> {
    Optional<TaskList> findByPosition(int position);

    @Query("SELECT COALESCE(MAX(t.position), 0) FROM TaskList t WHERE t.board.id = :boardId")
    int findByBoardIdMaxPosition(@Param("boardId") int boardId);

    /*
     * Update position of all taskLists in a board when a taskList is deleted
     */
    @Modifying
    @Transactional
    @Query("UPDATE TaskList taskList SET taskList.position = taskList.position - 1 WHERE taskList.board.id = :boardId AND taskList.position > :start AND taskList.position <= :end")
    void decrementPositions(int boardId, int start, int end);

    @Query("SELECT taskList FROM TaskList taskList WHERE taskList.board.id = :boardId AND taskList.position = :position")
    Optional<TaskList> findByBoardIdAndPosition(@Param("boardId") int boardId, @Param("position") int position);
}