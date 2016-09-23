package com.wang.study;

/**
 * 构造函数没有返回值，首字母大写
 * Created by wangdegang on 2016/9/14.
 */
public class Test2 {
    private int x = 100;
    private int z;

    private Test2() {
        x = 39;
        int y = 54;
        z = x + y;
    }

    /**
     * this访问当前类的成员变量，场景是当前的方法体
     * 内部含有和成员变量同名的局部变量
     */
    private void test() {
        int x = 200;
        System.out.println(x + ":" + this.x);
    }

    private void printResults() {
        System.out.println("z= " + z);
    }

    public static void main(String[] args) {
        Test2 test2 = new Test2();
        test2.printResults();
        test2.test();
    }
}
