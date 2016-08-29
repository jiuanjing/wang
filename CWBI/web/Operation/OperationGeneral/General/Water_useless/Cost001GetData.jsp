<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     *编写时间：2015-10-21
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
            sqlstr = "select c.brief_name,round(sum(a.TOTAL_ASSET)/10000,2) from echarts.dm_debt_risk a ,echarts.dim_company_fn b,echarts.dim_dept c "
                    + "where a.company_id = b.company_id and b.dept_id = c.dept_id and a.company_id > 2";

            String where = "";
            if (date != null && !(date.equals(""))) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and a.date_id =" + date;
            } else {
                //默认日期为上个月
                String date_str = DateTool.getPreMonDate02();
                where += " and date_id =" + date_str;
            }

            sqlstr = sqlstr + where + " and b.status=1 and b.company_level=2 and c.status=1 group by c.brief_name order by sum(a.TOTAL_ASSET)";
            //System.out.print(sqlstr);
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
                    map.put("value", Float.parseFloat(rs.getString(2)));
                    map.put("name", rs.getString(1));
                    //list.add(map);
                    rs.next();
                }
            }
            Map<String, Object> map1 = new HashMap<String, Object>();
            map1.put("value", 402);
            map1.put("name", "电费");
            list.add(map1);

            Map<String, Object> map2 = new HashMap<String, Object>();
            map2.put("value", 323);
            map2.put("name", "药剂费");
            list.add(map2);

            Map<String, Object> map5 = new HashMap<String, Object>();
            map5.put("value", 109);
            map5.put("name", "人工费");
            list.add(map5);

            Map<String, Object> map6 = new HashMap<String, Object>();
            map6.put("value", 123);
            map6.put("name", "修理费");
            list.add(map6);

            Map<String, Object> map7 = new HashMap<String, Object>();
            map7.put("value", 123);
            map7.put("name", "管理费");
            list.add(map7);


            Map<String, Object> map8 = new HashMap<String, Object>();
            map8.put("value", 46.2);
            map8.put("name", "销售费");
            list.add(map8);
            Map<String, Object> map9 = new HashMap<String, Object>();
            map9.put("value", 46.3);
            map9.put("name", "财务费");
            list.add(map9);
            Map<String, Object> map11 = new HashMap<String, Object>();
            map11.put("value", 34.3);
            map11.put("name", "折旧摊销费");
            list.add(map11);

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