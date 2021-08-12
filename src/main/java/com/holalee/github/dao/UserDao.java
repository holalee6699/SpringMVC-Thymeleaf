package com.holalee.github.dao;

import com.holalee.github.entry.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {

    /**
     * 分页查询
     * @param user 查询条件
     * @param offset 偏移量
     * @param size 返回记录数
     * @return
     */
    List<User>  selectUsers(@Param("user") User user, @Param("offset") Integer offset, @Param("size") Integer size);

    /**
     * 统计记录数
     * @param user
     * @return
     */
    int count(@Param("user") User user);

    /**
     * 根据status查询
     * @param status
     * @return
     */
    User selectByStatus(int status);

    /**
     * 根据id查询
     * @param id
     * @return
     */
    User selectById(Long id);

    /**
     * 根据账号查询
     * @param username
     * @return
     */
    User selectByUsername(String username);

    /**
     * 新增
     * @param user
     * @return
     */
    int insert(User user);

    /**
     * 修改
     * @param user
     * @return
     */
    int update(User user);

    /**
     * 删除
     * @param id
     * @return
     */
    int delete(Long id);

    /**
     * 批量删除
     * @param ids
     * @return
     */
    int batchDelete(@Param("ids") List<Long> ids);

}
