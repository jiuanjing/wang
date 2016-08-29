package com.bws.tools;


public class Test extends Thread {

    public Test(String name) {
        super(name);
    }

    public void run() {
        for (int i = 0; i < 100; i++) {
            System.out.println(this.getName() + " :" + i);
        }
    }

    public static void main(String[] args) {
        Thread t1 = new Test("阿三");
        Thread t2 = new Test("李四");
        t1.start();
        t2.start();
    }
}