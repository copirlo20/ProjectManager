package com.copirlo.ProjectManager.dto;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TaskDto {
    private Integer taskListId;
    private String title;
    private String description;
    private Date dueDate;
}
