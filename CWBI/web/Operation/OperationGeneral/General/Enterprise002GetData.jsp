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
            String t_sqlstr = "";
            //获取日期
            String date = request.getParameter("date").trim();
            int t_date = 0;
            sqlstr = "select round(OPERATING_REVENUE/10000,0) from echarts.dm_profitability where company_id=1";
            t_sqlstr = "select round(OPERATING_REVENUE/10000,0) from echarts.dm_profitability where company_id=1";

            String where = "";
            String t_where = "";
            if (date != null && !(date.equals(""))) {
                date = date.substring(0, 4) + date.substring(5, 7);
                t_date = Integer.parseInt(date) - 100;//去年同期
                where += " and date_id =" + date;
                t_where += " and date_id =" + t_date;
            } else {
                //默认日期为上个月
                String date_str = DateTool.getPreMonDate02();
                where += " and date_id =" + date_str;
                t_where += " and date_id =" + date_str;
            }
            sqlstr = sqlstr + where;
            t_sqlstr = t_sqlstr + t_where;

            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> t_list = new ArrayList<Map<String, Object>>();

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
                    //map.put("value", Integer.parseInt(rs.getString(1)));
                    map.put("value", 34360);
                    map.put("name", "本期净利润");
                    list.add(map);
                    rs.next();
                }
            } else {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("value", 34360);
                //map.put("value", 0);
                map.put("name", "本期净利润");
                list.add(map);
            }

            //查询去年的
            rs = null;
            rs = db.executeQuery(t_sqlstr);//通过数据库访问程序返回一个可滚动的记录集
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            int t_intRowCount = rs.getRow();//取总的记录数

            if (t_intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    //map.put("value", Integer.parseInt(rs.getString(1)));
                    map.put("value", 28260);
                    map.put("name", "同期净利润");
                    t_list.add(map);
                    rs.next();
                }
            } else if (t_intRowCount <= 0) {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("value", 28260);
                //map.put("value", 0);
                map.put("name", "同期净利润");
                t_list.add(map);
            }

            mapAll.put("cy", list);
            mapAll.put("ly", t_list);
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