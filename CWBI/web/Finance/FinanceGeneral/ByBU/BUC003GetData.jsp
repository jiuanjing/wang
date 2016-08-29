<%
    /*********************************************************************************************************************
     *程序名称： BUC003GetData.jsp
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     *编写时间：
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
            //获取日期yy-MM
            String date = request.getParameter("date").trim();

            sqlstr = "select c.bu_name,round(sum(a.TOTAL_INVESTMENT)/10000,2) from echarts.DM_PROFITABILITY a ,echarts.dim_company_fn b,echarts.dim_bu c "
                    + "where a.company_id = b.company_id and b.bu_id = c.bu_id and a.company_id > 2 and a.TOTAL_INVESTMENT <> 0";

            String where = "";

            if (date != null && !(date.equals(""))) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and a.date_id =" + date;
            } else {
                //默认日期为上个月
                String date_str = DateTool.getPreMonDate02();
                where += " and date_id =" + date_str;
            }

            sqlstr = sqlstr + where + " and b.status=1 and c.status=1 and c.analysis_flag = 1 group by c.bu_name order by sum(a.TOTAL_INVESTMENT)";
            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集

            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }

            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数

            Gson gson = new Gson();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            //拼返回串
            String str_return = "";

            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("value", Float.parseFloat(rs.getString(2)));
                    map.put("name", rs.getString(1));
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