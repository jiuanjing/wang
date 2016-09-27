package org.seckill.exception;

/**
 * Created by wang on 2016/9/25.
 */
public class SeckillCloseExecution extends RuntimeException {
    public SeckillCloseExecution(String message) {
        super(message);
    }

    public SeckillCloseExecution(String message,Throwable cause) {
        super(message,cause);
    }
}
