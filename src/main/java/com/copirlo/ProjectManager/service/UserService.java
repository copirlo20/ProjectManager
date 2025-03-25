package com.copirlo.ProjectManager.service;

import org.springframework.stereotype.Service;
import com.copirlo.ProjectManager.entity.User;
import com.copirlo.ProjectManager.repository.BoardMemberRepository;
import com.copirlo.ProjectManager.repository.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

@Service
public class UserService {
    private final HttpServletRequest request;
    private final UserRepository userRepository;
    private final BoardMemberRepository boardMemberRepository;

    public UserService(
            HttpServletRequest request,
            UserRepository userRepository,
            BoardMemberRepository boardMemberRepository) {
        this.userRepository = userRepository;
        this.request = request;
        this.boardMemberRepository = boardMemberRepository;
    }

    public HttpSession sessionConfig() {
        HttpSession session = this.request.getSession(false);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        User user = this.userRepository.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));
        session.setAttribute("userId", user.getId());
        session.setAttribute("email", email);
        session.setAttribute("fullName", user.getFullName());
        return session;
    }

    public boolean checkMember(int boardId) {
        return this.boardMemberRepository
                .findByBoardIdAndUserId(boardId, (Integer) sessionConfig().getAttribute("userId")).isPresent();
    }

    public User findByEmail(String email) {
        return this.userRepository.findByEmail(email).orElse(null);
    }
}