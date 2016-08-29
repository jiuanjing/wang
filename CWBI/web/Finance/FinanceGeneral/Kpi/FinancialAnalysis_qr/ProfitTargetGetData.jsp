<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.bws.util.DateTool,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String sqlstr = "";
            //获取日期
            String date = request.getParameter("date").trim();
            int t_date = 0;
            sqlstr = "select round(TOTAL_PROFIT/10000,2),round(TOTAL_PROFIT_BUDGET_SELF/10000,2),round(TOTAL_PROFIT_BUDGET_GROUP/10000,2)"
                    + " from echarts.DM_QR_CW where 1=1";
            String where = "";

            if (date != null && !(date.equals(""))) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and date_id =" + date;
            } else {
                //默认日期为上个月
                String date_str = DateTool.getPreMonDate02();
                where += " and date_id =" + date_str;
            }
            sqlstr = sqlstr + where;
            //System.out.println(sqlstr);
            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

            //查询今年的利润总额
            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数
            //拼返回串
            String str_return = "";
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("value", Double.parseDouble(rs.getString(1)));
                    map.put("name", "本期利润总额");
                    list.add(map);

                    Map<String, Object> map2 = new HashMap<String, Object>();
                    map2.put("value", Double.parseDouble(rs.getString(2)));
                    map2.put("name", "内部预算");
                    list.add(map2);

                    Map<String, Object> map3 = new HashMap<String, Object>();
                    map3.put("value", Double.parseDouble(rs.getString(3)));
                    map3.put("name", "集团预算");
                    list.add(map3);

                    if (Double.parseDouble(rs.getString(2)) != 0D) {
                        Map<String, Object> map4 = new HashMap<String, Object>();
                        Double d = Double.parseDouble(rs.getString(1)) / Double.parseDouble(rs.getString(2));
                        map4.put("value", d);
                        map4.put("name", "内部预算完成率");
                        list.add(map4);
                    } else {
                        Map<String, Object> map4 = new HashMap<String, Object>();
                        map4.put("value", "-");
                        map4.put("name", "内部预算完成率");
                        list.add(map4);
                    }
                    if (Double.parseDouble(rs.getString(3)) != 0D) {
                        Map<String, Object> map5 = new HashMap<String, Object>();
                        Double d = Double.parseDouble(rs.getString(1)) / Double.parseDouble(rs.getString(3));
                        map5.put("value", d);
                        map5.put("name", "集团预算完成率");
                        list.add(map5);
                    } else {
                        Map<String, Object> map5 = new HashMap<String, Object>();
                        map5.put("value", "-");
                        map5.put("name", "集团预算完成率");
                        list.add(map5);
                    }
                    rs.next();
                }
            } else {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("value", 0);
                map.put("name", "本期利润总额");
                list.add(map);

                Map<String, Object> map2 = new HashMap<String, Object>();
                map2.put("value", 0);
                map2.put("name", "内部预算");
                list.add(map2);

                Map<String, Object> map3 = new HashMap<String, Object>();
                map3.put("value", 0);
                map3.put("name", "集团预算");
                list.add(map3);

                Map<String, Object> map4 = new HashMap<String, Object>();
                map4.put("value", 0);
                map4.put("name", "内部预算完成率");
                list.add(map4);

                Map<String, Object> map5 = new HashMap<String, Object>();
                map5.put("value", 0);
                map5.put("name", "集团预算完成率");
                list.add(map5);
            }

            mapAll.put("cy", list);
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