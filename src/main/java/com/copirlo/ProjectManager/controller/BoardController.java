package com.copirlo.ProjectManager.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.copirlo.ProjectManager.dto.CommentDto;
import com.copirlo.ProjectManager.dto.TaskDto;
import com.copirlo.ProjectManager.dto.TaskListDto;
import com.copirlo.ProjectManager.entity.Board;
import com.copirlo.ProjectManager.entity.TaskList;
import com.copirlo.ProjectManager.service.BoardService;
import com.copirlo.ProjectManager.service.TaskListService;
import com.copirlo.ProjectManager.service.UserService;
import org.springframework.ui.Model;

@Controller
public class BoardController {
    private final BoardService boardService;
    private final TaskListService taskListService;
    private final UserService userService;

    public BoardController(
            BoardService boardService,
            TaskListService taskListService,
            UserService userService) {
        this.boardService = boardService;
        this.taskListService = taskListService;
        this.userService = userService;
    }

    @RequestMapping("/board/{boardId}")
    public String index(Model model, @PathVariable("boardId") int boardId) {
        if (!this.userService.checkMember(boardId)) {
            return "401";
        }
        List<TaskList> taskLists = this.taskListService.getTaskLists(boardId).stream()
                .sorted((a1, b2) -> Integer.compare(a1.getPosition(), b2.getPosition()))
                .toList();
        for (TaskList taskList : taskLists) {
            taskList.setTasks(taskList.getTasks().stream()
                    .sorted((a1, b2) -> Integer.compare(a1.getPosition(), b2.getPosition()))
                    .toList());
        }
        model.addAttribute("boardId", boardId);
        model.addAttribute("taskLists", taskLists);
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
        int userId = (int) this.userService.sessionConfig().getAttribute("userId");
        this.boardService.addBoard(board, userId);
        return "redirect:/";
    }

    @RequestMapping("/deleteBoard/{boardId}")
    public String deleteBoard(@PathVariable("boardId") int boardId) {
        this.boardService.deleteBoard(boardId);
        return "redirect:/";
    }
}