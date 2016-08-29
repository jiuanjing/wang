<%
    /**************************************************************************************************************
     *程序名称：DepartmentCtl.jsp
     *功能说明：该程序接收DepartmentItf.jsp的请求，组织参数来实例化对象，完成部门信息的新增、修改和删除
     *编写人：万怀
     *编写时间：2014-09-12
     **************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.bws.tools.ChStr,com.bws.util.DepartmentObj,java.util.Vector" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%!
    DepartmentObj obj;

    public boolean acceptData(HttpServletRequest req) {
        obj = new DepartmentObj(req.getParameter("DeptID"), req.getParameter("DeptCode"), ChStr.chStr(req.getParameter("DeptName")), ChStr.chStr(req.getParameter("DeptDesc")), req.getParameter("OrderNO"), req.getParameter("DeptLevel"));
        return true;
    }

    public boolean service(String Type, DBOperation db) {
        //如果是增加操作，则生成唯一标识
        if (Type.equals("insert")) {
            Vector<Vector<String>> v = db.executeQueryVt("select nvl(max(dept_id),0)+1 from odccbim.department");
            if (v == null || v.size() == 0) {
                return false;//如果生成主键值出错
            } else {
                obj.setDeptID(v.elementAt(0).elementAt(0).toString());//设置对象的主键
            }
        }
        return obj.saveObj(Type, db);
    }
%>
<HTML>
<HEAD><TITLE>部门信息维护</TITLE>
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
    selectedIds = request.getParameter("selectedIds");
    type = request.getParameter("type");

    if (type == null) {
        throw new Exception("系统没有取到操作的参数！");
    }

    DBOperation db = new DBOperation(false);
    if (db.dbOpen()) {
        try {
            if (type.equals("deleteChoosed")) {
                int re = 0;
                String sqlstr = "";
                sqlstr = "delete from odccbim.department where dept_id in(" + selectedIds + ")";
                re = db.executeUpdate(sqlstr);
                db.executeCommit();//提交事务
                if (re < 1) {
%>
<script>
    alert("对不起！系统在删除数据时出错，请重试或与系统管理员联系！");
    window.history.back();
</script>
<%
} else {
%>
<script>
    alert("您好，删除部门成功！");
    self.location = "DepartmentList.jsp"
</script>
<%
    }
    db.dbClose();
} else {

    if (this.acceptData(request)) {
        if (this.service(type, db))//执行对数据库的操作
        {
            db.executeCommit();//提交事务
            db.dbClose();
            if (type.equals("insert")) {%>
<script>
    alert("您好，向数据库中增加数据成功！");
    self.location = "DepartmentList.jsp"
</script>
<%
    }

    if (type.equals("update")) {
%>
<script>
    alert("您好，修改部门信息成功！");
    self.location = "DepartmentList.jsp"
</script>
<%
    }

    if (type.equals("delete")) {
%>
<script>
    alert("您好，删除部门成功！");
    self.location = "DepartmentList.jsp"
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