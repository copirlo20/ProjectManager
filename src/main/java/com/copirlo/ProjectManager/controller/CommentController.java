package com.copirlo.ProjectManager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.copirlo.ProjectManager.dto.CommentDto;
import com.copirlo.ProjectManager.service.CommentService;

@Controller
public class CommentController {
    private final CommentService commentService;

    public CommentController(
            CommentService commentService) {
        this.commentService = commentService;
    }

    @RequestMapping(value = "/addComment", method = RequestMethod.POST)
    public String addComment(CommentDto commentDto,
            @RequestHeader(value = "Referer", required = false) String referer) {
        this.commentService.addComment(commentDto);
        return "redirect:" + referer;
    }
}
