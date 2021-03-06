<%@page import="com.google.gson.Gson" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.lang.reflect.Array" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="com.bws.dbOperation.DBOperation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DBOperation db = new DBOperation(true);
    String company = new String(request.getParameter("company").getBytes("ISO-8859-1"), "utf-8");
    String kpi = new String(request.getParameter("kpi").getBytes("ISO-8859-1"), "utf-8");

    Map<String, Object> gsonmap = new HashMap<String, Object>();
    List<String> sqlList = new ArrayList<String>();

    if(db.dbOpen()){
        //查询实际值
        String sql1 = "select t.actual_value, t1.brief_name , t.date_id" +
                "  from echarts.dm_op_yr_evaluate t, dim_op_company t1 " +
                " where t.kpi_id = " +kpi+
                "   and t1.brief_name ='"+company +
                "'   and t1.company_id = t.company_id" +
                " order by t.date_id";
        //行业标杆值
        String sql2 = "select t.actual_value,t.company_id,t.date_id" +
                "  from echarts.dm_op_yr_evaluate t " +
                " where  t.kpi_id = '" + kpi + "'" +
                "   and t.company_id = -1 " +
                " order by t.date_id";
        //行业平均值
        String sql3 = "select t.actual_value,t.company_id,t.date_id" +
                "  from echarts.dm_op_yr_evaluate t " +
                " where  t.kpi_id = '" + kpi + "'" +
                "   and t.company_id = 0 " +
                " order by t.date_id";

        sqlList.add(sql1);
        sqlList.add(sql2);
        sqlList.add(sql3);

        for (int i = 0; i < sqlList.size();i++){
            ResultSet rs = db.executeQuery(sqlList.get(i));
            if(rs != null){
                try {
                    List<String> list = new ArrayList<String>();
                    while(rs.next()){
                        list.add(rs.getString(1));
                    }
                    gsonmap.put("data" + (i + 1), list);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        db.dbClose();
        Gson gson = new Gson();
        String s = gson.toJson(gsonmap);
        out.write(s);
    } else {
        out.write("<script>alert('对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！');</script>");
    }
%>