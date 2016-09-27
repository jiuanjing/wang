package org.seckill.exception;

/**
 * 秒杀异常
 * Created by wang on 2016/9/25.
 */
public class SeckillException extends RuntimeException {
    public SeckillException(String message) {
        super(message);
    }

    public SeckillException(String message, Throwable cause) {
        super(message, cause);
    }
}
