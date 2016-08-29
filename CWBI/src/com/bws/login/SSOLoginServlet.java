package com.bws.login;

import com.bws.dbOperation.DBOperation;
import com.bws.util.ReadProp;
import com.bws.util.UserInfo;
import com.eetrust.security.plugin.MessageConstants;
import com.eetrust.security.plugin.SIDPlugin;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 单点登录
 */
public class SSOLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SSOLoginServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ip = ReadProp.getValue("ip");
        int port = Integer.valueOf(ReadProp.getValue("port"));
        String appCode = ReadProp.getValue("appCode");
        SIDPlugin sid = new SIDPlugin(ip, port);
        String ticket = request.getParameter("ticket");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if (null == ticket || ticket == "") {
            return;
        } else {
            int result = sid.Security_VerifyTicket(appCode, ticket);
            if (result == MessageConstants.SECURITY_SERVICE_SUCCESS) { //0成功  非0 失败
                String passport = sid.getPassport();//得到身份证号
                UserInfo userInfo = new UserInfo();
                DBOperation db = new DBOperation(true);
                try {
                    if (userInfo.ca_check_login(passport, db, userInfo)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("userInfo", userInfo);
                        response.sendRedirect("/SystemFrame/MainFrame.jsp");
                    } else {
                        out.print("<script language='javascript'>alert('您还未拥有该系统权限，或您的账户已经被冻结，请重试或与管理员联系!');</script>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    db.dbClose();
                }
            } else {
                //出现错误,进行错误处理
                out.print("<script>alert('" + sid.getErrorCode() + sid.getErrorMsg() + "');</script>");
                return;
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

}
