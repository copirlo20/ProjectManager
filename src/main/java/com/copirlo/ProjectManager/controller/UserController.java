package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
import java.util.List;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.copirlo.ProjectManager.dto.MemberDto;
import com.copirlo.ProjectManager.entity.Board;
import com.copirlo.ProjectManager.service.BoardService;
import com.copirlo.ProjectManager.service.SessionService;

@Controller
public class UserController {
    private final BoardService boardService;
    private final SessionService sessionService;

    public UserController(BoardService boardService, SessionService sessionService) {
        this.boardService = boardService;
        this.sessionService = sessionService;
    }

    @RequestMapping("/login")
    public String getLoginPage() {
        return "login";
    }

    @RequestMapping("/")
    public String index(Model model) {
        int userId = (int) this.sessionService.sessionConfig().getAttribute("userId");
        List<Board> boards = this.boardService.getBoard(userId);
        model.addAttribute("boards", boards);
        model.addAttribute("newBoard", new Board());
        model.addAttribute("newMember", new MemberDto());
        model.addAttribute("updateBoard", new Board());
        return "index";
    }
}