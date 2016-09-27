package org.seckill.exception;

/**
 * 重复秒杀异常（runtime exception）
 * Created by wang on 2016/9/25.
 */
public class RepeatKillException extends RuntimeException{
    public RepeatKillException(String message) {
        super(message);
    }

    public RepeatKillException(String message, Throwable cause) {
        super(message, cause);
    }
}
