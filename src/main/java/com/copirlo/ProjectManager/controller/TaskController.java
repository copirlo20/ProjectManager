package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
import com.copirlo.ProjectManager.dto.TaskDto;
import com.copirlo.ProjectManager.service.TaskService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TaskController {
    private final TaskService taskService;

    public TaskController(TaskService taskService) {
        this.taskService = taskService;
    }

    @RequestMapping(value = "/addTask", method = RequestMethod.POST)
    public String addTask(TaskDto taskDto, @RequestHeader(value = "Referer", required = false) String referer) {
        this.taskService.addTask(taskDto);
        return "redirect:" + referer;
    }

    @RequestMapping("/deleteTask/{taskId}")
    public String deleteTask(
            @PathVariable("taskId") int taskId,
            @RequestHeader(value = "Referer", required = false) String referer) {
        this.taskService.deleteTask(taskId);
        return "redirect:" + referer;
    }
}