package com.wang.jdk8;

/**
 * Created by wang on 2016/9/29.
 */
public class FileTest {
    int i;
    Integer j;

    public static void main(String[] args) {
        FileTest fileTest = new FileTest();

        System.out.println(fileTest.i/*+fileTest.j8*/);
    }
//    public static void main(String[] args) {
//        new Thread(() -> {
//            for (int i = 0; i < 9; i++) {
//                System.out.println(String.format("message %d from the" +
//                        "inside the thread", i));
//            }
//        }).start();
//    }
//    int get(int i,float f){
//        return i;
//    }
//    int get(float f,int i){
//        return i;
//    }
}
