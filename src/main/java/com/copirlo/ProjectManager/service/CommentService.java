package com.copirlo.ProjectManager.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.copirlo.ProjectManager.dto.CommentDto;
import com.copirlo.ProjectManager.entity.Comment;
import com.copirlo.ProjectManager.repository.CommentRepository;
import com.copirlo.ProjectManager.repository.TaskRepository;
import com.copirlo.ProjectManager.repository.UserRepository;

@Service
public class CommentService {
    private final CommentRepository commentRepository;
    private final TaskRepository taskRepository;
    private final UserRepository userRepository;

    public CommentService(
            CommentRepository commentRepository,
            TaskRepository taskRepository,
            UserRepository userRepository) {
        this.commentRepository = commentRepository;
        this.taskRepository = taskRepository;
        this.userRepository = userRepository;
    }

    public void addComment(CommentDto commentDto) {
        Comment comment = new Comment();
        comment.setContent(commentDto.getContent());
        comment.setTask(this.taskRepository.findById(commentDto.getTaskId()).get());
        comment.setUser(this.userRepository.findById(commentDto.getUserId()).get());
        this.commentRepository.save(comment);
    }

    public List<Comment> getComments(int taskId) {
        List<Comment> comments = this.taskRepository.findById(taskId).get().getComments();
        comments.sort((b1, b2) -> b1.getCreatedAt().compareTo(b2.getCreatedAt()));
        return comments;
    }
}
