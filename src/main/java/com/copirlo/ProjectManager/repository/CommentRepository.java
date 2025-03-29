package com.copirlo.ProjectManager.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.copirlo.ProjectManager.entity.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {
}
