package com.copirlo.ProjectManager.service;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import com.copirlo.ProjectManager.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class SessionService {
    private final HttpServletRequest request;
    private final UserService userService;
    private final BoardMemberService boardMemberService;

    public SessionService(HttpServletRequest request, UserService userService, BoardMemberService boardMemberService) {
        this.userService = userService;
        this.request = request;
        this.boardMemberService = boardMemberService;
    }

    public HttpSession sessionConfig() {
        HttpSession session = this.request.getSession(false);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        User user = this.userService.findByEmail(email);
        session.setAttribute("userId", user.getId());
        session.setAttribute("email", email);
        return session;
    }

    public boolean checkMember(int boardId) {
        return this.boardMemberService.checkMember(boardId, (Integer) sessionConfig().getAttribute("userId"));
    }
}
