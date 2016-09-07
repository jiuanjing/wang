package com.wang.app1;

import com.wang.com.wang.utils.DbUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by wangdegang on 2016/9/4.
 */
@WebServlet(name ="login",value = "/loginServlet")
public class LoginServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        this.doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        response.setCharacterEncoding("utf-8");

        String sql = "select t.username,t.password from dim_user t where t.username = '"
                + username + "' and t.password ='" + password +"'";

        DbUtils dbUtils = new DbUtils();
        PrintWriter out = response.getWriter();
        try {
            if (dbUtils.dbOpen()){
                ResultSet resultSet = dbUtils.executeQuery(sql);
                if (resultSet.next()){
                    //不能使用重定向，因为会导致原有的request失效
                    request.getRequestDispatcher("app-1/success.jsp").forward(request,response);
                }else {
                    out.write("<script>alert('用户名或密码错误');</script>");
                    response.sendRedirect("app-1/login.html");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
