<%@ page import="com.bws.dbOperation.DBOperation" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Author: wangdegang
  Date: 2016/9/2
  Time: 16:26
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String company = new String(request.getParameter("company").getBytes("ISO-8859-1"), "utf-8");
    DBOperation dbOperation = new DBOperation(true);
    Map<String, Object> gsonMap = new HashMap<String, Object>();
    List<String> dataList1 = new ArrayList<String>();
    List<String> dataList2 = new ArrayList<String>();
    if (dbOperation.dbOpen()) {
        String sql = "select t.date_id ,sum(t.score),sum(t.rank)" +
                "  from dm_op_yr_evaluate t,dim_op_company t1" +
                " where t1.brief_name='" + company + "' and t.company_id = t1.company_id" +
                "   and t.kpi_id in (401, 402, 403, 404, 405, 406,407,408,409,410,411)" +
                " group by t.date_id";
        ResultSet resultSet = dbOperation.executeQuery(sql);
        if (resultSet != null) {
            try {
                while (resultSet.next()) {
                    dataList1.add(resultSet.getString(2));
                    dataList2.add(resultSet.getString(3));
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        dbOperation.dbClose();
        gsonMap.put("score", dataList1);
        gsonMap.put("rank", dataList2);

        Gson gson = new Gson();
        String s = gson.toJson(gsonMap);
        out.write(s);
    } else {
        out.write("<script>alert('对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！');</script>");
    }
%>
