package org.seckill.dao;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.Seckilled;

/**
 * Created by wang on 2016/9/25.
 */
public interface SuccessKilledDao {
    /**
     * 插入购买明细，可过滤重复
     *
     * @param seckillId
     * @param userPhone
     * @return
     */
    int insertSuccessKilled(@Param("seckillId") long seckillId,@Param("userPhone") long userPhone);

    /**
     * 根据id查询successKill
     *
     * @param seckillId
     * @return
     */
    Seckilled queryByIdWithSeckill(@Param("seckillId") long seckillId,@Param("userPhone") long userPhone);
}
