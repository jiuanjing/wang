<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.sql.ResultSetMetaData,java.util.ArrayList,java.util.List" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String CompanyID = request.getParameter("CompanyID");
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
            String sqlstr0 = "select sum(t." + ddd + ")/" + month + " from echarts.dm_op_mr_kpi_actual t,echarts.dim_op_company c where c.company_id = t.company_id and c.flag_water = 1 and t.kpi_code_num = 1059 and t.date_id =" + date2;
            String sqlstr1 = "select sum(t." + ddd + ") from echarts.dm_op_mr_kpi_actual t,echarts.dim_op_company c where c.company_id = t.company_id and c.flag_water = 1 and t.kpi_code_num = 1025 and t.date_id =" + date1;
            String sqlstr2 = "select sum(t." + ddd + ") from echarts.dm_op_mr_kpi_actual t,echarts.dim_op_company c where c.company_id = t.company_id and c.flag_water = 1 and t.kpi_code_num = 1028 and t.date_id =" + date1;
            String sqlstr3 = "select sum(t." + ddd + ") from echarts.dm_op_mr_kpi_actual t,echarts.dim_op_company c where c.company_id = t.company_id and c.flag_water = 1 and t.kpi_code_num = 1025 and t.date_id =" + date2;
            String sqlstr4 = "select sum(t." + ddd + ") from echarts.dm_op_mr_kpi_actual t,echarts.dim_op_company c where c.company_id = t.company_id and c.flag_water = 1 and t.kpi_code_num = 1028 and t.date_id =" + date2;
            List<String> sqlList = new ArrayList<String>();
            sqlList.add(sqlstr0);
            sqlList.add(sqlstr1);
            sqlList.add(sqlstr2);
            sqlList.add(sqlstr3);
            sqlList.add(sqlstr4);
            //拼返回串
            String str_return = "";
            Gson gson = new Gson();
            List<Float> list_a = new ArrayList<Float>();
            List<Float> list_b = new ArrayList<Float>();
            ResultSet rs = null;
            for (int i = 0; i < sqlList.size(); i++) {
                String sql = sqlList.get(i);
                //System.out.println(sql);
                rs = null;
                rs = db.executeQuery(sql);//通过数据库访问程序返回一个可滚动的记录集
                if (rs == null) {
                    throw new Exception("对不起！系统在查询数据库时出错");
                }
                rs.last();//定位到最后一条记录
                int intRowCount = rs.getRow();//取总的记录数
                if (intRowCount > 0) {
                    rs.absolute(1);
                    ResultSetMetaData data = rs.getMetaData();
                    while (!rs.isAfterLast()) {
                        list_a.add(rs.getFloat(1));
                        rs.next();
                    }
                } else {
                    list_a.add(0F);
                }
            }
            Float num2015 = 0F;
            Float num2016 = 0F;
            if (list_a.get(1) != 0) {
                num2015 = ((list_a.get(1) - list_a.get(2)) / list_a.get(1)) * 100;
            }
            if (list_a.get(3) != 0) {
                num2016 = ((list_a.get(3) - list_a.get(4)) / list_a.get(3)) * 100;
            }
            list_b.add(list_a.get(0));
            list_b.add(num2015);
            list_b.add(num2016);
            list_b.add(num2016 - num2015);

            str_return = gson.toJson(list_b);
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