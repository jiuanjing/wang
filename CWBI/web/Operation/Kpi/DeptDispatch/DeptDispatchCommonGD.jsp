<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Map" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            //查询用户所在大区
            //用户dept_id对应DEPARTMENT表，在查出dept_id_op则是对应数据dim_op_dept表id，根据此ID过滤大区数据
            int dept_id = userInfo.getDeptID();
            String sql4dept = "select a.dept_id_op from odccbim.department a where a.dept_id = " + dept_id;
            ResultSet rs = null;
            rs = db.executeQuery(sql4dept);
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            //当前用户对应的部门ID
            int deptId = 0;
            rs.last();//定位到最后一条记录
            int intRowCount0 = rs.getRow();//取总的记录数
            if (intRowCount0 > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    deptId = rs.getInt(1);
                    rs.next();
                }
            }
            ////////////////////////////////////////////////////////////////////////////////////////////////////
            String date1 = request.getParameter("date1").trim(); //去年
            String date2 = request.getParameter("date2").trim(); //今年
            String kpiCodeNum = request.getParameter("kpiCodeNum").trim();//kpi_id
            int month = 0;
            if (date1 != null && !(date1.equals(""))) {
                month = Integer.parseInt(date1.substring(5));
                date1 = date1.substring(0, 4);
                date2 = date2.substring(0, 4);
            }
            String where = "";
            if (deptId > 0) {
                where += " and a.dept_id =" + deptId;
            }
            String column = "sum" + month;
            String sqlstr = "select v100.dept_id, v100.dept_name, "
                    + "round(nvl(v101.all_cy, 0), 2), round(nvl(v103.all_budget, 0), 2),round((nvl(v101.all_cy, 0) - nvl(v103.all_budget, 0)), 2), "
                    + "case when nvl(v103.all_budget, 0) <> 0 then round((nvl(v101.all_cy, 0) - nvl(v103.all_budget, 0)) / nvl(v103.all_budget, 0) * 100, 2) else 0 end, "
                    + "round(nvl(v102.all_ly, 0), 2), round((nvl(v101.all_cy, 0) - nvl(v102.all_ly, 0)), 2), "
                    + "case when nvl(v102.all_ly, 0) <> 0 then round((nvl(v101.all_cy, 0) - nvl(v102.all_ly, 0)) / nvl(v102.all_ly, 0) * 100, 2) else 0 end "
                    + "from (select a.dept_id, a.dept_name from echarts.dim_dept_op a where 1=1 " + where + ") v100 "
                    + "left outer join ( "
                    + "select a.sum_id,a." + column + " all_cy from echarts.dm_op_mr_kpi_actual_sum a where a.kpi_code_num = " + kpiCodeNum + " and a.date_id = " + date2 + " order by a.sum_id "
                    + ") v101 "
                    + "on (v100.dept_id = v101.sum_id) "
                    + "left outer join ( "
                    + "select a.sum_id,a." + column + " all_ly from echarts.dm_op_mr_kpi_actual_sum a where a.kpi_code_num = " + kpiCodeNum + " and a.date_id = " + date1 + " order by a.sum_id "
                    + ") v102 "
                    + "on (v100.dept_id = v102.sum_id) "
                    + "left outer join ( "
                    + "select a.sum_id,a." + column + " all_budget from echarts.dm_op_mr_kpi_budget_sum a where a.kpi_code_num = " + kpiCodeNum + " and a.date_id = " + date2 + " order by a.sum_id "
                    + ") v103 "
                    + "on (v100.dept_id = v103.sum_id) order by v100.dept_id";
            //System.out.println(sqlstr);
            rs = null;
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
                    map.put("dept_id", rs.getString(1));
                    map.put("dept_name", rs.getString(2));
                    map.put("all_cy", rs.getString(3));
                    map.put("all_bt", rs.getDouble(4));
                    map.put("all_bt_dif", rs.getDouble(5));
                    map.put("all_bt_rate", rs.getDouble(6));
                    map.put("all_ly", rs.getDouble(7));
                    map.put("all_ly_dif", rs.getDouble(8));
                    map.put("all_ly_rate", rs.getDouble(9));
                    list.add(map);
                    rs.next();
                }
            }
            str_return = gson.toJson(list);
            //System.out.println(str_return);
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
