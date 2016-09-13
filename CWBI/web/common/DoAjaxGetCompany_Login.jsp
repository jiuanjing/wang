<%
    /*********************************************************************************************************************
     *程序名称：DoAjaxGetCompany_Login.jsp
     *功能描述：从数据库中动态取得数据，并返回
     *用于登录页面，获取公司列表
     *返回：公司列表
     *编写人：cjl
     *编写时间：2015-10-28
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap,java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);
    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String sqlstr = "";
            sqlstr = "select company_code,company_name from bim.company";

            String where = " where length(company_code)<=4";

            String orderBy = " order by company_name";
            sqlstr += where;
            sqlstr += orderBy;
            ResultSet rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集

            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数

            Gson gson = new Gson();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> list1 = new ArrayList<Map<String, Object>>();
            //拼返回串
            String str_return = "";
            if (intRowCount > 0) {
                rs.absolute(1);

                Map<String, Object> mapP = new HashMap<String, Object>();
                while (!rs.isAfterLast()) {
                    if (rs.getString(1).equals("01")) {
                        mapP.put("id", rs.getString(1));
                        mapP.put("text", rs.getString(2));
                        mapP.put("children", "");
                    } else {
                        Map<String, Object> mapS = new HashMap<String, Object>();
                        mapS.put("id", rs.getString(1));
                        mapS.put("text", rs.getString(2));
                        mapS.put("children", "");
                        list1.add(mapS);
                    }
                    rs.next();
                }
                mapP.put("children", list1);
                list.add(mapP);
                str_return = gson.toJson(list);
                out.print(str_return);//ajax返回的结果
            }
        } catch (Exception e) {
            throw e;
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }

%>