<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Map" %>
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
            int month = Integer.parseInt(date.substring(5));
            String sqlstr1 = "select nvl(round(sum" + month + ",2),0) from echarts.dm_op_mr_kpi_actual t where t.company_id =" + CompanyID + " and t.kpi_code_num=1065 and t.date_id = " + year;
            String sqlstr2 = "select nvl(round(sum" + month + ",2),0) from echarts.dm_op_mr_kpi_budget t where t.company_id = " + CompanyID + " and t.kpi_code_num=1065 and t.date_id = " + year;

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
            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> a_list = new ArrayList<Map<String, Object>>();
            Map<String, Object> map1 = new HashMap<String, Object>();
            map1.put("value", d1);
            map1.put("name", "产能利用率");//实际值
            list.add(map1);
            Map<String, Object> map2 = new HashMap<String, Object>();
            map2.put("value", d2);
            map2.put("name", "产能利用率");//预算值
            a_list.add(map2);

            mapAll.put("actual", list);
            mapAll.put("budget", a_list);
            String str_return = gson.toJson(mapAll);
            //System.out.print(str_return);//ajax返回的结果
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