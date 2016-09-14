package com.wang.study;

/**
 * 无法访问父类中被子类覆盖的实例方法，静态方法可以访问
 * Created by wangdegang on 2016/9/14.
 */
public class Test3 {
    public static void main(String[] args) {
        DocumentManager documentManager = new DocumentManager();
    }
}

class DocumentManager {
    public Document document() {
        return new HTMLDocument();
    }
}

class Document {
    public boolean spellCheck() {
        return true;
    }
}

class HTMLDocument extends Document {
    public boolean spellCheck() {
        System.out.println("htmlDocument checking spell");
        return false;
    }
}