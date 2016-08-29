<%
    /*********************************************************************************************************************
     *程序名称：WaterFactoryGatFactory.jsp
     *编写人：cjl
     *编写时间：2015-3-3
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
            String sqlstr = "";
            String CompanyID = request.getParameter("CompanyID");
            //获取分析的数据库表的名字
            sqlstr = "select a.factory_id, a.brief_name from echarts.dim_op_factory a where a.status = 1";
            String where = " and a.company_id = " + CompanyID;
            sqlstr += where;
            //System.out.print(sqlstr);
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
                    map.put("FactoryID", rs.getString(1));
                    map.put("briefName", rs.getString(2));
                    list.add(map);
                    rs.next();
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