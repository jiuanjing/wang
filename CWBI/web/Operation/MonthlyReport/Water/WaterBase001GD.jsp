<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.List" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String CompanyID = request.getParameter("CompanyID");
            String date = request.getParameter("date");
            String sqlstr = "";
            sqlstr = "select m.company_name,"
                    + "t.register_address,"
                    + "t.mail_address,"
                    + "t.operating_range,"
                    + "to_char(t.built_date,'yyyy-MM-dd'),"
                    + "to_char(t.operating_date,'yyyy-MM-dd'),"
                    + "t.time_limit,"
                    + "t.register_capital"
                    + " from echarts.dm_op_mr_basic_info_w t,echarts.dim_company_water m where t.company_id=m.company_id";
            String where = "";
            if (!("".equals(date)) && date != null) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and t.report_date =" + date;
            }
            if (!("".equals(CompanyID)) && CompanyID != null) {
                where += " and t.company_id =" + CompanyID;
            }
            sqlstr += where;
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
            List<Object> list = new ArrayList<Object>();
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    list.add(rs.getString(1));
                    list.add(rs.getString(2));
                    list.add(rs.getString(3));
                    list.add(rs.getString(4));
                    list.add(rs.getString(5));
                    list.add(rs.getString(6));
                    list.add(rs.getString(7));
                    list.add(rs.getString(8));
                    rs.next();
                }
            } else {
                for (int i = 0; i < 8; i++) {
                    list.add("");
                }
            }
            //将Null值替换为"";
            for (int i = 0; i < list.size(); i++) {
                if (list.get(i) == null) {
                    list.set(i, "");
                }
            }
            str_return = gson.toJson(list);
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