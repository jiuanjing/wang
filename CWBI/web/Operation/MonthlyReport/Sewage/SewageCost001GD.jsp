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
            String CompanyID = request.getParameter("CompanyID");
            String date = request.getParameter("date");
            String _date = "";
            if (!("".equals(date)) && date != null) {
                //date =  date.substring(0,4)+ date.substring(5,7);
                date = date.substring(0, 4);
                _date = (Integer.valueOf(date) - 100) + "";
            }
				/* 本期实际值 */
            String sqlstr1 = "select a.kpi_id,a.kpi_name \"平均电价\",a.kpi_unit,"
                    + " nvl(b.m1,0),nvl(b.m2,0),nvl(b.m3,0),nvl(b.m4,0),nvl(b.m5,0),"
                    + " nvl(b.m6,0),nvl(b.m7,0),nvl(b.m8,0),nvl(b.m9,0),nvl(b.m10,0),"
                    + " nvl(b.m11,0),nvl(b.m12,0),nvl(b.m13,0),nvl(b.m14,0)"
                    + " from echarts.dim_op_kpi a left join echarts.dm_op_mr_kpi_actual b on a.kpi_code_num = b.kpi_code_num"
                    + " where b.date_id =" + date + " and b.company_id =" + CompanyID + " and a.status = 1 and a.kpi_code_num =2018";
				/* 本期实际值 */
            String sqlstr2 = "select a.kpi_id,a.kpi_name \"电量\",a.kpi_unit,"
                    + " nvl(b.m1,0),nvl(b.m2,0),nvl(b.m3,0),nvl(b.m4,0),nvl(b.m5,0),"
                    + " nvl(b.m6,0),nvl(b.m7,0),nvl(b.m8,0),nvl(b.m9,0),nvl(b.m10,0),"
                    + " nvl(b.m11,0),nvl(b.m12,0),nvl(b.m13,0),nvl(b.m14,0)"
                    + " from echarts.dim_op_kpi a left join echarts.dm_op_mr_kpi_actual b on a.kpi_code_num = b.kpi_code_num"
                    + " where b.date_id =" + date + " and b.company_id =" + CompanyID + " and a.status = 1 and a.kpi_code_num =2019";
				/* 本期实际值 */
            String sqlstr3 = "select a.kpi_id,a.kpi_name \"单位制水电耗\",a.kpi_unit,"
                    + " nvl(b.m1,0),nvl(b.m2,0),nvl(b.m3,0),nvl(b.m4,0),nvl(b.m5,0),"
                    + " nvl(b.m6,0),nvl(b.m7,0),nvl(b.m8,0),nvl(b.m9,0),nvl(b.m10,0),"
                    + " nvl(b.m11,0),nvl(b.m12,0),nvl(b.m13,0),nvl(b.m14,0)"
                    + " from echarts.dim_op_kpi a left join echarts.dm_op_mr_kpi_actual b on a.kpi_code_num = b.kpi_code_num"
                    + " where b.date_id =" + date + " and b.company_id =" + CompanyID + " and a.status = 1 and a.kpi_code_num =2020";
				/* 预算值 */
            String sqlstr4 = "select a.kpi_id,a.kpi_name \"预算单位制水电耗\",a.kpi_unit,"
                    + " nvl(b.m1,0),nvl(b.m2,0),nvl(b.m3,0),nvl(b.m4,0),nvl(b.m5,0),"
                    + " nvl(b.m6,0),nvl(b.m7,0),nvl(b.m8,0),nvl(b.m9,0),nvl(b.m10,0),"
                    + " nvl(b.m11,0),nvl(b.m12,0),nvl(b.m13,0),nvl(b.m14,0)"
                    + " from echarts.dim_op_kpi a left join echarts.dm_op_mr_kpi_budget b on a.kpi_code_num = b.kpi_code_num"
                    + " where b.date_id =" + date + " and b.company_id =" + CompanyID + " and a.status = 1 and a.kpi_code_num = 2021";
				/* 去年同期值 */
            String sqlstr5 = "select a.kpi_id,a.kpi_name \"去年同期单位制水电耗\",a.kpi_unit,"
                    + " nvl(b.m1,0),nvl(b.m2,0),nvl(b.m3,0),nvl(b.m4,0),nvl(b.m5,0),"
                    + " nvl(b.m6,0),nvl(b.m7,0),nvl(b.m8,0),nvl(b.m9,0),nvl(b.m10,0),"
                    + " nvl(b.m11,0),nvl(b.m12,0),nvl(b.m13,0),nvl(b.m14,0)"
                    + " from echarts.dim_op_kpi a left join echarts.dm_op_mr_kpi_actual b on a.kpi_code_num = b.kpi_code_num"
                    + " where b.date_id =" + _date + " and b.company_id =" + CompanyID + " and a.status = 1 and a.kpi_code_num = 2022";
            List<String> sqlList = new ArrayList<String>();
            sqlList.add(sqlstr1);
            sqlList.add(sqlstr2);
            sqlList.add(sqlstr3);
            sqlList.add(sqlstr4);
            sqlList.add(sqlstr5);
            ResultSet rs = null;
            //拼返回串
            String str_return = "";
            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<Map<String, Object>> list_a = new ArrayList<Map<String, Object>>();
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
                        map.put("kpi_id", rs.getString(1));
                        map.put("kpi_name", data.getColumnName(2));
                        map.put("kpi_unit", rs.getString(3));
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
                        list_a.add(map);
                        rs.next();
                    }
                } else {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("kpi_id", "");
                    map.put("kpi_name", "");
                    map.put("kpi_unit", "");
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
            }
            //查询原因
            String sqlstr = "";
            sqlstr = "select REASON_COST_POWER from echarts.dm_op_mr_reason_s t where 1=1";
            sqlstr += " and t.report_date =" + date + " and t.company_id =" + CompanyID;
            //System.out.println(sqlstr);
            rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数
            List<Map<String, Object>> list_b = new ArrayList<Map<String, Object>>();
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("reason", rs.getString(1));
                    list_b.add(map);
                    rs.next();
                }
            } else {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("reason", "");
                list_b.add(map);
            }

            mapAll.put("operation", list_a);
            mapAll.put("reason", list_b);

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