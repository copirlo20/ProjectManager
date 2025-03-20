package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.copirlo.ProjectManager.dto.TaskListDto;
import com.copirlo.ProjectManager.service.TaskListService;

@Controller
public class TaskListController {
    private final TaskListService taskListService;

    public TaskListController(TaskListService taskListService) {
        this.taskListService = taskListService;
    }

    @RequestMapping(method = RequestMethod.POST, value = "/addTaskList")
    public String addTaskList(
            TaskListDto taskListDto,
            @RequestHeader(value = "Referer", required = false) String referer) {
        this.taskListService.addTaskList(taskListDto);
        return "redirect:" + referer;
    }

    @RequestMapping("/deleteTaskList/{taskListId}")
    public String deleteTaskList(
            @PathVariable("taskListId") int taskListId,
            @RequestHeader(value = "Referer", required = false) String referer) {
        this.taskListService.deleteTaskList(taskListId);
        return "redirect:" + referer;
    }
}
