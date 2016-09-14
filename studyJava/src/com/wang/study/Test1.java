package com.wang.study;
/**
 * 在继承的时候，实例方法被覆盖，静态方法被隐藏。
 * 试图使用静态方法覆盖实例方法，或者实例方法覆盖静态方法都会报错
 * 结论：永远不要去覆盖静态方法
 */
public class Test1 {
    public static void main(String[] args) {
        //子类实际上是被强转为父类了
        Super s = new Sub();
        System.out.println(s.name() +":"+ s.greeting());
    }
}

class Super{
    static String greeting(){
        return "super greeting";
    }
    String name(){
        return "super name";
    }
}
class Sub extends Super{

    static String greeting(){

        return "sub greeting";
    }
    String name(){
        return "sub name";
    }

}
