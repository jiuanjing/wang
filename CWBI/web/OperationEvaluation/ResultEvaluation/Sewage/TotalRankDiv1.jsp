<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.bws.dbOperation.DBOperation"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% 
	DBOperation db = new DBOperation(true);
	String date = new String(request.getParameter("date").getBytes("ISO-8859-1"),"gbk");
	date = date.equals("") ? "2015" : date;
	String kpiName = new String(request.getParameter("kpi").getBytes("ISO-8859-1"),"utf-8");

	if(db.dbOpen()){
		Map<String, Object> gsonmap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		 String sql = " select t1.brief_name, t.actual_value, t.comp_score " +
	                "  from dm_op_yr_evaluate t, dim_op_company t1, dim_op_kpi t2 " +
	                " where t.date_id = " + date +
	                "   and t2.kpi_name = '" + kpiName + "' " +
	                "   and t.company_id = t1.company_id " +
	                "   and t.kpi_id = t2.kpi_id " +
	                "	and  t1.flag_solid_waste =1" +
	                " order by t.comp_score desc";
		 System.out.println(sql);
		 ResultSet rs = db.executeQuery(sql);
		 if(null != rs){
			 try {
				 int i = 1;
				 while (rs.next()){
					 Map<String, Object> datamap = new HashMap<String, Object>();
					 datamap.put("m1", i + "");
					 i++;
					 datamap.put("m2", rs.getString(1));
					 datamap.put("m3", rs.getString(2));
					 datamap.put("m4", rs.getString(3));
					 list.add(datamap);
				 }
			 } catch (SQLException e) {
				 e.printStackTrace();
			 }
		 }
		 gsonmap.put("total", list.size());
		 gsonmap.put("rows", list);
		
		 db.dbClose();
		 	 
		 Gson gson = new Gson();
		 String s =gson.toJson(gsonmap);
		 out.write(s);
	} else {
		 out.write("<script>alert('对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！');</script>");
	}
%>