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
                _date = (Integer.valueOf(date) - 100) + "";
            }
				/* 本期实际值 -净利润*/
            String sqlstr1 = "select c.company_id,"
                    + "c.brief_name,"
                    + "nvl(b.m1, 0),"
                    + "nvl(b.m2, 0),"
                    + "nvl(b.m3, 0),"
                    + "nvl(b.m4, 0),"
                    + "nvl(b.m5, 0),"
                    + "nvl(b.m6, 0),"
                    + "nvl(b.m7, 0),"
                    + "nvl(b.m8, 0),"
                    + "nvl(b.m9, 0),"
                    + "nvl(b.m10, 0),"
                    + "nvl(b.m11, 0),"
                    + "nvl(b.m12, 0),"
                    + "nvl(b.m13, 0),"
                    + "nvl(b.m14, 0) "
                    + " from echarts.dm_op_mr_kpi_actual b,echarts.dim_op_company c"
                    + " where b.company_id = c.company_id"
                    + " and b.date_id =" + date + " and c.dept_id =" + DeptID + " and b.kpi_code_num =201003";
            //System.out.println(sqlstr1);
            ResultSet rs = null;
            //拼返回串
            String str_return = "";
            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<Map<String, Object>> list_a = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> list_b = new ArrayList<Map<String, Object>>();
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
                    map.put("type", "实际");
                    map.put("company_id", rs.getString(1));
                    map.put("company_name", rs.getString(2));
                    map.put("m1", rs.getString(3));
                    map.put("m2", rs.getString(4));
                    map.put("m3", rs.getString(5));
                    map.put("m4", rs.getString(6));
                    map.put("m5", rs.getString(7));
                    map.put("m6", rs.getString(8));
                    map.put("m7", rs.getString(9));
                    map.put("m8", rs.getString(10));
                    map.put("m9", rs.getString(11));
                    map.put("m10", rs.getString(12));
                    map.put("m11", rs.getString(13));
                    map.put("m12", rs.getString(14));
                    map.put("m13", rs.getString(15));
                    list_a.add(map);
                    rs.next();
                }
            } else {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("type", "实际");
                map.put("company_id", "0");
                map.put("company_name", "");
                map.put("m1", "");
                map.put("m2", "");
                map.put("m3", "");
                map.put("m4", "");
                map.put("m5", "");
                map.put("m6", "");
                map.put("m7", "");
                map.put("m8", "");
                map.put("m9", "");
                map.put("m10", "");
                map.put("m11", "");
                map.put("m12", "");
                map.put("m13", "");
                list_a.add(map);
            }
				/* 查询预算值-净利润 */
            if (list_a.size() > 0) {
                List<String> sqlList = new ArrayList<String>();
                for (int i = 0; i < list_a.size(); i++) {
                    String sql = "select c.company_id,"
                            + "c.brief_name,"
                            + "nvl(b.m1, 0),"
                            + "nvl(b.m2, 0),"
                            + "nvl(b.m3, 0),"
                            + "nvl(b.m4, 0),"
                            + "nvl(b.m5, 0),"
                            + "nvl(b.m6, 0),"
                            + "nvl(b.m7, 0),"
                            + "nvl(b.m8, 0),"
                            + "nvl(b.m9, 0),"
                            + "nvl(b.m10, 0),"
                            + "nvl(b.m11, 0),"
                            + "nvl(b.m12, 0),"
                            + "nvl(b.m13, 0),"
                            + "nvl(b.m14, 0) "
                            + " from echarts.dm_op_mr_kpi_budget b,echarts.dim_op_company c"
                            + " where b.company_id = c.company_id"
                            + " and b.date_id =" + _date
                            + " and c.company_id =" + list_a.get(i).get("company_id")
                            + " and b.kpi_code_num = 101003";
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
                            map.put("type", "计划");
                            map.put("company_id", rs.getString(1));
                            map.put("company_name", rs.getString(2));
                            map.put("m1", rs.getString(3));
                            map.put("m2", rs.getString(4));
                            map.put("m3", rs.getString(5));
                            map.put("m4", rs.getString(6));
                            map.put("m5", rs.getString(7));
                            map.put("m6", rs.getString(8));
                            map.put("m7", rs.getString(9));
                            map.put("m8", rs.getString(10));
                            map.put("m9", rs.getString(11));
                            map.put("m10", rs.getString(12));
                            map.put("m11", rs.getString(13));
                            map.put("m12", rs.getString(14));
                            map.put("m13", rs.getString(15));
                            list_b.add(map);
                            rs.next();
                        }
                    } else {
                        Map<String, Object> map = new HashMap<String, Object>();
                        map.put("type", "计划");
                        map.put("company_id", "");
                        map.put("company_name", "");
                        map.put("m1", "");
                        map.put("m2", "");
                        map.put("m3", "");
                        map.put("m4", "");
                        map.put("m5", "");
                        map.put("m6", "");
                        map.put("m7", "");
                        map.put("m8", "");
                        map.put("m9", "");
                        map.put("m10", "");
                        map.put("m11", "");
                        map.put("m12", "");
                        map.put("m13", "");
                        list_b.add(map);
                    }
                }
            }
            //查询原因
				/* 
				*加载数据不正确-暂无数据库表-等待修改!!
				*
				*/
            String sqlstr = "";
            sqlstr = "select REASON_OP_WATER_FEE from echarts.dm_op_mr_reason_w t where 1=1";
            sqlstr += " and t.report_date =" + date + " and t.company_id =" + DeptID;
            //System.out.println(sqlstr);
            rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数
            List<Map<String, Object>> list_c = new ArrayList<Map<String, Object>>();
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("reason", rs.getString(1));
                    list_c.add(map);
                    rs.next();
                }
            } else {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("reason", "");
                list_c.add(map);
            }

            mapAll.put("opt_a", list_a);
            mapAll.put("opt_b", list_b);
            mapAll.put("reason", list_c);

            str_return = gson.toJson(mapAll);
            //System.out.print(str_return);
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