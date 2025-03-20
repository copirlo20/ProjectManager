package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
import java.util.List;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.copirlo.ProjectManager.dto.MemberDto;
import com.copirlo.ProjectManager.entity.Board;
import com.copirlo.ProjectManager.service.BoardService;
import com.copirlo.ProjectManager.service.UserService;

@Controller
public class UserController {
    private final UserService userService;
    private final BoardService boardService;

    public UserController(UserService userService, BoardService boardService) {
        this.userService = userService;
        this.boardService = boardService;
    }

    @RequestMapping("/")
    public String index(Model model) {
        List<Board> boards = this.boardService.getBoard(1);
        model.addAttribute("boards", boards);
        model.addAttribute("newBoard", new Board());
        model.addAttribute("newMember", new MemberDto());
        model.addAttribute("updateBoard", new Board());
        return "index";
    }
}