package com.bws.login;

import com.bws.dbOperation.DBOperation;
import com.bws.util.ReadProp;
import com.bws.util.UserInfo;
import com.eetrust.security.plugin.MessageConstants;
import com.eetrust.security.plugin.MessageRequest;
import com.eetrust.security.plugin.SIDPlugin;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/*
 * 用于"时代亿信身份认证系统"的登录
 * 
 * */
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //从sys.properties获取
        String ip = ReadProp.getValue("ip");
        int port = Integer.valueOf(ReadProp.getValue("port"));
        String appCode = ReadProp.getValue("appCode");
        //获取响应值
        String cipher = request.getParameter("cipher");//密码
        String clientIp = request.getRemoteAddr(); //IP地址
        String randnum = request.getParameter("randnum"); //随机数

        //String userPIN = request.getParameter("userPIN");
        response.setCharacterEncoding("UTF-8");
        response.setDateHeader("Expires", 0);
        PrintWriter out = response.getWriter();
        // 设置身份认证系统IP地址, SOCKET通信端口为80
        SIDPlugin sid = new SIDPlugin(ip, port);
        sid.setCommunicationProtocol(MessageRequest.COMMUNICATION_PROTOCOL_HTTP);
        int result = sid.Auth_VerifyV3Cert(appCode, cipher, randnum, clientIp);
        if (result == MessageConstants.SECURITY_SERVICE_SUCCESS) {
            String passport = sid.getPassport();

            UserInfo userInfo = new UserInfo();
            DBOperation db = new DBOperation(true);
            try {
                // 认证成功, 获取用户唯一标识
                if (userInfo.ca_check_login(passport, db, userInfo)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userInfo", userInfo);
                    //System.out.println(userInfo.getUserAccount()+"-"+userInfo.getUserPassword());
                    response.sendRedirect("/SystemFrame/MainFrame.jsp");
                } else {
                    out.print("<script language='javascript'>alert('您输入的用户在该系统不存在或者密码错误，或您的账户已经被冻结，请重试或与管理员联系!');window.location.href='/login.jsp';</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                db.dbClose();
            }
        } else {
            // 认证失败, 获取错误编码
            String errorMsg = sid.getErrorMsg();

            // 认证失败, 获取错误信息
            out.print("<script language='javascript'>alert('" + errorMsg + "');window.location.href='/login.jsp';</script>");

            //System.out.println(errorMsg);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

}
