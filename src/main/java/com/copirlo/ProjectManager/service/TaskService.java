package com.copirlo.ProjectManager.service;

import java.sql.Date;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.copirlo.ProjectManager.dto.TaskDto;
import com.copirlo.ProjectManager.entity.Task;
import com.copirlo.ProjectManager.entity.TaskList;
import com.copirlo.ProjectManager.repository.TaskListRepository;
import com.copirlo.ProjectManager.repository.TaskRepository;

@Service
public class TaskService {
    private final TaskRepository taskRepository;
    private final TaskListRepository taskListRepository;

    public TaskService(
            TaskRepository taskRepository,
            TaskListRepository taskListRepository) {
        this.taskRepository = taskRepository;
        this.taskListRepository = taskListRepository;
    }

    public void addTask(TaskDto taskDto) {
        Task task = new Task();
        int position = this.taskRepository.findByTaskListPositionMax(taskDto.getTaskListId()) + 1;
        task.setTitle(taskDto.getTitle());
        task.setDescription(taskDto.getDescription());
        task.setPosition(position);
        if (taskDto.getDueDate().toLocalDate().equals(new Date(0).toLocalDate())) {
            task.setDueDate(null);
        } else {
            task.setDueDate(taskDto.getDueDate());
        }
        task.setTaskList(this.taskListRepository.findById(taskDto.getTaskListId())
                .orElseThrow(() -> new IllegalArgumentException("TaskList not found")));
        this.taskRepository.save(task);
    }

    public void deleteTask(int taskId) {
        this.taskRepository.deleteById(taskId);
    }

    @Transactional
    public void moveTask(int taskId, int newPosition) {
        Task task = taskRepository.findById(taskId).orElseThrow(() -> new IllegalArgumentException("task not found"));
        int oldPosition = task.getPosition();
        int taskListId = task.getTaskList().getId();
        if (newPosition == oldPosition) {
            return;
        }
        if (newPosition < oldPosition) {
            this.taskRepository.incrementPositions(taskListId, newPosition, oldPosition);
        } else {
            this.taskRepository.decrementPositions(taskListId, oldPosition, newPosition);
        }
        this.taskRepository.updateTaskPosition(taskId, newPosition);
    }

    @Transactional
    public void moveTaskToList(int boardId, int taskId, int newTaskListPosition) {
        Task task = this.taskRepository.findById(taskId)
                .orElseThrow(() -> new IllegalArgumentException("task not found"));
        int oldTaskListId = task.getTaskList().getId();
        int start = task.getPosition();
        int end = this.taskRepository.findByTaskListPositionMax(oldTaskListId);
        this.taskRepository.decrementPositions(oldTaskListId, start, end);
        TaskList newTaskList = this.taskListRepository.findByBoardIdAndPosition(boardId, newTaskListPosition)
                .orElseThrow(() -> new IllegalArgumentException("TaskList not found"));
        int newPosition = this.taskRepository.findByTaskListPositionMax(newTaskList.getId()) + 1;
        task.setTaskList(newTaskList);
        this.taskRepository.save(task);
        this.taskRepository.updateTaskPosition(taskId, newPosition);
    }
}