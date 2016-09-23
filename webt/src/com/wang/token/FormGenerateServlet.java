package com.wang.token;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;

public class FormGenerateServlet extends HttpServlet{
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        PrintWriter out = resp.getWriter();
        try {
            TokenProcessor.getInstance().saveToken(req);
            String token = (String) req.getSession().getAttribute(TokenProcessor.FORM_TOKEN_KEY);
            out.print("");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }
}
