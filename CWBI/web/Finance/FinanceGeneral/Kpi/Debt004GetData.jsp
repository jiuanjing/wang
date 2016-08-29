<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<String> sqlList = new ArrayList<String>();
            String str_return = "";
            String date = request.getParameter("date").trim();
            String where = "";
            String where1 = "";
            if (date != null && !(date.equals(""))) {
                int begin_date_int = Integer.valueOf((Integer.valueOf(date.substring(0, 4)) - 1) + date.substring(5, 7));
                where += " and date_id >" + begin_date_int;
                where1 += " and date_id >" + (begin_date_int - 100);
                int end_date_int = Integer.valueOf(date.substring(0, 4) + date.substring(5, 7));
                where += " and date_id <=" + end_date_int;
                where1 += " and date_id <=" + (end_date_int - 100);
            }
            //EBITDA
            String sql1 = "select date_id,EBITDA_RATIO from echarts.dm_debt_risk t where company_id=1" + where + " order by date_id";
            //EBITDA同期
            String sql2 = "select date_id,EBITDA_RATIO from echarts.dm_debt_risk t where company_id=1" + where1 + " order by date_id";

            //System.out.println(sql1);
            //System.out.println(sql1);

            sqlList.add(sql2);
            sqlList.add(sql1);
            ////////////////////////////////////////////1
            for (int i = 0; i < sqlList.size(); i++) {
                List<String> listData = new ArrayList<String>();
                List<String> dateList = new ArrayList<String>();
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
                        dateList.add(rs.getString(1));
                        listData.add(rs.getString(2));
                        rs.next();
                    }
                }

                mapAll.put("date", dateList);
                mapAll.put("data" + i, listData);
                rs.close();
            }

            str_return = gson.toJson(mapAll);
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