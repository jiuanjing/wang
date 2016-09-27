package org.seckill.dto;

import org.seckill.entity.Seckilled;
import org.seckill.enums.SeckillStatEnum;

/**
 * 封装秒杀执行后的结果
 * Created by wang on 2016/9/25.
 */
public class SeckillExecution {
    private  long seckillId;
    private int state;//秒杀状况
    private String stateInfo;//秒杀信息
    private Seckilled seckilled;

    public SeckillExecution(long seckillId, SeckillStatEnum statEnum) {
        this.seckillId = seckillId;
        this.state = statEnum.getState();
        this.stateInfo = statEnum.getStateInfo();
    }

    public SeckillExecution(long seckillId, SeckillStatEnum statEnum, Seckilled seckilled) {
        this.seckillId = seckillId;
        this.state = statEnum.getState();
        this.stateInfo = statEnum.getStateInfo();
        this.seckilled = seckilled;
    }

    public long getSeckillId() {
        return seckillId;
    }

    public void setSeckillId(long seckillId) {
        this.seckillId = seckillId;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getStateInfo() {
        return stateInfo;
    }

    public void setStateInfo(String stateInfo) {
        this.stateInfo = stateInfo;
    }

    public Seckilled getSeckilled() {
        return seckilled;
    }

    public void setSeckilled(Seckilled seckilled) {
        this.seckilled = seckilled;
    }
}
