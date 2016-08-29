<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.bws.util.DateTool,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String sqlstr = "";
            //获取日期
            String date = request.getParameter("date").trim();
            int t_date = 0;
            sqlstr = "select b.dept_name,round(t.PROFIT_PARENT/10000,2),round(t.PROFIT_PARENT_LY/10000,2),"
                    + " round(t.PROFIT_PARENT_BUDGET_SELF/10000,2)"
                    + " from echarts.dm_qr_dept t, echarts.dim_dept b"
                    + " where 1=1"
                    + " and t.dept_id = b.dept_id"
                    + " and b.status = 1";
            String where = "";

            if (date != null && !(date.equals(""))) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and date_id =" + date;
            } else {
                //默认日期为上个月
                String date_str = DateTool.getPreMonDate02();
                where += " and date_id =" + date_str;
            }
            sqlstr = sqlstr + where;
            //System.out.println(sqlstr);

            Gson gson = new Gson();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

            //查询今年的利润总额
            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数
            //拼返回串
            String str_return = "";
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("dept_name", rs.getString(1));
                    map.put("profit_parent", Double.parseDouble(rs.getString(2)));
                    map.put("profit_parent_ly", Double.parseDouble(rs.getString(3)));
                    map.put("profit_parent_budget_self", Double.parseDouble(rs.getString(4)));
                    map.put("profit_parent_differ", Double.parseDouble(rs.getString(2)) - Double.parseDouble(rs.getString(3)));
                    if (Double.parseDouble(rs.getString(3)) != 0D) {
                        map.put("profit_parent_rate", (Double.parseDouble(rs.getString(2)) - Double.parseDouble(rs.getString(3))) / Double.parseDouble(rs.getString(3)) * 100);
                    } else {
                        map.put("profit_parent_rate", "-");
                    }
                    if (Double.parseDouble(rs.getString(4)) != 0D) {
                        map.put("finished_rate", Double.parseDouble(rs.getString(2)) / Double.parseDouble(rs.getString(4)) * 100);
                    } else {
                        map.put("finished_rate", "-");
                    }
                    list.add(map);
                    rs.next();
                }
            }
            str_return = gson.toJson(list);
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