package org.seckill.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.entity.Seckilled;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import static org.junit.Assert.*;

/**
 * Created by wang on 2016/9/25.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class SuccessKilledDaoTest {
    @Resource
    private SuccessKilledDao successKilledDao;

    @Test
    public void insertSuccessKilled() throws Exception {
        long id = 1000l;
        long phone = 18315594457l;
        int insertCount = successKilledDao.insertSuccessKilled(id, phone);
        System.out.println("insertCount" + insertCount);
    }

    @Test
    public void queryByIdWithSeckill() throws Exception {
        long id = 1000l;
        long phone = 18315594457l;
        Seckilled seckilled = successKilledDao.queryByIdWithSeckill(id,phone);
        System.out.println(seckilled);
        System.out.println(seckilled.getSeckill());
    }
}