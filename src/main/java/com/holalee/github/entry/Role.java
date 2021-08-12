package com.holalee.github.entry;

import lombok.Data;
import java.util.Date;

@Data
public class Role {
    private Long id;
    private String code;
    private String name;
    private Date createdTime;

}
