package com.holalee.github.entry;

import lombok.Data;

import java.util.Date;

@Data
public class Department {
    private Long id;
    private String code;
    private String name;
    private Date createdTime;
    private Date lastModifiedTime;


}
