<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,java.util.Vector" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<HTML>
<HEAD><TITLE>地区信息维护</TITLE>
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
                String sqlstr = "delete from echarts.dim_region where region_id in(" + selectedIds + ")";
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
    self.location = "RegionList.jsp";
</script>
<%
    }
    db.dbClose();
} else if (type.equals("insert")) {
    Vector<Vector<String>> v = db.executeQueryVt("select nvl(max(region_id),0)+1 from echarts.dim_region");
    if (v == null || v.size() == 0) {
%>
<script>
    alert("对不起！系统在删除数据时出错，请重试或与系统管理员联系！");
    window.history.back();
</script>
<%
} else {
    String region_id = v.elementAt(0).elementAt(0).toString();
    String region_code = request.getParameter("region_code");
    String region_name = new String(request.getParameter("region_name").getBytes("ISO8859-1"), "UTF-8");
    String brief_name = new String(request.getParameter("brief_name").getBytes("ISO8859-1"), "UTF-8");
    String region_level = request.getParameter("region_level");
    String status = request.getParameter("status");
    String order_no = request.getParameter("order_no");
    String uplevel_id = request.getParameter("uplevel_id");
    int re = 0;
    String sqlstr = "insert into echarts.dim_region(region_id,region_code,region_name,brief_name,region_level,status,order_no,uplevel_id)values(" + region_id + ",'" + region_code + "','" + region_name + "','" + brief_name + "'," + region_level + "," + status + "," + order_no + "," + uplevel_id + ")";
    //System.out.println(sqlstr);
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
    self.location = "RegionList.jsp";
</script>
<%
        }
        db.dbClose();
    }
} else if (type.equals("update")) {
    String region_id = request.getParameter("region_id");
    String region_code = request.getParameter("region_code");
    String region_name = new String(request.getParameter("region_name").getBytes("ISO8859-1"), "UTF-8");
    String brief_name = new String(request.getParameter("brief_name").getBytes("ISO8859-1"), "UTF-8");
    String region_level = request.getParameter("region_level");
    String status = request.getParameter("status");
    String order_no = request.getParameter("order_no");
    String uplevel_id = request.getParameter("uplevel_id");
    int re = 0;
    String sqlstr = "update echarts.dim_region t"
            + " SET t.region_code = '" + region_code + "',"
            + "t.region_name = '" + region_name + "',"
            + "t.brief_name = '" + brief_name + "',"
            + "t.region_level = " + region_level + ","
            + "t.status = " + status + ","
            + "t.order_no = " + order_no + ","
            + "t.uplevel_id = " + uplevel_id + " "
            + "WHERE t.region_id = " + region_id;
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
    self.location = "RegionList.jsp";
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