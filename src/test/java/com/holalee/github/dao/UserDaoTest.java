package com.holalee.github.dao;

import com.holalee.github.entry.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Arrays;


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
public class UserDaoTest {
    @Autowired
    private UserDao userDao;

    @Test
    public void selectUsers(){
        User user = new User();
        System.out.println(userDao.selectUsers(user,0,10));
    }

    @Test
    public void count(){
        User user = new User();
        System.out.println(userDao.count(user));
    }


    @Test
    public void delete(){
        System.out.println(userDao.batchDelete(Arrays.asList(1346741662986145792L,1347533092893626368L)));
    }
}
