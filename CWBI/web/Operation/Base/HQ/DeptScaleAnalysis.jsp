<%@ page import="com.bws.dbOperation.DBOperation" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %><%--
  Created by wang at 2016/10/13 15:09
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int type = Integer.parseInt(request.getParameter("type"));
    String year = request.getParameter("year");
    year = year.length() == 0 ? "2015" : year;
    String sort;
    switch (type) {
        case 1:
            sort = "FLAG_WATER";
            break;
        case 2:
            sort = "FLAG_SEWAGE";
            break;
        case 3:
            sort = "FLAG_RECLAIMED";
            break;
        case 4:
            sort = "FLAG_SOLID_WASTE";
            break;
        default:
            sort = "FLAG_WATER";
    }

    DBOperation db = new DBOperation(true);
    if (db.dbOpen()) {
        String sql = "select t2.dept_name, sum(t.scale) " +
                "  from dm_op_yr_base_scale t, dim_op_company t1,DIM_DEPT_OP t2 " +
                " where t1.company_id = t.company_id and t1.dept_id = t2.dept_id " +
                "   and t.date_id = ? and t1."+sort+" = 1 " +
                " group by t2.dept_name";
        PreparedStatement preparedStatement = db.getPrepareStmt(sql);
        try {
            preparedStatement.setString(1, year);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet != null) {
                List<Map<String,String>> list = new ArrayList<Map<String, String>>();
                while (resultSet.next()) {
                    Map<String,String> map = new HashMap<String, String>();
                    map.put("name",resultSet.getString(1));
                    map.put("value",resultSet.getString(2));

                    list.add(map);
                }
                Gson gson = new Gson();
                String returnData = gson.toJson(list);
                out.write(returnData);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
