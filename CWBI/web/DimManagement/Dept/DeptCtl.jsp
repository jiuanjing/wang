<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,java.util.Vector" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
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
    type = request.getParameter("type");
    if (type == null) {
        throw new Exception("系统没有取到操作的参数！");
    }

    DBOperation db = new DBOperation(false);
    if (db.dbOpen()) {
        try {
            if (type.equals("delete")) {
                int re = 0;
                String selectedIds = request.getParameter("selectedIds");
                String sqlstr = "delete from echarts.dim_dept where dept_id in(" + selectedIds + ")";
                //System.out.println(sqlstr);
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
    alert("您好，删除板块成功！");
    self.location = "DeptList.jsp";
</script>
<%
    }
    db.dbClose();
} else if (type.equals("insert")) {
    Vector<Vector<String>> v = db.executeQueryVt("select nvl(max(dept_id),0)+1 from echarts.dim_dept");
    if (v == null || v.size() == 0) {
%>
<script>
    alert("对不起！系统在查询数据时出错，请重试或与系统管理员联系！");
    window.history.back();
</script>
<%
} else {
    String dept_id = v.elementAt(0).elementAt(0).toString();
    String dept_code = request.getParameter("dept_code");
    String dept_name = new String(request.getParameter("dept_name").getBytes("ISO8859-1"), "UTF-8");
    String brief_name = new String(request.getParameter("brief_name").getBytes("ISO8859-1"), "UTF-8");
    String status = request.getParameter("status");
    String order_no = request.getParameter("order_no");
    int re = 0;
    String sqlstr = "insert into echarts.dim_dept(dept_id,dept_code,dept_name,brief_name,status,order_no)values(" + dept_id + ",'" + dept_code + "','" + dept_name + "','" + brief_name + "'," + status + "," + order_no + ")";
    re = db.executeUpdate(sqlstr);

    db.executeCommit();//提交事务
    if (re < 1) {
%>
<script>
    alert("对不起！系统在添加数据时出错，请重试或与系统管理员联系！");
    window.history.back();
</script>
<%
} else {
%>
<script>
    alert("您好，添加板块成功！");
    self.location = "DeptList.jsp";
</script>
<%
        }
        db.dbClose();
    }
} else if (type.equals("update")) {
    String dept_id = request.getParameter("dept_id");
    String dept_code = request.getParameter("dept_code");
    String dept_name = new String(request.getParameter("dept_name").getBytes("ISO8859-1"), "UTF-8");
    String brief_name = new String(request.getParameter("brief_name").getBytes("ISO8859-1"), "UTF-8");
    String status = request.getParameter("status");
    String order_no = request.getParameter("order_no");
    int re = 0;
    String sqlstr = "update echarts.dim_dept t"
            + " SET t.dept_code = '" + dept_code + "',"
            + "t.dept_name = '" + dept_name + "',"
            + "t.brief_name = '" + brief_name + "',"
            + "t.status = " + status + ","
            + "t.order_no = " + order_no + " "
            + "WHERE t.dept_id = " + dept_id;
    re = db.executeUpdate(sqlstr);
    db.executeCommit();//提交事务
    if (re < 1) {
%>
<script>
    alert("对不起！系统在更新数据时出错，请重试或与系统管理员联系！");
    window.history.back();
</script>
<%
} else {
%>
<script>
    alert("您好，更新板块成功！");
    self.location = "DeptList.jsp";
</script>
<%
                }
                db.dbClose();
            }
        } catch (Exception e) {
            throw e;
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
%>
</BODY>
</HTML>