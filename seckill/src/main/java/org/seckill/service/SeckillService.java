package org.seckill.service;

import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.seckill.entity.Seckill;
import org.seckill.exception.RepeatKillException;
import org.seckill.exception.SeckillCloseExecution;
import org.seckill.exception.SeckillException;

import java.util.List;

/**
 * Created by wang on 2016/9/25.
 */
public interface SeckillService {

    /**
     * 执行秒杀操作
     *  @param seckillId
     * @param userPhone
     * @param md5
     */
    SeckillExecution executeSeckill(long seckillId, long userPhone, String md5)
            throws SeckillException, RepeatKillException, SeckillCloseExecution;

    /**
     * 秒杀开启时输出秒杀地址，
     * 否则输出系统时间和秒杀时间
     *
     * @param seckillId
     */
    Exposer exportSeckillUrl(long seckillId);

    /**
     * 查询所有的秒杀记录
     *
     * @return list<seckill>
     */
    List<Seckill> getSeckillList();

    /**
     * 查询单个秒杀记录
     *
     * @param seckillId
     * @return
     */
    Seckill getById(long seckillId);
}
