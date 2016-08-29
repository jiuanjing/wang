<%
    /*********************************************************************************************************************************
     *程序名称：login.jsp
     *功能说明：该程序是接收系统首界面的请求，接收用户输入的登录号和密码，并检查用户是否登录成功，如果登录成功，则初始化一个会话对象
     *编写人：万怀
     *编写时间：2015-9-1
     *
     *********************************************************************************************************************************/
%>
<html>
<head>
    <title>欢迎登录系统</title>
</head>
<body>

<%@ page contentType="text/html; charset=UTF-8" language="java"
         import="com.bws.tools.ChStr" %>
<jsp:useBean id="conn" scope="page" class="com.bws.dbOperation.DBOperation"/>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%
    String user_account = ChStr.chStr(request.getParameter("user_account"));
    String user_password = request.getParameter("user_password");

    try {
        if (userInfo.check_login(user_account, user_password, conn, userInfo)) {
            response.sendRedirect("../SystemFrame/MainFrame.jsp");
        } else {
            out.println("<script language='javascript'>alert('您输入的用户不存在或者密码错误，或您的账户已经被冻结，请重试或与管理员联系!');window.location.href='../index.html';</script>");
        }


    } catch (Exception e) {
        out.println("<script language='javascript'>alert('系统出现故障或您的操作有误!，请重新再试或与管理员联系。');window.location.href='../index.html';</script>");
    }
    conn.dbClose();
%>

</body>
</html>