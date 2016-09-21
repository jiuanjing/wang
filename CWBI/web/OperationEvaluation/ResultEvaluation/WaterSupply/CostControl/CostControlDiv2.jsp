<%@ page import="com.bws.dbOperation.DBOperation" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String date = new String(request.getParameter("date").getBytes("ISO-8859-1"), "gbk");
    date = date.equals("") ? "2015" : date;
    int dateID = Integer.parseInt(date);
    DBOperation dbOperation = new DBOperation(true);
    if (dbOperation.dbOpen()) {

        Map<String, Object> gsonmap = new HashMap<String, Object>();
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        //34,1402,1403,1404,1405,44,1038,1408,62,1410,31
        String sql = "select t1.brief_name," +
                "       sum(score) as score," +
                "       sum(decode(t.kpi_id, 34, t.actual_value, null)) as kpi34," +
                "       sum(decode(t.kpi_id, 1402, t.actual_value, null)) as kpi1402," +
                "       sum(decode(t.kpi_id, 1403, t.actual_value, null)) as kpi1403," +
                "       sum(decode(t.kpi_id, 1404, t.actual_value, null)) as kpi1404," +
                "       sum(decode(t.kpi_id, 1405, t.actual_value, null)) as kpi1405," +
                "       sum(decode(t.kpi_id, 44, t.actual_value, null)) as kpi44," +
                "       sum(decode(t.kpi_id, 1038, t.actual_value, null)) as kpi1038," +
                "       sum(decode(t.kpi_id, 1408, t.actual_value, null)) as kpi1408," +
                "       sum(decode(t.kpi_id, 62, t.actual_value, null)) as kpi62," +
                "       sum(decode(t.kpi_id, 1410, t.actual_value, null)) as kpi1410," +
                "       sum(decode(t.kpi_id, 31, t.actual_value, null)) as kpi31" +
                "  from dm_op_yr_evaluate t,dim_op_company t1" +
                " where t.date_id = " + dateID + " and t1.company_id = t.company_id and t1.flag_water = 1" +
                "   and t.kpi_id in (34, 1402, 1403, 1404, 1405, 44,1038,1408,62,1410,31)" +
                " group by t.company_id,t1.brief_name" +
                " order by score desc";

        ResultSet rs = dbOperation.executeQuery(sql);
        if (null != rs) {
            try {
                int i = 1;
                while (rs.next()) {
                    Map<String, Object> dataMap = new HashMap<String, Object>();
                    dataMap.put("m1", i + "");
                    i++;
                    dataMap.put("m2", rs.getString(1));
                    dataMap.put("m3", rs.getString(2));
                    dataMap.put("m4", rs.getString(3));
                    dataMap.put("m5", rs.getString(4));
                    dataMap.put("m6", rs.getString(5));
                    dataMap.put("m7", rs.getString(6));
                    dataMap.put("m8", rs.getString(7));
                    dataMap.put("m9", rs.getString(8));
                    dataMap.put("m10", rs.getString(9));
                    dataMap.put("m11", rs.getString(10));
                    dataMap.put("m12", rs.getString(11));
                    dataMap.put("m13", rs.getString(12));
                    dataMap.put("m14", rs.getString(13));
                    list.add(dataMap);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        gsonmap.put("total", list.size());
        gsonmap.put("rows", list);
        dbOperation.dbClose();

        Gson gson = new Gson();
        String s = gson.toJson(gsonmap);
        out.write(s);
    } else {
        out.write("<script>alert('对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！');</script>");
    }
%>
