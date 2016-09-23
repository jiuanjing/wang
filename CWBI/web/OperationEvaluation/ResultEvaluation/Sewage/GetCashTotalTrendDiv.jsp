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
	String company = new String(request.getParameter("company").getBytes("ISO-8859-1"),"utf-8");
	
	Map<String, Object> gsonmap = new HashMap<String, Object>();
	List<String> dataList1 = new ArrayList<String>();
	List<String> dataList2 = new ArrayList<String>();
	List<String> dataList3 = new ArrayList<String>();
	
	if(db.dbOpen()){
		String sql = "select t.date_id ,sum(t.comp_score),sum(t.comp_rank)" +
                "  from dm_op_yr_evaluate t,dim_op_company t1" +
                " where t1.brief_name='" + company + "'  and t1.flag_sewage = 1 and t.company_id = t1.company_id" +
                "   and t.kpi_id in (2301,103,2303)" +
                " group by t.date_id order by t.date_id";
		
		ResultSet rs = db.executeQuery(sql);
		
		if(rs != null){
			try{
				while(rs.next()){
					dataList1.add(rs.getString(1));
					dataList2.add(rs.getString(2));
					dataList3.add(rs.getString(3));
				}
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		db.dbClose();
		gsonmap.put("date", dataList1);
		gsonmap.put("comp_score", dataList2);
		gsonmap.put("comp_rank", dataList3);
		
		Gson gson = new Gson();
		String s = gson.toJson(gsonmap);
		out.write(s);
	} else {
		out.write("<script>alert('对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！');</script>");
	}
%>