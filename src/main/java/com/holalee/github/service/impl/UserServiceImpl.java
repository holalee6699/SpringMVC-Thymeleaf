package com.holalee.github.service.impl;

import com.holalee.github.dao.UserDao;
import com.holalee.github.dto.Pagination;
import com.holalee.github.service.UserService;
import com.holalee.github.entry.User;
import com.holalee.github.exception.ServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;


@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public User findById(Long id) {
        return userDao.selectById(id);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.selectByUsername(username);
    }

    @Override
    public Pagination<User> findList(User user, Integer page, Integer size) {
        // 分页信息
        Pagination<User> pagination = new Pagination<>();

        // 总记录数
        Integer total = userDao.count(user);

        if (total == 0){
            return pagination;
        }

        pagination = new Pagination<>(page,total,size);

        // 分页数据
        List<User> users = userDao.selectUsers(user,pagination.getOffset(),size);
        pagination.setItems(users);

        return pagination;
    }

    @Override
    public void add(User user) throws ServiceException{
        if (user == null){
            return;
        }

        //判断账号是否重复
        User existUser = userDao.selectByUsername(user.getUsername());
        if (existUser != null ){
            return;
        }

        user.setId(2021L);
        userDao.insert(user);
    }

    @Override
    public void update(User user) throws ServiceException{
        if (user == null){
            return;
        }

        // 修改时间
        user.setLastModifiedTime(new Date());
        userDao.update(user);
    }

    @Override
    public void delete(List<Long> ids) throws ServiceException {
        if (ids == null || ids.isEmpty()){
            return;
        }
        userDao.batchDelete(ids);
    }
}
