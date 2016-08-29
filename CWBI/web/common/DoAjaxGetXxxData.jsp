<%
    /*********************************************************************************************************************
     *程序名称：DoAjaxGetXxxData.jsp
     *功能描述：从数据库中动态取得数据，并返回List,获取一个单表中某字段的数据
     *需要参数：target字段名，tableName数据库表名，conditions为条件（用“，”隔开）
     *编写人：cjl
     *编写时间：2015-11-3
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.bws.util.ConvertToMap,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap,java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);
    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String sqlstr = "";
            //获取分析的字段名字
            String target = request.getParameter("target").trim();
            //获取分析的数据库表的名字
            String tableName = request.getParameter("tableName").trim();
            //获取条件
            String conditions = request.getParameter("conditions").trim();

            sqlstr = "select " + target + " from echarts." + tableName;
            String where = " where 1=1";

            if (conditions != null && !(conditions.equals(""))) {
                Map<String, Object> map = ConvertToMap.FormatToMap(conditions);
                for (String param : map.keySet()) {
                    where += " and " + param + " = " + map.get(param);
                }
            }
            sqlstr += where;
            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集
            //System.out.println(sqlstr);
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
                int li = rs.getMetaData().getColumnCount();
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    for (int i = 1; i <= li; i++) {
                        map.put("value" + i, rs.getString(i));
                    }
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