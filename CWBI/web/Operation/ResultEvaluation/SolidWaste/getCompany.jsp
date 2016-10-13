<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.bws.dbOperation.DBOperation"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% 
	DBOperation db = new DBOperation(true);
	String company = new String(request.getParameter("company").getBytes("ISO-8859-1"),"gbk");
	String sql = "select t.company_id, t.brief_name from echarts.dim_op_company t where t.flag_solid_waste=1";
	List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
	
	ResultSet rs = db.executeQuery(sql);
	if(null != rs){
		try{
			while(rs.next()){
				Map<String, Object> map = new HashMap<String, Object>();
				if(company.equals(rs.getString(2))){
					map.put("id", rs.getString(1));
					map.put("text", rs.getString(2));
					map.put("selected", true);
				} else {
					map.put("id", rs.getString(1));
					map.put("text", rs.getString(2));
				}
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose();
		}
	}
	Gson gson = new Gson();
	String s = gson.toJson(list);
	out.write(s);
%>