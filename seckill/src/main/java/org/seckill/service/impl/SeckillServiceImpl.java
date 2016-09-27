package org.seckill.service.impl;

import org.seckill.dao.SeckillDao;
import org.seckill.dao.SuccessKilledDao;
import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.seckill.entity.Seckill;
import org.seckill.entity.Seckilled;
import org.seckill.enums.SeckillStatEnum;
import org.seckill.exception.RepeatKillException;
import org.seckill.exception.SeckillCloseExecution;
import org.seckill.exception.SeckillException;
import org.seckill.service.SeckillService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.DigestUtils;

import java.util.Date;
import java.util.List;

/**
 * 业务逻辑的实现
 * Created by wang on 2016/9/25.
 */
public class SeckillServiceImpl implements SeckillService {
    private SeckillDao seckillDao;
    private SuccessKilledDao successKilledDao;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public SeckillExecution executeSeckill(long seckillId, long userPhone, String md5)
            throws SeckillException, RepeatKillException, SeckillCloseExecution {
        if (md5 == null || !(md5.equals(getMd5(seckillId)))) {
            throw new SeckillException("seckill 数据出错");
        }
        //执行秒杀逻辑+记录购买行为
        try {
            Date nowTime = new Date();
            int updateCount = seckillDao.reduceNumber(seckillId, nowTime);
            if (updateCount <= 0) {
                throw new SeckillCloseExecution("秒杀结束了");
            } else {
                int insertCount = successKilledDao.insertSuccessKilled(seckillId, userPhone);
                if (insertCount <= 0) {
                    throw new RepeatKillException("秒杀重复");
                } else {
                    Seckilled seckilled = successKilledDao.
                            queryByIdWithSeckill(seckillId, userPhone);
                    return new SeckillExecution(seckillId, SeckillStatEnum.SUCCESS, seckilled);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            //编译器异常转换为运行期异常
            throw new SeckillException("seckill inner error" + e.getMessage());
        }
    }

    public Exposer exportSeckillUrl(long seckillId) {
        Seckill seckill = seckillDao.queryById(seckillId);
        if (seckill == null) {
            return new Exposer(false, seckillId);
        }
        Date startTime = seckill.getStartTime();
        Date endTime = seckill.getEndTime();
        Date nowTime = new Date();
        if (nowTime.getTime() < startTime.getTime()
                || nowTime.getTime() > endTime.getTime()) {
            return new Exposer(false, seckillId,
                    nowTime.getTime(), startTime.getTime(), endTime.getTime());
        }
        //使用md5进行转换
        String md5 = getMd5(seckillId);
        return new Exposer(true, md5, seckillId);
    }

    private String getMd5(long seckillId) {
        String SLAT = "2y34%$^$^%^%&%&*$^%477%^&^*!(*(@353t7";
        String base = seckillId + "/" + SLAT;
        return DigestUtils.md5DigestAsHex(base.getBytes());
    }

    public List<Seckill> getSeckillList() {
        return seckillDao.queryAll(0, 4);
    }

    public Seckill getById(long seckillId) {

        return seckillDao.queryById(seckillId);
    }
}
