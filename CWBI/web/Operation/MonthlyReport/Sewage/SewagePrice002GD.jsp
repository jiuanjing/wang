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
            String CompanyID = request.getParameter("CompanyID");
            String date = request.getParameter("date");
            String sqlstr = "";
            sqlstr = "select a.kpi_id,b.kpi_name, b.kpi_abbr,a.year_id, b.kpi_unit, a.kpi_value, a.kpi_desc"
                    + " from echarts.dm_op_mr_kpi_year_s a"
                    + " right join echarts.dim_op_kpi_year_s b on a.kpi_id = b.kpi_id";
            String where = "";
            if (!("".equals(date)) && date != null) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and a.report_date =" + date;
            }
            if (!("".equals(CompanyID)) && CompanyID != null) {
                where += " and a.company_id =" + CompanyID;
            }
            String con = " order by b.order_no,a.year_id";
            sqlstr += where;
            sqlstr += con;
            //System.out.println(sqlstr);
            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集

            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }

            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数
            //拼返回串
            String str_return = "";
            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<Map<String, Object>> list_a = new ArrayList<Map<String, Object>>();
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("kpi_id", rs.getString(1));
                    map.put("kpi_name", rs.getString(2));
                    map.put("kpi_abbr", rs.getString(3));
                    if (rs.getString(4) == null) {
                        map.put("year_id", "");
                    } else {
                        map.put("year_id", rs.getString(4));
                    }
                    if (rs.getString(5) == null) {
                        map.put("kpi_unit", "");
                    } else {
                        map.put("kpi_unit", rs.getString(5));
                    }
                    if (rs.getString(6) == null) {
                        map.put("kpi_value", "");
                    } else {
                        map.put("kpi_value", rs.getString(6));
                    }
                    if (rs.getString(7) == null) {
                        map.put("kpi_desc", "");
                    } else {
                        map.put("kpi_desc", rs.getString(7));
                    }
                    list_a.add(map);
                    rs.next();
                }
            } else {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("kpi_name", "");
                map.put("kpi_abbr", "");
                map.put("year_id", "");
                map.put("kpi_unit", "");
                map.put("kpi_value", "");
                map.put("kpi_desc", "");
                list_a.add(map);
            }

            str_return = gson.toJson(list_a);
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