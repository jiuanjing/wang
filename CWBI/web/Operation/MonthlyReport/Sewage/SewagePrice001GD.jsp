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
            sqlstr = "select t.var_id,b.var_name,b.var_unit,t.content,t.var_desc from echarts.dm_op_mr_price_s t right join echarts.dim_op_mr_price_s b"
                    + " on t.var_id = b.var_id and t.var_id>0 and t.var_id<=13";
            String where = "";
            if (!("".equals(date)) && date != null) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and t.report_date =" + date;
            }
            if (!("".equals(CompanyID)) && CompanyID != null) {
                where += " and t.company_id =" + CompanyID;
            }
            String con = " order by b.order_no";
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
                    map.put("var_id", rs.getString(1));
                    map.put("var_name", rs.getString(2));
                    if (rs.getString(3) == null) {
                        map.put("var_unit", "");
                    } else {
                        map.put("var_unit", rs.getString(3));
                    }
                    if (rs.getString(4) == null) {
                        map.put("content", "");
                    } else {
                        map.put("content", rs.getString(4));
                    }
                    if (rs.getString(5) == null) {
                        map.put("var_desc", "");
                    } else {
                        map.put("var_desc", rs.getString(5));
                    }
                    list_a.add(map);
                    rs.next();
                }
            } else {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("var_id", "");
                map.put("var_name", "");
                map.put("var_unit", "");
                map.put("content", "");
                map.put("var_desc", "");
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