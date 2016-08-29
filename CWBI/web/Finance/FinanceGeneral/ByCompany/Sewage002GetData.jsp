<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.bws.util.DateTool,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap,java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String sqlstr = "";
            //获取开始时间，结束时间
            String date = request.getParameter("date").trim();
            String order = request.getParameter("order");
            String sort = request.getParameter("sort");
            sqlstr = "select t.company_id,t.brief_name,round(t.PROFIT_CW/10000,2) from (select a.COMPANY_ID,b.brief_name,a.PROFIT_CW from echarts.dm_profitability a,echarts.dim_company_fn b"
                    + " where a.company_id = b.company_id and a.PROFIT_CW <> 0 and a.company_id > 2";

            String where = "";
            if (date != null && !(date.equals(""))) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and date_id =" + date;
            } else {
                //默认日期为上个月
                String date_str = DateTool.getPreMonDate02();
                where += " and date_id =" + date_str;
            }

            sqlstr = sqlstr + where + " and b.status=1  and b.bu_id = 6 and b.company_level=2 order by a." + sort + " " + order + ") t where rownum<=10";
            //System.out.println(sqlstr);
            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集

            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }

            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数

            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            //拼返回串
            String str_return = "";

            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("CompanyId", rs.getString(1));
                    map.put("CompanyName", rs.getString(2));
                    map.put("profit_cw", rs.getString(3));
                    list.add(map);
                    rs.next();
                }
            }
            mapAll.put("total", intRowCount);
            mapAll.put("rows", list);
            str_return = gson.toJson(mapAll);

            //System.out.println(date);
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