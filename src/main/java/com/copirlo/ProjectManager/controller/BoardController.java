package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.copirlo.ProjectManager.dto.TaskListDto;
import com.copirlo.ProjectManager.service.BoardService;
import org.springframework.ui.Model;

@Controller
public class BoardController {
    BoardService boardService;

    public BoardController(BoardService boardService) {
        this.boardService = boardService;
    }

    @RequestMapping("/board/{id}")
    public String index(Model model, @PathVariable("id") int id) {
        model.addAttribute("boardId", id);
        model.addAttribute("taskLists", boardService.getTaskLists(id));
        model.addAttribute("taskListDto", new TaskListDto());
        return "board";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/addTaskList/{id}")
    public String addTaskList(@PathVariable("id") int id, TaskListDto taskListDto) {
        this.boardService.addTaskList(taskListDto);
        return "redirect:/board/" + id;
    }
}