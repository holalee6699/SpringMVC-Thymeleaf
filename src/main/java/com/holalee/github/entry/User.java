package com.holalee.github.entry;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
public class User implements Serializable {
    @JsonSerialize(using = ToStringSerializer.class)
    private Long id;
    private String username;
    private String password;
    private String nickname;
    private Integer status;
    private Date createdTime;
    private Date lastModifiedTime;


    /**
     * 部门
     */
    private Department department;

    /**
     * 角色列表
     */
    private List<Role> roles;

}

