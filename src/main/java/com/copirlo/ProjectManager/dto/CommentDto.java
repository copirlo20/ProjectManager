package com.copirlo.ProjectManager.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentDto {
    private String content;
    private Integer taskId;
    private Integer userId;
}