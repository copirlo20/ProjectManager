package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.copirlo.ProjectManager.dto.CommentDto;
import com.copirlo.ProjectManager.dto.TaskDto;
import com.copirlo.ProjectManager.dto.TaskListDto;
import com.copirlo.ProjectManager.entity.Board;
import com.copirlo.ProjectManager.service.BoardService;
import com.copirlo.ProjectManager.service.SessionService;
import com.copirlo.ProjectManager.service.TaskListService;
import org.springframework.ui.Model;

@Controller
public class BoardController {
    private final BoardService boardService;
    private final TaskListService taskListService;
    private final SessionService sessionService;

    public BoardController(
            BoardService boardService,
            TaskListService taskListService,
            SessionService sessionService) {
        this.boardService = boardService;
        this.taskListService = taskListService;
        this.sessionService = sessionService;
    }

    @RequestMapping("/board/{boardId}")
    public String index(Model model, @PathVariable("boardId") int boardId) {
        if (!sessionService.checkMember(boardId)) {
            return "401";
        }
        model.addAttribute("boardId", boardId);
        model.addAttribute("taskLists", taskListService.getTaskLists(boardId));
        model.addAttribute("taskListDto", new TaskListDto());
        model.addAttribute("taskDto", new TaskDto());
        model.addAttribute("commentDto", new CommentDto());
        return "board";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/updateBoard")
    public String updateBoard(@ModelAttribute("updateBoard") Board board) {
        this.boardService.updateBoard(board);
        return "redirect:/";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/addBoard")
    public String addBoard(@ModelAttribute("newBoard") Board board) {
        int userId = (int) this.sessionService.sessionConfig().getAttribute("userId");
        this.boardService.addBoard(board, userId);
        return "redirect:/";
    }

    @RequestMapping("/deleteBoard/{boardId}")
    public String deleteBoard(@PathVariable("boardId") int boardId) {
        this.boardService.deleteBoard(boardId);
        return "redirect:/";
    }
}