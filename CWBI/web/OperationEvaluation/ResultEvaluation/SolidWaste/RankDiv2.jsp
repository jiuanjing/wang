<%@ page import="com.bws.dbOperation.DBOperation" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.google.gson.Gson" %>
<%--
  Created by wangdegang on 2016/9/4 14:40
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DBOperation dbOperation = new DBOperation(true);
    String date = request.getParameter("date");
    date = date.length() == 0 ? "2016" : date;
    String kpiName = new String(request.getParameter("kpi").getBytes("ISO-8859-1"), "utf-8");
    if (dbOperation.dbOpen()) {

        Map<String, Object> gsonmap = new HashMap<String, Object>();
        List<String> list1 = new ArrayList<String>();
        List<String> list2 = new ArrayList<String>();
        List<String> list3 = new ArrayList<String>();
        List<String> list4 = new ArrayList<String>();

        String sql = " select t1.brief_name, t.actual_value, t.score ,t.kpi_id" +
                "  from dm_op_yr_evaluate t, dim_op_company t1, dim_op_kpi t2 " +
                " where t.date_id = " + date +
                "   and t2.kpi_name = '" + kpiName + "' " +
                "   and t.company_id = t1.company_id " +
                "   and t.kpi_id = t2.kpi_id " +
                "	and  t1.flag_solid_waste =1" +
                " order by t.actual_value ";
        //公司id为-1的实际值代表该kpi的标杆值
        String sql1 = " select t.actual_value " +
                "  from dm_op_yr_evaluate t, dim_op_kpi t2 " +
                " where t.date_id = " + date +
                "   and t2.kpi_name = '" + kpiName + "' " +
                "   and t.company_id = -1 " +
                "   and t.kpi_id = t2.kpi_id " +
                " order by t.actual_value ";
		
        ResultSet rs = dbOperation.executeQuery(sql);
        if (null != rs) {
            try {
                while (rs.next()) {
                    list1.add(rs.getString(1));
                    list2.add(rs.getString(2));
                    list4.add(rs.getString(4));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        ResultSet rs1 = dbOperation.executeQuery(sql1);
        if (null != rs1) {
            try {
                while (rs1.next()) {
                    list3.add(rs1.getString(1));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        gsonmap.put("data1",list1);
        gsonmap.put("data2",list2);
        gsonmap.put("data3",list3);//标杆值
		gsonmap.put("kpi_id", list4);
        
        dbOperation.dbClose();

        Gson gson = new Gson();
        String s = gson.toJson(gsonmap);
        out.write(s);

    } else {
        out.write("<script>alert('对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！');</script>");
    }
%>
