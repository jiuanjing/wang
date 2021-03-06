<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.bws.dbOperation.DBOperation"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% 
	DBOperation db = new DBOperation(true);
	String date = new String(request.getParameter("date").getBytes("ISO-8859-1"),"gbk");
	date = date.equals("") ? "2015" : date;
	int dateID = Integer.parseInt(date);
	
	if(db.dbOpen()){
		Map<String, Object> gsonmap = new HashMap<String, Object>();
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String sql = 
				"select t1.brief_name," +
		                "       sum(comp_score) as comp_score," +
		                "       sum(decode(t.kpi_id, 2401, t.actual_value, null)) as 管理费用成本比," +
		                "       sum(decode(t.kpi_id, 2402, t.actual_value, null)) as 人均可控管理费用," +
		                "       sum(decode(t.kpi_id, 2403, t.actual_value, null)) as 吨水经营成本," +
		                "       sum(decode(t.kpi_id, 2404, t.actual_value, null)) as 吨水人工成本," +
		                "       sum(decode(t.kpi_id, 126, t.actual_value, null)) as 单位药剂费," +
		                "       sum(decode(t.kpi_id, 120, t.actual_value, null)) as 单位电耗," +
		                "       sum(decode(t.kpi_id, 2407, t.actual_value, null)) as 吨水电费," +
		                "       sum(decode(t.kpi_id, 149, t.actual_value, null)) as 吨水维修费," +
		                "       sum(decode(t.kpi_id, 148, t.actual_value, null)) as 吨水管理费" +
		                "   , t1.company_id from echarts.dm_op_yr_evaluate t,dim_op_company t1" +
		                " where t.date_id = "+dateID+" and t1.company_id = t.company_id and t1.flag_sewage = 1" +
		                "   and t.kpi_id in (2401,2402,2403,2404,126,120,2407,149,148)" +
		                " group by t.company_id,t1.brief_name,t1.company_id" +
		                " order by comp_score desc";
		
		ResultSet rs = db.executeQuery(sql);
		if(rs != null){
			try{
				int i= 1;
				while(rs.next()){
					Map<String, Object> dataMap = new HashMap<String, Object>();
					dataMap.put("m1", i + "");
					i ++;
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
					
					list.add(dataMap);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		gsonmap.put("total", list.size());
		gsonmap.put("rows", list);
		
		db.dbClose();
		
		Gson gson = new Gson();
		String s = gson.toJson(gsonmap);
		out.write(s);
	} else {
		out.write("<script>alert('对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！');</script>");
	}
%>