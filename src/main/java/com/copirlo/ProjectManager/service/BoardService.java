package com.copirlo.ProjectManager.service;

import java.util.List;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;
import com.copirlo.ProjectManager.entity.Board;
import com.copirlo.ProjectManager.entity.BoardMember;
import com.copirlo.ProjectManager.repository.BoardMemberRepository;
import com.copirlo.ProjectManager.repository.BoardRepository;
import com.copirlo.ProjectManager.repository.UserRepository;

@Service
public class BoardService {
    private final BoardRepository boardRepository;
    private final BoardMemberRepository boardMemberRepository;
    private final UserRepository userRepository;

    public BoardService(
            BoardRepository boardRepository,
            BoardMemberRepository boardMemberRepository,
            UserRepository userRepository) {
        this.userRepository = userRepository;
        this.boardRepository = boardRepository;
        this.boardMemberRepository = boardMemberRepository;
    }

    public List<Board> getBoard(int userId) {
        List<BoardMember> boardMembers = this.boardMemberRepository.findByUserId(userId);
        List<Board> boards = boardMembers.stream()
                .map(BoardMember::getBoard)
                .sorted((b1, b2) -> b2.getCreatedAt().compareTo(b1.getCreatedAt()))
                .collect(Collectors.toList());
        return boards;
    }

    public void addBoard(Board board, int userId) {
        board.setCreatedBy(this.userRepository.findById(userId).orElse(null));
        this.boardRepository.save(board);
        BoardMember boardMember = new BoardMember();
        boardMember.setBoard(board);
        boardMember.setUser(this.userRepository.findById(userId).orElse(null));
        boardMember.setRole("Admin");
        this.boardMemberRepository.save(boardMember);
    }

    public void updateBoard(Board updateBoard) {
        Board board = this.boardRepository.findById(updateBoard.getId()).orElse(null);
        board.setName(updateBoard.getName());
        board.setDescription(updateBoard.getDescription());
        this.boardRepository.save(board);
    }

    public void deleteBoard(int boardId) {
        this.boardRepository.deleteById(boardId);
    }
}