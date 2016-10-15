<%@ page import="com.bws.dbOperation.DBOperation" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %><%--
  Created by wang at 2016/10/13 16:42
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
        String sql = "select t2.dept_name, sum(t.quantity) " +
                "  from dm_op_yr_base_scale t, dim_op_company t1,DIM_DEPT_OP t2 " +
                " where t.company_id = t1.company_id and  t1.dept_id = t2.dept_id " +
                "   and t.date_id = ? " +
                "   and t1."+sort+" = 1 " +
                " group by t2.dept_name " ;
        PreparedStatement preparedStatement = db.getPrepareStmt(sql);
        try {
            preparedStatement.setString(1, year);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet != null) {
                Map<String,List<String>> map = new HashMap<String, List<String>>();
                List<String> list1 = new ArrayList<String>();
                List<String> list2 = new ArrayList<String>();
                while (resultSet.next()) {
                    list1.add(resultSet.getString(1));
                    list2.add(resultSet.getString(2));
                }
                map.put("deptName",list1);
                map.put("quantity",list2);
                Gson gson = new Gson();
                String returnData = gson.toJson(map);
                out.write(returnData);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>