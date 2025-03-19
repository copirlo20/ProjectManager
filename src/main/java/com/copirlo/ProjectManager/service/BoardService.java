package com.copirlo.ProjectManager.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.copirlo.ProjectManager.dto.TaskDto;
import com.copirlo.ProjectManager.dto.TaskListDto;
import com.copirlo.ProjectManager.entity.Task;
import com.copirlo.ProjectManager.entity.TaskList;
import com.copirlo.ProjectManager.repository.BoardRepository;
import com.copirlo.ProjectManager.repository.TaskListRepository;
import com.copirlo.ProjectManager.repository.TaskRepository;

@Service
public class BoardService {
    BoardRepository boardRepository;
    TaskListRepository taskListRepository;
    TaskRepository taskRepository;

    public BoardService(
            BoardRepository boardRepository,
            TaskListRepository taskListRepository,
            TaskRepository taskRepository) {
        this.boardRepository = boardRepository;
        this.taskListRepository = taskListRepository;
        this.taskRepository = taskRepository;
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

    public void addTask(TaskDto taskDto) {
        Task task = new Task();
        task.setTitle(taskDto.getTitle());
        task.setDescription(taskDto.getDescription());
        task.setTaskList(this.taskListRepository.findById(taskDto.getTaskListId())
                .orElseThrow(() -> new IllegalArgumentException("TaskList not found")));
        this.taskRepository.save(task);
    }
}