package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
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
    public String addTaskList(TaskListDto taskListDto) {
        this.taskListService.addTaskList(taskListDto);
        return "redirect:/board/" + taskListDto.getBoardId();
    }
}
