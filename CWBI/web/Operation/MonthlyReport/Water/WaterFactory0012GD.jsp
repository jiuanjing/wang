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
            String FactoryID = request.getParameter("FactoryID");
            String date = request.getParameter("date");
            String sqlstr = "";
            sqlstr = "select t.DESC_AIR_BLOWER,"
                    + "t.DESC_PUMP,"
                    + "t.PROCESS_DESCRIPTION,"
                    + "t.DESC_SLUDGE,"
                    + "t.DESC_SLUDGE_RATE,"
                    + "t.DESC_CHEMICAL1,"
                    + "t.DESC_CHEMICAL2,"
                    + "t.DESC_CHEMICAL3,"
                    + "t.DESC_CHEMICAL4,"
                    + "t.ARCHITECTURE_PIC,"
                    + "t.EMPLOYEE_HEADS"
                    + " from echarts.dm_op_mr_basic_factory_w t where 1=1";
            String where = "";
            if (!("".equals(date)) && date != null) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and t.report_date =" + date;
            }
            if (!("".equals(FactoryID)) && FactoryID != null) {
                where += " and t.factory_id =" + FactoryID;
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
                    list.add(rs.getString(9));
                    list.add(rs.getString(10));
                    list.add(rs.getString(11));
                    rs.next();
                }
            } else {
                for (int i = 0; i < 10; i++) {
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