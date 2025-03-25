package com.copirlo.ProjectManager.service;

import org.springframework.stereotype.Service;
import com.copirlo.ProjectManager.dto.MemberDto;
import com.copirlo.ProjectManager.entity.BoardMember;
import com.copirlo.ProjectManager.repository.BoardMemberRepository;
import com.copirlo.ProjectManager.repository.BoardRepository;
import com.copirlo.ProjectManager.repository.UserRepository;

@Service
public class BoardMemberService {
    private final UserRepository userRepository;
    private final BoardRepository boardRepository;
    private final BoardMemberRepository boardMemberRepository;

    public BoardMemberService(
            UserRepository userRepository,
            BoardRepository boardRepository,
            BoardMemberRepository boardMemberRepository) {
        this.userRepository = userRepository;
        this.boardRepository = boardRepository;
        this.boardMemberRepository = boardMemberRepository;
    }

    public String addBoardMember(MemberDto memberDto) {
        if (this.userRepository.findByEmail(memberDto.getEmail()).isEmpty()) {
            return "Email chưa đăng ký";
        }
        if (this.boardMemberRepository.findByBoardIdAndUserId(memberDto.getBoardId(),
                this.userRepository.findByEmail(memberDto.getEmail()).orElse(null).getId()).isPresent()) {
            return "Thành viên đã tồn tại";
        }
        BoardMember boardMember = new BoardMember();
        boardMember.setBoard(this.boardRepository.findById(memberDto.getBoardId()).orElse(null));
        boardMember.setUser(this.userRepository.findByEmail(memberDto.getEmail()).orElse(null));
        boardMember.setRole(memberDto.getRole());
        this.boardMemberRepository.save(boardMember);
        return "Thành viên đã được thêm";
    }

    public boolean checkMember(int boarId, int userId) {
        return this.boardMemberRepository.findByBoardIdAndUserId(boarId, userId).isPresent();
    }
}
