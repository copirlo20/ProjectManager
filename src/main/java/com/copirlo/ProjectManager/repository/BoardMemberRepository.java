package com.copirlo.ProjectManager.repository;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.copirlo.ProjectManager.entity.BoardMember;

public interface BoardMemberRepository extends JpaRepository<BoardMember, Integer> {
    List<BoardMember> findByUserId(int userId);

    Optional<BoardMember> findByBoardIdAndUserId(int boardId, int userId);
}
