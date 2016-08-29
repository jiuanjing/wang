<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,java.sql.ResultSet" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);
    String str_return = "";
    String bu_id = "";
    if (request.getParameter("bu_id") != null && !(request.getParameter("bu_id").equals(""))) {
        bu_id = request.getParameter("bu_id");
    }
    //打开数据库链接
    if (db.dbOpen()) {
        try {
            str_return = "<select size=1 style=\"width:250px;\" id=\"bu_id\" name=\"bu_id\">";
            //下拉框值部分
            String sqlstr = "select distinct bu_id,bu_name from echarts.dim_bu where 1=1 order by order_no";
            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    if (rs.getString(1).equals(bu_id)) {
                        str_return += "<option value=\"" + rs.getString(1) + "\" selected>" + rs.getString(2) + "</option>";
                    } else {
                        str_return += "<option value=\"" + rs.getString(1) + "\">" + rs.getString(2) + "</option>";
                    }

                    rs.next();
                }
            }
            str_return += "</select>";
            out.println(str_return);//ajax返回的结果
        } catch (Exception e) {
            throw e;
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
%>