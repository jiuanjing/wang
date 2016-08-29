<%
    /*********************************************************************************************************************
     *程序名称：doAjax_getData.jsp
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：万怀
     *编写时间：2015-10-12
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,java.sql.ResultSet" %>
<%
    //实例化数据库链接
    //
    DBOperation db = new DBOperation(true);
    String str_return = "";
    String DeptID = "";   //0表示无管辖部门，1表示投运一部，2表示投运二部，部门ID
    String RegionID = "";
    if (request.getParameter("DeptID") != null && !(request.getParameter("DeptID").equals(""))) {
        DeptID = request.getParameter("DeptID");
    } else {
        DeptID = "0";
    }
    if (request.getParameter("RegionID") != null && !(request.getParameter("RegionID").equals(""))) {
        RegionID = request.getParameter("RegionID");
    } else {
        RegionID = "110000";
    }
    //打开数据库链接
    if (db.dbOpen()) {
        try {

            //头部分
            str_return = "<select size=1 id=\"CompanyID\" name=\"CompanyID\" onchange=\"\">";
            str_return += "<option value=\"\">--请选择公司--";

            //下拉框值部分
            String sqlstr = "select distinct company_id,brief_name from echarts.dim_company_fn where status=1 ";
            sqlstr = sqlstr + " and dept_id=" + DeptID;
            sqlstr = sqlstr + " and region_id=" + RegionID;
            sqlstr = sqlstr + " order by order_no";

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
                    str_return += "<option value=\"" + rs.getString(1) + "\">" + rs.getString(2) + "</option>";
                    rs.next();
                }
            }
            rs.close();

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