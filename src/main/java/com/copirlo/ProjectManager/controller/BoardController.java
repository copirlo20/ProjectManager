package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.copirlo.ProjectManager.dto.TaskListDto;
import com.copirlo.ProjectManager.entity.Board;
import com.copirlo.ProjectManager.service.BoardService;
import com.copirlo.ProjectManager.service.TaskListService;
import org.springframework.ui.Model;

@Controller
public class BoardController {
    private final BoardService boardService;
    private final TaskListService taskListService;

    public BoardController(BoardService boardService, TaskListService taskListService) {
        this.boardService = boardService;
        this.taskListService = taskListService;
    }

    @RequestMapping("/board/{boardId}")
    public String index(Model model, @PathVariable("boardId") int boardId) {
        model.addAttribute("boardId", boardId);
        model.addAttribute("taskLists", taskListService.getTaskLists(boardId));
        model.addAttribute("taskListDto", new TaskListDto());
        return "board";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/updateBoard")
    public String updateBoard(@ModelAttribute("updateBoard") Board board) {
        this.boardService.updateBoard(board);
        return "redirect:/";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/addBoard")
    public String addBoard(@ModelAttribute("newBoard") Board board) {
        this.boardService.addBoard(board, 1);
        return "redirect:/";
    }
}