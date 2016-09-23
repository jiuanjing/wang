package com.wang.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
@WebServlet(urlPatterns = "/cookie")
public class CookieServlet1 extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf8");
        PrintWriter out = resp.getWriter();

        String name = req.getParameter("name");
        String nickName = req.getParameter("nickname");
        if (name == null || nickName == null) {
            out.print("请传递参数");
        }
        if ("".equals(name.trim()) || "".equals(nickName.trim())) {
            out.print("不能为空白值");
        } else {
            Cookie ckName = new Cookie("name", name);
            Cookie ckNickName = new Cookie("nickname", nickName);
            ckNickName.setMaxAge(24 * 3600);
            Cookie ckEmail = new Cookie("email", "123@345.com");
            Cookie ckPhone = new Cookie("phone", "123456");
            resp.addCookie(ckName);
            resp.addCookie(ckNickName);
            resp.addCookie(ckEmail);
            resp.addCookie(ckPhone);
        }
        String lastNickname = null;
        Cookie[] cks = req.getCookies();
        for (Cookie c : cks) {
            if ("nickname".equals(c.getName())){
                lastNickname =c.getValue();
                break;
            }
        }
        if (lastNickname !=null){
            out.print("欢迎<b><i>"+lastNickname+"</i></b>");
            out.print("<br>");
        }else {
            out.print("欢迎新客人<br>");
        }
        String ckHeader = req.getHeader("Cookie");
        if (ckHeader != null){
            out.print("cookie头字段如下<br>");
            out.print("cookie"+ckHeader+"<br>");
        }else {
            out.print("没有cookie");
        }
    }
}
