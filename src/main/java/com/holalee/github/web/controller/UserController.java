package com.holalee.github.web.controller;

import com.holalee.github.dto.Pagination;
import com.holalee.github.web.ResponseResult;
import com.holalee.github.entry.User;
import com.holalee.github.exception.ServiceException;
import com.holalee.github.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 用户页面
     * @return
     */
    @GetMapping(value = "/user")
    public String index(){

        return "user/user";
    }


    /**
     * 查询用户
     * @param id 参数
     * @return
     */
    @GetMapping(value = "/users/{id}")
    @ResponseBody
    public ResponseResult<User> findById(@PathVariable("id") Long id){
        ResponseResult result = ResponseResult.ok();
        try {
            User user = userService.findById(id);
            result.setData(user);
        } catch (Exception e) {
            result.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
        }

        return result;
    }


    /**
     * 查询用户
     * @param user 查询参数
     * @param page 当前页码
     * @param size 返回记录数
     * @return
     */
    @GetMapping(value = "/users")
    @ResponseBody
    public ResponseResult<User> users(User user, Integer page, Integer size){
        ResponseResult result = ResponseResult.ok();
        try {
            Pagination<User> pagination = userService.findList(user,page,size);
            result.setTotal(pagination.getTotal());
            result.setData(pagination.getItems());
        } catch (Exception e) {
            result.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
        }

        return result;
    }



    /**
     * 新增
     * @param user
     * @return
     */
    @PostMapping(value = "/users")
    @ResponseBody
    public ResponseResult<User> add(User user) {
        ResponseResult result = ResponseResult.ok();
        try {
            userService.add(user);
        } catch (ServiceException e) {
            result.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            result.setMessage(e.getMessage());
        } catch (Exception e) {
            result.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
        }

        return result;
    }

    /**
     * 修改
     * @param user
     * @return
     */
    @PutMapping(value = "/users")
    @ResponseBody
    public ResponseResult<User> update(User user) {
        ResponseResult result = ResponseResult.ok();
        try {
            userService.update(user);
        } catch (ServiceException e) {
            result.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            result.setMessage(e.getMessage());
        } catch (Exception e) {
            result.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
        }

        return result;
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    @DeleteMapping(value = "/users")
    @ResponseBody
    public ResponseResult<User> delete(@RequestParam("ids[]") Long[] ids) {
        ResponseResult result = ResponseResult.ok();
        try {
            userService.delete(Arrays.asList(ids));
        } catch (ServiceException e) {
            result.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
            result.setMessage(e.getMessage());
        } catch (Exception e) {
            result.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
        }

        return result;
    }

}
