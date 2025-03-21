package com.copirlo.ProjectManager.dto;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

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

    @DateTimeFormat(pattern = "dd/MM/yyyy")
    private Date dueDate;
}
