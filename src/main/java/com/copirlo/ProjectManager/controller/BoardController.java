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

    @RequestMapping("/board/{boardId}")
    public String index(Model model, @PathVariable("boardId") int boardId) {
        model.addAttribute("boardId", boardId);
        model.addAttribute("taskLists", boardService.getTaskLists(boardId));
        model.addAttribute("taskListDto", new TaskListDto());
        return "board";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/addTaskList")
    public String addTaskList(TaskListDto taskListDto) {
        this.boardService.addTaskList(taskListDto);
        return "redirect:/board/" + taskListDto.getBoardId();
    }
}