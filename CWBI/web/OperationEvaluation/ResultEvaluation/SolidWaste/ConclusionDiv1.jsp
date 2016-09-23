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
		String sql = "select t1.brief_name," +
		                "       sum(comp_score) as comp_score," +
		                "       sum(decode(t.kpi_id, 4100, t.actual_value, null)) as 盈利能力," +
		                "       sum(decode(t.kpi_id, 4200, t.actual_value, null)) as 债务风险," +
		                "       sum(decode(t.kpi_id, 4300, t.actual_value, null)) as 现金获取," +
		                "       sum(decode(t.kpi_id, 4400, t.actual_value, null)) as 成本控制," +
		                "       sum(decode(t.kpi_id, 4500, t.actual_value, null)) as 业务增长," +
		                "       sum(decode(t.kpi_id, 4600, t.actual_value, null)) as 经营效率," +
		                "       sum(decode(t.kpi_id, 4700, t.actual_value, null)) as 人员素质" +
		                "  from dm_op_yr_evaluate t,dim_op_company t1" +
		                " where t.date_id = "+dateID+" and t1.company_id = t.company_id and t1.flag_solid_waste = 1" +
		                "   and t.kpi_id in (4100,4200,4300,4400,4500,4600,4700)" +
		                " group by t.company_id,t1.brief_name" +
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
					dataMap.put("m3", rs.getString(3));
					dataMap.put("m4", rs.getString(4));
					dataMap.put("m5", rs.getString(5));
					dataMap.put("m6", rs.getString(6));
					dataMap.put("m7", rs.getString(7));
					dataMap.put("m8", rs.getString(8));
					dataMap.put("m9", rs.getString(9));
					
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