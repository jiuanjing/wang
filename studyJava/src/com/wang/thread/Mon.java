package com.wang.thread;

public class Mon {
    public static void main(String[] args) {
        //getMoney();
        com();
    }


    protected static void getMoney() {
        int mouth = 12;
        double sumBefit = 0;
        for (int i = 0; i < mouth; i++) {
            sumBefit = sumBefit + 8.3f * 5 / 3 * i;
        }
        System.out.println(sumBefit);
    }

    public static void com() {
        double a = 0.1;
        double b = 0.01;
        for (int i = 0; i < 10; i++) {
            b = b + 0.01;
        }
        System.out.println(b+":"+(a-b));
    }
}
