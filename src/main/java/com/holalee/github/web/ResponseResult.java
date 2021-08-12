package com.holalee.github.web;

import lombok.Data;

@Data
public class ResponseResult<T> {

    /**
     * 状态吗
     */
    private int status = 200;

    /**
     * 状态消息
     */
    private String message = "成功";

    /**
     * 记录数
     */
    private int total;

    /**
     * 数据
     */
    private T data;

    public static ResponseResult ok() {
        return new ResponseResult();
    }

}
