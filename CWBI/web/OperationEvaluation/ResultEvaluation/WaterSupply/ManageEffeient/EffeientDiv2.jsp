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
        String sql = "select t1.brief_name," +
                "       sum(comp_score) as comp_score," +
                "       sum(decode(t.kpi_id, 1601, t.actual_value, null)) as kpi1601," +
                "       sum(decode(t.kpi_id, 68, t.actual_value, null)) as kpi68," +
                "       sum(decode(t.kpi_id, 1603, t.actual_value, null)) as kpi1603," +
                "       sum(decode(t.kpi_id, 1604, t.actual_value, null)) as kpi1604," +
                "       sum(decode(t.kpi_id, 1605, t.actual_value, null)) as kpi1605" +
                "  from dm_op_yr_evaluate t,dim_op_company t1" +
                " where t.date_id = "+dateID+" and t1.company_id = t.company_id and t1.flag_water = 1" +
                "   and t.kpi_id in (1601,68,1603,1604,1605)" +
                " group by t.company_id,t1.brief_name" +
                " order by comp_score desc";

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
