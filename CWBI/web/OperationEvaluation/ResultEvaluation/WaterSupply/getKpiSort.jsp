<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.bws.dbOperation.DBOperation" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<String> idList = Arrays.asList("1100", "1200", "1300", "1400", "1500", "1600", "1700");
    List<String> valueList = new ArrayList<String>();

    DBOperation dbOperation = new DBOperation(true);
    if (dbOperation.dbOpen()) {
        String sql = "select t.kpi_name from dim_op_kpi t where t.kpi_id in (1100, 1200, 1300, 1400, 1500, 1600, 1700)";
        ResultSet resultSet = dbOperation.executeQuery(sql);
        if (resultSet != null) {
            while (resultSet.next()) {
                valueList.add(resultSet.getString(1));
            }
        }
    }
    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    for (int i = 0; i < 7; i++) {
        Map<String, String> map = new HashMap<String, String>();
        map.put("id", idList.get(i));
        map.put("text", valueList.get(i));
        list.add(map);
    }
    Gson gson = new Gson();
    String s = gson.toJson(list);
    out.write(s);
%>