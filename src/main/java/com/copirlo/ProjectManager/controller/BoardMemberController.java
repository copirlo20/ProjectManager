package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.copirlo.ProjectManager.dto.MemberDto;
import com.copirlo.ProjectManager.service.BoardMemberService;

@Controller
public class BoardMemberController {
    private final BoardMemberService boardMemberService;

    public BoardMemberController(BoardMemberService boardMemberService) {
        this.boardMemberService = boardMemberService;
    }

    @RequestMapping(method = RequestMethod.POST, value = "/addMember")
    public String addBoardMember(@ModelAttribute("newMember") MemberDto memberDto, Model model) {
        this.boardMemberService.addBoardMember(memberDto);
        return "redirect:/";
    }
}
