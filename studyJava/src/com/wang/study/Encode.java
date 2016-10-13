package com.wang.study;

import java.io.UnsupportedEncodingException;

/**
 * Created by wang on 2016/9/29.
 */
public class Encode {
    public static void main(String[] args) throws UnsupportedEncodingException {
        String s = "1234";
        String s1 = new String(s.getBytes("ISO8859-1"),"UTF-8");
        String s2 = new String(s.getBytes("UTF-8"),"ISO8859-1");
        String s3 = new String(s.getBytes("UTF-8"),"GBK");
        String s4 = new String(s.getBytes("GBK"),"UTF-8");
        System.out.println(s+s1+s2+s3+s4);
    }
}
