<%@ page import="com.bws.dbOperation.DBOperation" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by wangdegang on 2016/9/3 15:58
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //获取前台传递的2个参数
    String company = new String(request.getParameter("company").getBytes("ISO-8859-1"), "utf-8");
    String kpi = new String(request.getParameter("kpi").getBytes("ISO-8859-1"), "utf-8");

    DBOperation dbOperation = new DBOperation(true);
    Map<String, Object> gsonMap = new HashMap<String, Object>();
    List<String> sqlList = new ArrayList<String>();
    if (dbOperation.dbOpen()) {
        //查询实际值
        String sql1 = "select t.comp_score,t.company_id,t.date_id" +
                "  from dm_op_yr_evaluate t, dim_op_kpi t1, dim_op_company t2" +
                " where t1.kpi_id = t.kpi_id" +
                "   and t.company_id = t2.company_id" +
                "  and t1.kpi_type = 1 and t1.kpi_name = '" + kpi + "'" +
                "   and t2.brief_name ='" + company + "'" +
                "order by t.date_id";
        String sql2 = "select t.comp_score,t.company_id,t.date_id" +
                "  from dm_op_yr_evaluate t, dim_op_kpi t1" +
                " where t1.kpi_id = t.kpi_id" +
                "  and t1.kpi_type = 1 and t1.kpi_name = '" + kpi + "'" +
                "   and t.company_id = -1 " +
                "order by t.date_id";
        String sql3 = "select t.comp_score,t.company_id,t.date_id" +
                "  from dm_op_yr_evaluate t, dim_op_kpi t1" +
                " where t1.kpi_id = t.kpi_id" +
                "  and t1.kpi_type = 1 and t1.kpi_name = '" + kpi + "'" +
                "   and t.company_id = 0 " +
                "order by t.date_id";
        sqlList.add(sql1);
        sqlList.add(sql2);
        sqlList.add(sql3);
        for (int i = 0; i < sqlList.size(); i++) {
            ResultSet rs = dbOperation.executeQuery(sqlList.get(i));
            if (null != rs) {
                try {
                    List<String> list = new ArrayList<String>();
                    while (rs.next()) {
                        list.add(rs.getString(1));
                    }
                    gsonMap.put("data" + (i + 1), list);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        dbOperation.dbClose();
        Gson gson = new Gson();
        String s = gson.toJson(gsonMap);
        out.write(s);
    } else {
        out.write("<script>alert('对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！');</script>");
    }
%>