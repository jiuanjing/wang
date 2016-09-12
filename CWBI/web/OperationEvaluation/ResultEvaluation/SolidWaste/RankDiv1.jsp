<%@ page import="com.bws.dbOperation.DBOperation" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by wangdegang on 2016/9/4 13:19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DBOperation dbOperation = new DBOperation(true);
    String date = request.getParameter("date");
    date = date.length() == 0 ? "2016" : date;
    String kpiName = new String(request.getParameter("kpi").getBytes("ISO-8859-1"), "utf-8");
    if (dbOperation.dbOpen()) {

        Map<String, Object> gsonmap = new HashMap<String, Object>();
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

        String sql = " select t1.brief_name, t.actual_value, t.score " +
                "  from dm_op_yr_evaluate t, dim_op_company t1, dim_op_kpi t2 " +
                " where t.date_id = " + date +
                "   and t2.kpi_name = '" + kpiName + "' " +
                "   and t.company_id = t1.company_id and t1.flag_solid_waste = 1 " +
                "   and t.kpi_id = t2.kpi_id " +
                " order by t.actual_value desc";

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
