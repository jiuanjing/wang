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
				/* 查询公司股东信息 */
            String sqlstr = "";
            sqlstr = "select t.stock_holder_name,"
                    + "t.stock_holder_percent,"
                    + "t.stock_holder_capital,"
                    + "t.trustee"
                    + " from echarts.dm_op_mr_basic_sh_w t"
                    + " where 1=1 and t.status = 1";
            String where = "";
            if (!("".equals(date)) && date != null) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and t.report_date =" + date;
            }
            if (!("".equals(CompanyID)) && CompanyID != null) {
                where += " and t.company_id =" + CompanyID;
            }
            sqlstr += where;
            sqlstr += " order by t.order_no";
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
                    map.put("stock_holder_name", rs.getString(1));
                    map.put("stock_holder_percent", rs.getString(2));
                    map.put("stock_holder_capital", rs.getString(3));
                    map.put("trustee", rs.getString(4));
                    list_a.add(map);
                    rs.next();
                }
            } else {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("stock_holder_name", "");
                map.put("stock_holder_percent", "");
                map.put("stock_holder_capital", "");
                map.put("trustee", "");
                list_a.add(map);
            }
            //将Null值替换为"";
            for (int i = 0; i < list_a.size(); i++) {
                for (String key : list_a.get(i).keySet()) {
                    if (list_a.get(i).get(key) == null) {
                        list_a.get(i).put(key, "");
                    }
                }
            }
				
				/* 查询公司信息 */
            sqlstr = "";
            sqlstr = "select t.PRESIDENT,"
                    + "t.VICE_PRESIDENT,"
                    + "t.OTHER_TRUSTEE,"
                    + "t.CHIEF_SUPERVISOR,"
                    + "t.SUPERVISOR,"
                    + "t.GENERAL_MANAGER,"
                    + "t.VICE_MANAGER,"
                    + "t.FINANCE_DIRECTOR"
                    + " from echarts.dm_op_mr_basic_info_w t where 1=1";
            sqlstr += where;
            //System.out.println(sqlstr);
            rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集

            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }

            rs.last();//定位到最后一条记录
            intRowCount = rs.getRow();//取总的记录数

            List<Object> list_b = new ArrayList<Object>();
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    list_b.add(rs.getString(1));
                    list_b.add(rs.getString(2));
                    list_b.add(rs.getString(3));
                    list_b.add(rs.getString(4));
                    list_b.add(rs.getString(5));
                    list_b.add(rs.getString(6));
                    list_b.add(rs.getString(7));
                    list_b.add(rs.getString(8));
                    rs.next();
                }
            } else {
                for (int i = 0; i < 8; i++) {
                    list_b.add("");
                }
            }
            //将Null值替换为"";
            for (int i = 0; i < list_b.size(); i++) {
                if (list_b.get(i) == null) {
                    list_b.set(i, "");
                }
            }
            mapAll.put("trustee_a", list_a);
            mapAll.put("trustee_b", list_b);

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