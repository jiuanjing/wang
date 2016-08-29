<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.text.DecimalFormat,java.util.ArrayList,java.util.HashMap,java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            //获取日期
            String date = request.getParameter("date");
            String CompanyID = request.getParameter("CompanyID");
            int year = Integer.valueOf(date.substring(0, 4));
            int month = Integer.valueOf(date.substring(5, 7));
            String column = "";

            String sqlstr1 = "select nvl(round(sum(sum" + month + "),2),0) from echarts.dm_op_mr_kpi_actual t where t.company_id = " + CompanyID + " and t.kpi_code_num=2002 and t.date_id = " + year;//应收实际值
            String sqlstr2 = "select nvl(round(sum(sum" + month + "),2),0) from echarts.dm_op_mr_kpi_budget t where t.company_id = " + CompanyID + " and t.kpi_code_num=2002 and t.date_id = " + year;//应收计划

            List<String> sqlList = new ArrayList<String>();
            sqlList.add(sqlstr1);
            sqlList.add(sqlstr2);

            Double d1 = 0D;
            Double d2 = 0D;
            for (int i = 0; i < sqlList.size(); i++) {
                //System.out.println(sqlList.get(i));
                ResultSet rs = null;
                rs = db.executeQuery(sqlList.get(i));//通过数据库访问程序返回一个可滚动的记录集
                if (rs == null) {
                    throw new Exception("对不起！系统在查询数据库时出错");
                }
                rs.last();//定位到最后一条记录
                int intRowCount = rs.getRow();//取总的记录数
                if (intRowCount > 0) {
                    rs.absolute(1);
                    while (!rs.isAfterLast()) {
                        if (i == 0) {
                            d1 = rs.getDouble(1);
                        } else if (i == 1) {
                            d2 = rs.getDouble(1);
                        }
                        rs.next();
                    }
                }
            }
            DecimalFormat df = new DecimalFormat("0.00");
            Double cxxl = 0D;
            if (d2 != 0D) {
                cxxl = Double.valueOf(df.format(d1 / d2 * 100));
            }
            Gson gson = new Gson();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            Map<String, Object> map1 = new HashMap<String, Object>();
            map1.put("value", df.format(cxxl));
            map1.put("name", "计划完成率");//预算值
            list.add(map1);

            String str_return = gson.toJson(list);
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