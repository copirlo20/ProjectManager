package com.copirlo.ProjectManager.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.copirlo.ProjectManager.entity.Board;

public interface BoardRepository extends JpaRepository<Board, Integer> {
    boolean existsById(int id);
}
