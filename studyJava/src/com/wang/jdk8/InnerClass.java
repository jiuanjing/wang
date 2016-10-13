package com.wang.jdk8;

/**
 * Created by wang on 2016/10/10.
 */
public class InnerClass {
    public static void main(String[] args) {
        int i = 0;
        Integer j = new Integer("");
        System.out.println(i + ":" + j);
    }
}

abstract class Name {
    private String name;

}

class sim {
    public static void main(String[] args) {
        sim s = new sim();

    }

    public String doS() {
        return "dos";
    }
}

class HasStatic {
    private static int x = 100;

    public static void main(String[] args) {
        HasStatic h1 = new HasStatic();
        h1.x++;
        HasStatic h2 = new HasStatic();
        h2.x++;
        h1 = new HasStatic();
        h1.x++;
        System.out.println(x);
    }
}
