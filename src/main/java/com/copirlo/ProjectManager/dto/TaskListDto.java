package com.copirlo.ProjectManager.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TaskListDto {
    private String name;
    private Integer boardId;
}
