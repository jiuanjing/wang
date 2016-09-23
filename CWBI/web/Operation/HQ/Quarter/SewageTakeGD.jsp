<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap,java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String sqlstr = "";
            //获取日期
            String date1 = request.getParameter("date1").trim(); //去年
            String date2 = request.getParameter("date2").trim(); //今年
            int month = 0;
            if (date1 != null && !(date1.equals(""))) {
                month = Integer.parseInt(date1.substring(5));
                date1 = date1.substring(0, 4);
                date2 = date2.substring(0, 4);
            }
            String ddd = "sum" + month;
            sqlstr = "select coalesce(v101.dept_name,v102.dept_name,v103.dept_name) dept_name, "
                    + "coalesce(v103.brief_name,v102.brief_name,v103.brief_name) brief_name, "
                    + "round(coalesce(v103.design,0),2) design, "
                    + "round(coalesce(v102.supply_ly,0),2) supply_ly, "
                    + "round(coalesce(v101.supply_cy,0),2) supply_cy, "
                    + "round((coalesce(v101.supply_cy,0)-coalesce(v102.supply_ly,0)),2) dif "
                    + "from "
                    + "( "
                    + "select a.dept_id,a.dept_name,b.company_id,b.brief_name, "
                    + "(" + ddd + ") supply_cy "
                    + "from echarts.dim_dept_op a, echarts.dim_op_company b, echarts.dm_op_mr_kpi_actual c "
                    + "where a.dept_id=b.dept_id and b.company_id=c.company_id "
                    + "and c.kpi_code_num=103 "
                    + "and c.date_id=" + date2 + " and b.flag_sewage = 1 order by a.order_no"
                    + ") v101 "
                    + "left outer join "
                    + "( "
                    + "select a.dept_id,a.dept_name,b.company_id,b.brief_name, "
                    + "(" + ddd + ") supply_ly "
                    + "from echarts.dim_dept_op a, echarts.dim_op_company b, echarts.dm_op_mr_kpi_actual c "
                    + "where a.dept_id=b.dept_id and b.company_id=c.company_id "
                    + "and c.kpi_code_num=103 "
                    + "and c.date_id=" + date1 + " and b.flag_sewage = 1 order by a.order_no"
                    + ") v102 "
                    + "on (v101.dept_id=v102.dept_id and v101.company_id=v102.company_id) "
                    + "left outer join "
                    + "( "
                    + "select a.dept_id,a.dept_name,b.company_id,b.brief_name, "
                    + "round((" + ddd + ")/" + month + ",2) design "
                    + "from echarts.dim_dept_op a, echarts.dim_op_company b, echarts.dm_op_mr_kpi_actual c "
                    + "where a.dept_id=b.dept_id and b.company_id=c.company_id "
                    + "and c.kpi_code_num=2041 "
                    + "and c.date_id=2016 and b.flag_sewage = 1 order by a.order_no"
                    + ") v103 "
                    + "on (v101.dept_id=v103.dept_id and v101.company_id=v103.company_id)";
            //System.out.println(sqlstr);
            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集

            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }

            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数

            Gson gson = new Gson();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            //拼返回串
            String str_return = "";

            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("dept_name", rs.getString(1));
                    map.put("brief_name", rs.getString(2));
                    map.put("design", rs.getString(3));
                    map.put("supply_ly", rs.getString(4));
                    map.put("supply_cy", rs.getString(5));
                    map.put("dif", rs.getString(6));
                    list.add(map);
                    rs.next();
                }
            }
            str_return = gson.toJson(list);
            //System.out.print(str_return);
            out.print(str_return);//ajax返回的结果

        } catch (Exception e) {
            throw e;
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
%>
