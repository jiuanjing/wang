<%@ page import="com.bws.dbOperation.DBOperation" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by wang at 2016/10/13 17:23
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DBOperation db = new DBOperation(true);
    if (db.dbOpen()) {
        String sql = "select distinct(t.date_id) from dm_op_yr_base_scale t order by t.date_id desc";
        ResultSet resultSet = db.executeQuery(sql);
        if (resultSet != null) {
            List<Map<String, String>> list = new ArrayList<Map<String, String>>();
            try {
                while (resultSet.next()) {
                    Map<String, String> map = new HashMap<String, String>();
                    map.put("id", resultSet.getString(1));
                    map.put("text", resultSet.getString(1));
                    if (resultSet.getString(1).equals("2015")){
                        map.put("selected","true");
                    }
                    list.add(map);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            Gson gson = new Gson();
            String returnData = gson.toJson(list);
            out.write(returnData);

        }
    }
%>
