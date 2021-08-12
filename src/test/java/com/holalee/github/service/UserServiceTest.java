package com.holalee.github.service;

import com.holalee.github.entry.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


/**
 * (1) 配置：全局配置(mybatis-config.xml，数据源等)、映射器(XXXMapper)
 * (2) 构造SqlSessionFactory：new SqlSessionFactoryBuilder().build(config)
 * (3) 创建SqlSession：sqlSessionFactory.openSession()
 *
 * @author DingLong
 * @Date 2020/11/16 上午11:16
 * @explanatory:
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:beans.xml"})
public class UserServiceTest {
    @Autowired
    private UserService userService;

    @Test
    public void test(){
        User user = new User();
        System.out.println(userService.findList(user,0,10));
    }

    @Test
    public void update(){
        User user = new User();
        user.setId(1603509368929L);
        user.setNickname("管理员");
        userService.update(user);
    }
}
