package com.copirlo.ProjectManager.service;

import java.util.List;
import org.springframework.stereotype.Service;
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
        taskList.setName(taskListDto.getName());
        taskList.setBoard(this.boardRepository.findById(taskListDto.getBoardId())
                .orElseThrow(() -> new IllegalArgumentException("Board not found")));
        this.taskListRepository.save(taskList);
    }

    public List<TaskList> getTaskLists(int boardId) {
        return this.boardRepository.findById(boardId).orElseThrow(() -> new IllegalArgumentException("Board not found"))
                .getTaskLists();
    }

    public void deleteTaskList(int taskListId) {
        this.taskListRepository.deleteById(taskListId);
    }
}