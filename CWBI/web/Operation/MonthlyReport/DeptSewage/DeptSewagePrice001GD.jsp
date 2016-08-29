<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.sql.ResultSetMetaData,java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String DeptID = request.getParameter("DeptID");
            String date = request.getParameter("date");
            String _date = "";
            if (!("".equals(date)) && date != null) {
                date = date.substring(0, 4) + date.substring(5, 7);
                _date = "m" + date.substring(5, 7);
            }
				/* 本期实际值 */
            String sqlstr1 = "select c.brief_name,"
                    + "d.brief_name,"
                    + "a.kpi_unit,"
                    + _date + ","
                    + "d.factory_id "
                    + " from echarts.dim_op_kpi          a,"
                    + " echarts.dm_op_mr_kpi_factory_actual b,"
                    + " echarts.dim_op_company      c,"
                    + " echarts.dim_op_factory      d "
                    + " where a.kpi_code_num = b.kpi_code_num"
                    + " and b.factory_id = d.factory_id"
                    + " and c.company_id = d.company_id"
                    + " and b.date_id = " + date
                    + " and c.dept_id = " + DeptID
                    + " and a.status = 1"
                    + " and a.kpi_code_num = 203010";/* 保底水价[元/吨]  */
            ResultSet rs = null;
            //拼返回串
            String str_return = "";
            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<Map<String, Object>> list_a = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> list_b = new ArrayList<Map<String, Object>>();
            //System.out.println(sql);
            rs = null;
            rs = db.executeQuery(sqlstr1);//通过数据库访问程序返回一个可滚动的记录集
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            int intRowCount1 = rs.getRow();//取总的记录数
            if (intRowCount1 > 0) {
                rs.absolute(1);
                ResultSetMetaData data = rs.getMetaData();
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("company_name", rs.getString(1));
                    map.put("factory_name", rs.getString(2));
                    map.put("kpi_unit", rs.getString(3));
                    map.put("m", rs.getString(4));
                    map.put("factory_id", rs.getString(5));
                    list_a.add(map);
                    rs.next();
                }
            }
				/* 超量水价 */
            if (list_a.size() > 0) {
                List<String> sqlList = new ArrayList<String>();
                for (int i = 0; i < list_a.size(); i++) {
                    String sql = "select c.brief_name,"
                            + "d.brief_name,"
                            + "a.kpi_unit,"
                            + _date + ","
                            + " from echarts.dim_op_kpi          a,"
                            + " echarts.dm_op_mr_kpi_factory_actual b,"
                            + " echarts.dim_op_company      c,"
                            + " echarts.dim_op_factory      d "
                            + " where a.kpi_code_num = b.kpi_code_num"
                            + " and b.factory_id = d.factory_id"
                            + " and c.company_id = d.company_id"
                            + " and b.date_id = " + date
                            + " and c.dept_id = " + DeptID
                            + " and d.factory_id = " + list_a.get(i).get("factory_id")
                            + " and a.status = 1"
                            + " and a.kpi_code_num = 203010";/* 超量水价[元/吨]  */
                    sqlList.add(sql);
                }
                for (int i = 0; i < sqlList.size(); i++) {
                    String sql = sqlList.get(i);
                    //System.out.println(sql);
                    rs = null;
                    rs = db.executeQuery(sql);//通过数据库访问程序返回一个可滚动的记录集
                    if (rs == null) {
                        throw new Exception("对不起！系统在查询数据库时出错");
                    }
                    rs.last();//定位到最后一条记录
                    int intRowCount = rs.getRow();//取总的记录数
                    if (intRowCount > 0) {
                        rs.absolute(1);
                        ResultSetMetaData data = rs.getMetaData();
                        while (!rs.isAfterLast()) {
                            Map<String, Object> map = new HashMap<String, Object>();
                            map.put("company_name", rs.getString(1));
                            map.put("factory_name", rs.getString(2));
                            map.put("kpi_unit", rs.getString(3));
                            map.put("m", rs.getString(4));
                            list_b.add(map);
                            rs.next();
                        }
                    } else {
                        Map<String, Object> map = new HashMap<String, Object>();
                        map.put("company_name", "");
                        map.put("factory_name", "");
                        map.put("kpi_unit", "");
                        map.put("m", "");
                        list_b.add(map);
                    }
                }
            }

            mapAll.put("opt_a", list_a);
            mapAll.put("opt_b", list_b);

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