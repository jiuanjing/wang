<%@ page import="com.bws.dbOperation.DBOperation" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.*" %>
<%--
  Author: wangdegang
  Date: 2016/9/2
  Time: 16:26
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String company = new String(request.getParameter("company").getBytes("ISO-8859-1"), "utf-8");
    DBOperation dbOperation = new DBOperation(true);
    Map<String, Object> gsonMap = new HashMap<String, Object>();
    Map<String, Object> map1 = new TreeMap<String, Object>();
    List<String> dataList1 = new ArrayList<String>();
    List<String> dataList2 = new ArrayList<String>();
    if (dbOperation.dbOpen()) {
        String sql = "select t.date_id ,sum(t.comp_score),sum(t.comp_rank)" +
                "    from dm_op_yr_evaluate t,dim_op_company t1" +
                " where t1.brief_name='" + company + "' and t.company_id = t1.company_id" +
                "   and t.kpi_id in (1100, 1200, 1300, 1400, 1500, 1600,1700)" +
                " group by t.date_id";
        ResultSet resultSet = dbOperation.executeQuery(sql);
        if (resultSet != null) {
            try {
                while (resultSet.next()) {
                    map1.put(resultSet.getString(1), resultSet.getString(2));
                    dataList2.add(resultSet.getString(3));
                }

            }catch (Exception e){
                e.printStackTrace();
            }
        }
        Set<Integer> keySet = new TreeSet<Integer>();
        for (String key : map1.keySet()) {
            keySet.add(Integer.parseInt(key));
        }
        for (int i = 2011; i < 2017; i++) {
            if (!keySet.contains(i)) {
                map1.put(String.valueOf(i), 0);
            }
        }
        for (String key : map1.keySet()) {
            dataList1.add((String) map1.get(key));
        }
        dbOperation.dbClose();
        gsonMap.put("comp_score",dataList1);
        gsonMap.put("comp_rank",dataList2);

        Gson gson = new Gson();
        String s = gson.toJson(gsonMap);
        out.write(s);
    }else {
        out.write("<script>alert('对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！');</script>");
    }
%>
