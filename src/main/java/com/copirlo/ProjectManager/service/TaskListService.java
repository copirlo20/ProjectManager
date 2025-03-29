package com.copirlo.ProjectManager.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.copirlo.ProjectManager.dto.TaskListDto;
import com.copirlo.ProjectManager.entity.TaskList;
import com.copirlo.ProjectManager.repository.BoardRepository;
import com.copirlo.ProjectManager.repository.TaskListRepository;

@Service
public class TaskListService {
    private final BoardRepository boardRepository;
    private final TaskListRepository taskListRepository;

    public TaskListService(BoardRepository boardRepository, TaskListRepository taskListRepository) {
        this.boardRepository = boardRepository;
        this.taskListRepository = taskListRepository;
    }

    public void addTaskList(TaskListDto taskListDto) {
        TaskList taskList = new TaskList();
        int position = this.taskListRepository.findByBoardIdMaxPosition(taskListDto.getBoardId()) + 1;
        taskList.setName(taskListDto.getName());
        taskList.setBoard(this.boardRepository.findById(taskListDto.getBoardId())
                .orElseThrow(() -> new IllegalArgumentException("Board not found")));
        taskList.setPosition(position);
        this.taskListRepository.save(taskList);
    }

    public List<TaskList> getTaskLists(int boardId) {
        return this.boardRepository.findById(boardId).orElseThrow(() -> new IllegalArgumentException("Board not found"))
                .getTaskLists();
    }

    @Transactional
    public void deleteTaskList(int taskListId) {
        int boardId = this.taskListRepository.findById(taskListId)
                .orElseThrow(() -> new IllegalArgumentException("TaskList not found")).getBoard().getId();
        int start = this.taskListRepository.findById(taskListId)
                .orElseThrow(() -> new IllegalArgumentException("TaskList not found")).getPosition();
        int end = this.taskListRepository.findByBoardIdMaxPosition(boardId) + 1;
        if (start == end) {
            return;
        }
        this.taskListRepository.decrementPositions(boardId, start, end);
        this.taskListRepository.deleteById(taskListId);
    }
}