package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
import java.util.List;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.copirlo.ProjectManager.dto.MemberDto;
import com.copirlo.ProjectManager.entity.Board;
import com.copirlo.ProjectManager.service.UserService;

@Controller
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String index(Model model) {
        List<Board> boards = this.userService.getBoard(1);
        model.addAttribute("boards", boards);
        model.addAttribute("newBoard", new Board());
        model.addAttribute("newMember", new MemberDto());
        model.addAttribute("updateBoard", new Board());
        return "index";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/updateBoard")
    public String updateBoard(@ModelAttribute("updateBoard") Board board) {
        this.userService.updateBoard(board);
        return "redirect:/";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/addBoard")
    public String addBoard(@ModelAttribute("newBoard") Board board) {
        this.userService.addBoard(board, 1);
        return "redirect:/";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/addMember")
    public String addBoardMember(@ModelAttribute("newMember") MemberDto memberDto, Model model) {
        this.userService.addBoardMember(memberDto);
        return "redirect:/";
    }
}