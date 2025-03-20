package com.copirlo.ProjectManager.service;

import org.springframework.stereotype.Service;
import com.copirlo.ProjectManager.dto.TaskDto;
import com.copirlo.ProjectManager.entity.Task;
import com.copirlo.ProjectManager.repository.TaskListRepository;
import com.copirlo.ProjectManager.repository.TaskRepository;

@Service
public class TaskService {
    private final TaskRepository taskRepository;
    private final TaskListRepository taskListRepository;

    public TaskService(TaskRepository taskRepository, TaskListRepository taskListRepository) {
        this.taskRepository = taskRepository;
        this.taskListRepository = taskListRepository;
    }

    public void addTask(TaskDto taskDto) {
        Task task = new Task();
        task.setTitle(taskDto.getTitle());
        task.setDescription(taskDto.getDescription());
        task.setTaskList(this.taskListRepository.findById(taskDto.getTaskListId())
                .orElseThrow(() -> new IllegalArgumentException("TaskList not found")));
        this.taskRepository.save(task);
    }

    public void deleteTask(int taskId) {
        this.taskRepository.deleteById(taskId);
    }
}