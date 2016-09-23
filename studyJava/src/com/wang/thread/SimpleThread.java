package com.wang.thread;

import static java.lang.System.*;

public class SimpleThread extends Thread {
    private int countDown = 5;
    private int threadNumber;
    private static int threadCount = 0;

    private SimpleThread() {
        threadNumber = ++threadCount;
        out.println("making " + threadNumber);

    }

    @Override
    public void run() {
        while (true) {
            out.println("thread" + threadNumber
                    + "(" + countDown + ")");
            if (--countDown == 0) return;
        }
    }

    public static void main(String[] args) {
        for (int i =0;i<5;i++){
            new SimpleThread().start();
        }
        Mon m = new Mon();
        m.com();
        out.println("all threads started");
    }
}
