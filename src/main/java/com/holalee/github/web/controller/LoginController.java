package com.holalee.github.web.controller;

import com.holalee.github.entry.User;
import com.holalee.github.service.UserService;
import com.holalee.github.web.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    /**
     * 跳到登录页面
     * @return
     */
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public ModelAndView login(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("login");
        mv.addObject("test","hello");

        return mv;
    }


    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    public ResponseResult doLogin(String username, String password, HttpServletRequest request){
        ResponseResult result = ResponseResult.ok();
        result.setMessage("登录成功");

        //参数校验
        if (username == null || "".equals(username.trim()) ||
                password == null || "".equals(password.trim())){
            result.setStatus(HttpStatus.BAD_REQUEST.value());
            result.setMessage("账号密码不能为空");
            return result;
        }
        User user = userService.findByUsername(username);
        //判断账号是否存在
        if (user == null){
            result.setStatus(HttpStatus.BAD_REQUEST.value());
            result.setMessage("账号不存在");
            return result;
        }

        //判断密码是否正确
        if (!password.equals(user.getPassword())){
            result.setStatus(HttpStatus.BAD_REQUEST.value());
            result.setMessage("密码不正确");
            return result;
        }

        // 将当前登录用户信息保存到会话中
        request.getSession().setAttribute("currentUser",user);

        return result;
    }


    /**
     * 执行登录
     * @return
     */
/*    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String doLogin(String username, String password, HttpServletRequest request){
        //参数校验
        if (username == null || "".equals(username.trim()) ||
                password == null || "".equals(password.trim())){
            request.setAttribute("error","账号密码不能为空");
            return "login";
        }
        User user = userService.findByUsername(username);
        //判断账号是否存在
        if (user == null){
            request.setAttribute("error","账号不能为空");
            return "login";
        }

        //判断密码是否正确
        if (!password.equals(user.getPassword())){
            request.setAttribute("error","密码不正确");
            return "login";
        }
        return "redirect: /";
    }
 */


    /**
     * 退出登录
     * @param request
     * @return
     */
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(HttpServletRequest request){
        // 销毁当前会话
        request.getSession().invalidate();
        //重定向到登录页面
        return "redirect: /login";
    }


}
