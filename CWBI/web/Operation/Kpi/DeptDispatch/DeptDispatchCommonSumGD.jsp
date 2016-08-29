<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.List" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String date1 = request.getParameter("date1").trim(); //去年
            String date2 = request.getParameter("date2").trim(); //今年
            String kpiCodeNum = request.getParameter("kpiCodeNum").trim();//kpi_id
            int month = 0;
            if (date1 != null && !(date1.equals(""))) {
                month = Integer.parseInt(date1.substring(5));
                date1 = date1.substring(0, 4);
                date2 = date2.substring(0, 4);
            }
            String column = "sum" + month;
            String sqlstr = "select "
                    + "round(nvl(v101.all_cy, 0), 2), round(nvl(v103.all_budget, 0), 2),round((nvl(v101.all_cy, 0) - nvl(v103.all_budget, 0)), 2), "
                    + "case when nvl(v103.all_budget, 0) <> 0 then round((nvl(v101.all_cy, 0) - nvl(v103.all_budget, 0)) / nvl(v103.all_budget, 0) * 100, 2) else 0 end, "
                    + "round(nvl(v102.all_ly, 0), 2), round((nvl(v101.all_cy, 0) - nvl(v102.all_ly, 0)), 2), "
                    + "case when nvl(v102.all_ly, 0) <> 0 then round((nvl(v101.all_cy, 0) - nvl(v102.all_ly, 0)) / nvl(v102.all_ly, 0) * 100, 2) else 0 end "
                    + "from ( "
                    + "select a.sum_id,a." + column + " all_cy from echarts.dm_op_mr_kpi_actual_sum a where a.sum_id=0 and a.kpi_code_num = " + kpiCodeNum + " and a.date_id = " + date2
                    + ") v101 "
                    + "left outer join ( "
                    + "select a.sum_id,a." + column + " all_ly from echarts.dm_op_mr_kpi_actual_sum a where a.sum_id=0 and a.kpi_code_num = " + kpiCodeNum + " and a.date_id = " + date1
                    + ") v102 "
                    + "on (v101.sum_id = v102.sum_id) "
                    + "left outer join ( "
                    + "select a.sum_id,a." + column + " all_budget from echarts.dm_op_mr_kpi_budget_sum a where a.sum_id=0 and a.kpi_code_num = " + kpiCodeNum + " and a.date_id = " + date2
                    + ") v103 "
                    + "on (v101.sum_id = v103.sum_id)";
            //System.out.println(sqlstr);
            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集

            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }

            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数

            Gson gson = new Gson();
            List<Double> list = new ArrayList<Double>();
            //拼返回串
            String str_return = "";

            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    list.add(rs.getDouble(1));
                    list.add(rs.getDouble(2));
                    list.add(rs.getDouble(3));
                    list.add(rs.getDouble(4));
                    list.add(rs.getDouble(5));
                    list.add(rs.getDouble(6));
                    list.add(rs.getDouble(7));
                    rs.next();
                }
            } else {
                //如果数据库没值，构造数据
                for (int i = 0; i < 7; i++) {
                    list.add(0D);
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