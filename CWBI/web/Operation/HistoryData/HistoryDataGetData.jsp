<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String EntityID = request.getParameter("EntityID");
            String DataSource = request.getParameter("DataSource");
            String date = request.getParameter("date");
            String tableName = "";
            if (DataSource.equals("actual")) {
                tableName = "t_il_op_kpi_actual_his";
            } else if (DataSource.equals("budget")) {
                tableName = "t_il_op_kpi_budget_his";
            }
            date = date + "12";
            String sqlstr = "";
            sqlstr = "select a.date_id,a.item_excel,a.serial_no,"
                    + "a.m1,a.m2,a.m3,a.m4,a.m5,a.m6,a.m7,"
                    + "a.m8,a.m9,a.m10,a.m11,a.m12,a.m13,a.m14"
                    + " from scil." + tableName + " a"
                    + " left join scil.dim_op_kpi_his b on a.kpi_code = b.kpi_code"
                    + " where a.entity_id = " + EntityID + " and a.date_id = " + date + " order by b.order_no";
            //System.out.println(sqlstr);
            String where = "";

            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集

            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数

            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            //拼返回串
            String str_return = "";
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("item_excel", rs.getString(2));
                    map.put("serial_no", rs.getString(3));
                    map.put("m1", rs.getString(4));
                    map.put("m2", rs.getString(5));
                    map.put("m3", rs.getString(6));
                    map.put("m4", rs.getString(7));
                    map.put("m5", rs.getString(8));
                    map.put("m6", rs.getString(9));
                    map.put("m7", rs.getString(10));
                    map.put("m8", rs.getString(11));
                    map.put("m9", rs.getString(12));
                    map.put("m10", rs.getString(13));
                    map.put("m11", rs.getString(14));
                    map.put("m12", rs.getString(15));
                    map.put("m13", rs.getString(16));
                    map.put("m14", rs.getString(17));
                    list.add(map);
                    rs.next();
                }
            }
            mapAll.put("total", list.size());
            mapAll.put("rows", list);

            str_return = gson.toJson(mapAll);
            out.print(str_return);//ajax返回的结果

        } catch (Exception e) {
            throw e;
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
%>