<%
    /**************************************************************************************************************
     *程序名称：UserCtl.jsp
     *功能说明：该程序接收UserInfoChange.jsp的请求，组织参数来实例化对象，完成用户信息的修改
     *编写人：万怀
     *编写时间：2014-09-12
     **************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.bws.tools.ChStr,com.bws.util.UserObj" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%!
    UserObj obj;

    public boolean acceptData(HttpServletRequest req) {
        System.out.print(req.getParameter("RoleID"));
        obj = new UserObj(req.getParameter("UserID"), req.getParameter("UserAccount"), req.getParameter("UserPassword"), ChStr.chStr(req.getParameter("UserName")), req.getParameter("CompanyID"), req.getParameter("DeptID"), ChStr.chStr(req.getParameter("Position")), req.getParameter("RoleID"), req.getParameter("EMail"), req.getParameter("Phone"), req.getParameter("Mobile"), req.getParameter("Status"), req.getParameter("PageSize"), ChStr.chStr(req.getParameter("MicroMSG")), req.getParameter("QQNO"));
        return true;
    }

    public boolean service(String Type, DBOperation db) {
        return obj.saveObj(Type, db);
    }
%>
<HTML>
<HEAD><TITLE>个人信息修改</TITLE>
</HEAD>
<BODY>
<%
    //检查用户权限
    /*****
     if(CheckUserRight.check(userInfo,"107","2",pageContext) == false)
     {
     return ;
     }//检查用户权限代码结束
     *****/
    String type = "";
    String selectedIds = "";
    type = request.getParameter("type");

    if (type == null) {
        throw new Exception("系统没有取到操作的参数！");
    }
    DBOperation db = new DBOperation(false);
    if (db.dbOpen()) {
        try {
            if (this.acceptData(request)) {
                if (this.service(type, db))//执行对数据库的操作
                {
                    db.executeCommit();//提交事务
                    db.dbClose();
                    if (type.equals("update")) {%>
<script>
    alert("您好，修改个人信息已经成功！");
    self.location = "UserInfoChange.jsp";
</script>
<%
    }
} else {
%>
<script>
    alert("对不起！系统在保存数据时出错，请重试或与系统管理员联系！");
    window.history.back();
</script>
<%
                    db.executeRollback();//提交事务
                    db.dbClose();
                    return;
                }
            }
        } catch (Exception e) {
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
%>
</BODY>
</HTML>