package com.wang.study;

import java.io.UnsupportedEncodingException;

public class Decode {
    public static void main(String[] args) throws UnsupportedEncodingException {
        String a = "<html>\n" +
                "<head>\n" +
                "    <title>$Title$</title>\n" +
                "\n" +
                "</head>\n" +
                "<body>\n" +
                "<form action=\"hello.jsp\" method=\"get\">\n" +
                "    <label>\n" +
                "        姓名:<input type=\"text\" name=\"name\">\n" +
                "    </label>\n" +
                "    <input type=\"submit\" value=\"提交\">\n" +
                "</form>\n" +
                "\n" +
                "</body>\n" +
                "</html>";

        System.out.println(a.replace(" ",""));
        System.out.println(a.length());


    }
}
