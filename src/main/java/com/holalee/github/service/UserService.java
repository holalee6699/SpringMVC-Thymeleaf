package com.holalee.github.service;

import com.holalee.github.dto.Pagination;
import com.holalee.github.entry.User;
import com.holalee.github.exception.ServiceException;

import java.util.List;

public interface UserService {

    /**
     * 根据id查询
     * @param id
     * @return
     */
    User findById(Long id);


    /**
     * 根据账号查询
     * @param username
     * @return
     */
    User findByUsername(String username);

    /**
     * 分页查询
     * @param user 查询参数
     * @param page 页码
     * @param size 返回记录数
     * @return
     */
    Pagination<User> findList(User user, Integer page, Integer size);

    /**
     * 新增
     * @param user
     */
    void add(User user) throws ServiceException;

    /**
     * 修改
     * @param user
     */
    void update(User user) throws ServiceException;

    /**
     * 批量删除
     * @param ids
     */
    void delete(List<Long> ids) throws ServiceException;
}
