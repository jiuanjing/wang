<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,java.sql.ResultSet" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String sqlstr = "";
            String date = request.getParameter("date").trim();
            sqlstr = "select date_id,round(OPERATING_REVENUE_TY/10000,2),SELLING_GROWTH_RATE from echarts.dm_operating_growth where company_id=1";

            String where = "";
            if (date != null && !(date.equals(""))) {
                int begin_date_int = Integer.valueOf((Integer.valueOf(date.substring(0, 4)) - 1) + date.substring(5, 7));
                where += " and date_id >" + begin_date_int;
                int end_date_int = Integer.valueOf(date.substring(0, 4) + date.substring(5, 7));
                where += " and date_id <=" + end_date_int;
            }
            sqlstr = sqlstr + where + " order by date_id";

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
                str_return = "[";
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    str_return = str_return + "'" + rs.getString(1) + ":" + rs.getString(2) + ":" + rs.getString(3) + "',";
                    rs.next();
                }
                str_return = str_return.substring(0, str_return.length() - 1).trim() + "]";
            }
            str_return = "["
                    + "'201506:106:98:98.56',"
                    + "'201507:108:96:86.45',"
                    + "'201508:108:96:96.87',"
                    + "'201509:108:96:86.67',"
                    + "'201510:100:96:87.67',"
                    + "'201511:108:93:95.67',"
                    + "'201512:100:95:86.78',"
                    + "'201601:109:98:98.67',"
                    + "'201602:100:97:89.78',"
                    + "'201603:100:97:91.98',"
                    + "'201604:109:99:89.89',"
                    + "'201605:107:97:87.23'"
                    + "]";
            out.println(str_return);//ajax返回的结果

        } catch (Exception e) {
            throw e;
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
%>