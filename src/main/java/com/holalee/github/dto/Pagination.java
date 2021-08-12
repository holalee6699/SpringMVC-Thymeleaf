package com.holalee.github.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class Pagination<T> {
    public static Integer DEFAULT_PAGE_SIZE = 10;
    /**
     * 页码
     */
    private Integer page;

    /**
     * 页码大小
     */
    private Integer pageSize;

    /**
     *  总页数
     */
    private Integer pageCount;

    /**
     * 总记录数
     */
    private Integer total;

    /**
     * 分页数据
     */
    private List<T> items;

    public Pagination(){
        this.page = 1;
        this.total = 0;
        this.pageSize = DEFAULT_PAGE_SIZE;
        this.items = new ArrayList<>();
        this.pageCount = 0;
    }

    public Pagination(Integer page,Integer total,Integer pageSize){
        this(page,total,pageSize,null);
    }

    public Pagination(Integer page,Integer total,Integer pageSize,List<T> items){
        this.page = page;
        this.total = total;
        this.pageSize = pageSize;
        this.items = items;
        this.pageCount = (total - 1 ) / this.pageSize + 1;
    }

    public Integer getOffset(){
        return (this.page - 1) *  this.pageSize;
    }

}
