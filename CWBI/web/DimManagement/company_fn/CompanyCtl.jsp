<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,java.util.Vector" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<HTML>
<HEAD><TITLE>公司信息维护</TITLE>
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
                String sqlstr = "delete from echarts.dim_company_fn where company_id in(" + selectedIds + ")";
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
    self.location = "CompanyList.jsp";
</script>
<%
    }
    db.dbClose();
} else if (type.equals("insert")) {
    Vector<Vector<String>> v = db.executeQueryVt("select nvl(max(company_id),0)+1 from echarts.dim_company_fn");
    if (v == null || v.size() == 0) {
%>
<script>
    alert("对不起！系统在删除数据时出错，请重试或与系统管理员联系！");
    window.history.back();
</script>
<%
} else {
    String company_id = v.elementAt(0).elementAt(0).toString();
    String company_code = request.getParameter("company_code");
    String company_name = new String(request.getParameter("company_name").getBytes("ISO8859-1"), "UTF-8");
    String brief_name = new String(request.getParameter("brief_name").getBytes("ISO8859-1"), "UTF-8");
    String company_level = request.getParameter("company_level");
    String status = request.getParameter("status");
    String order_no = request.getParameter("order_no");
    String uplevel_id = request.getParameter("uplevel_id");

    String bu_id = request.getParameter("bu_id");
    String dept_id = request.getParameter("dept_id");
    String region_id = request.getParameter("region_id");
    String nc_code = request.getParameter("nc_code");
    String leaf_flag = request.getParameter("leaf_flag");
    String cw_stock_percent = request.getParameter("cw_stock_percent");
    int re = 0;
    String sqlstr = "insert into echarts.dim_company_fn(company_id,company_code,company_name,brief_name,company_level,status,order_no,uplevel_id,bu_id,dept_id,region_id,nc_code,leaf_flag,cw_stock_percent)values(" + company_id + ",'" + company_code + "','" + company_name + "','" + brief_name + "'," + company_level + "," + status + "," + order_no + "," + uplevel_id + "," + bu_id + "," + dept_id + "," + region_id + "," + nc_code + "," + leaf_flag + "," + cw_stock_percent + ")";
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
    self.location = "CompanyList.jsp";
</script>
<%
        }
        db.dbClose();
    }
} else if (type.equals("update")) {
    String company_id = request.getParameter("company_id");
    String company_code = request.getParameter("company_code");
    String company_name = new String(request.getParameter("company_name").getBytes("ISO8859-1"), "UTF-8");
    String brief_name = new String(request.getParameter("brief_name").getBytes("ISO8859-1"), "UTF-8");
    String company_level = request.getParameter("company_level");
    String status = request.getParameter("status");
    String order_no = request.getParameter("order_no");
    String uplevel_id = request.getParameter("uplevel_id");

    String bu_id = request.getParameter("bu_id");
    String dept_id = request.getParameter("dept_id");
    String region_id = request.getParameter("region_id");
    String nc_code = request.getParameter("nc_code");
    String leaf_flag = request.getParameter("leaf_flag");
    String cw_stock_percent = request.getParameter("cw_stock_percent");
    int re = 0;
    String sqlstr = "update echarts.dim_company_fn t"
            + " SET t.company_code = '" + company_code + "',"
            + "t.company_name = '" + company_name + "',"
            + "t.brief_name = '" + brief_name + "',"
            + "t.company_level = " + company_level + ","
            + "t.status = " + status + ","
            + "t.order_no = " + order_no + ","
            + "t.uplevel_id = " + uplevel_id + ","
            + "t.bu_id = " + bu_id + ","
            + "t.dept_id = " + dept_id + ","
            + "t.region_id = " + region_id + ","
            + "t.nc_code = '" + nc_code + "',"
            + "t.leaf_flag = " + leaf_flag + ","
            + "t.cw_stock_percent = " + cw_stock_percent + " "
            + "WHERE t.company_id = " + company_id;
    //System.out.println(sqlstr);
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
    self.location = "CompanyList.jsp";
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