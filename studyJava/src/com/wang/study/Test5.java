package com.wang.study;

public class Test5 {
    String name = "aa";
    public void test1(){
        System.out.println(name);
        String name ="dd";
        System.out.println(name);
    }

    public static void main(String[] args) {
        Test5 test5 = new Test5();
        test5.test1();
    }
}
