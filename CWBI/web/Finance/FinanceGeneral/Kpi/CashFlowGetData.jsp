<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.text.DecimalFormat,java.util.ArrayList,java.util.List" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            Gson gson = new Gson();
            List<String> listData = new ArrayList<String>();
            List<String> sqlList = new ArrayList<String>();
            String str_return = "";
            String date = request.getParameter("date").trim();

            String where = "";
            if (date != null && !(date.equals(""))) {
                int date_int = Integer.valueOf(date.substring(0, 4) + date.substring(5, 7));
                where += " and date_id =" + date_int;
            }
            //经营现金净流量
            String sql1 = "select round(OPERATING_CASH_FLOW/10000,2) from echarts.dm_profitability t where company_id=1" + where;
            //投资现金净流量
            String sql2 = "select round(CASH_FLOW_INVEST/10000,2) from echarts.dm_profitability t where company_id=1" + where;
            //筹资现金净流量
            String sql3 = "select round(CASH_FLOW_RAISE/10000,2) from echarts.dm_profitability t where company_id=1" + where;
            //现金净流量
            String sql4 = "select round(CASH_FLOW/10000,2) from echarts.dm_profitability t where company_id=1" + where;
            //营业收入
            String sql5 = "select round(OPERATING_REVENUE/10000,2) from echarts.dm_profitability t where company_id=1" + where;
            //流动负债
            String sql6 = "select round(CURRENT_DEBT/10000,2) from echarts.dm_debt_risk t where company_id=1" + where;
            sqlList.add(sql1);
            sqlList.add(sql2);
            sqlList.add(sql3);
            sqlList.add(sql4);
            sqlList.add(sql5);
            sqlList.add(sql6);
            ////////////////////////////////////////////1
            for (int i = 0; i < sqlList.size(); i++) {
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
                        DecimalFormat df = new DecimalFormat("#,###");
                        Double d = Double.parseDouble(rs.getString(1));
                        String m = df.format(d);
                        listData.add(m);
                        rs.next();
                    }
                } else {
                    listData.add("0");
                }
                rs.close();
            }

            str_return = gson.toJson(listData);
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