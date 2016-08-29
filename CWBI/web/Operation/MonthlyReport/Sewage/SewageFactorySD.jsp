<%
    /*********************************************************************************************************************
     *功能描述：存储污水厂原因说明
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String FactoryID = request.getParameter("FactoryID");
            String date = request.getParameter("date");
            String sewage = new String(request.getParameter("sewage").getBytes("ISO8859-1"), "UTF-8");
            String quality = new String(request.getParameter("quality").getBytes("ISO8859-1"), "UTF-8");
            String power = new String(request.getParameter("power").getBytes("ISO8859-1"), "UTF-8");
            String chemical = new String(request.getParameter("chemical").getBytes("ISO8859-1"), "UTF-8");
            String sludge = new String(request.getParameter("sludge").getBytes("ISO8859-1"), "UTF-8");
            String fix = new String(request.getParameter("fix").getBytes("ISO8859-1"), "UTF-8");
            String sqlstr = "";
            sqlstr = "update echarts.dm_op_mr_reason_factory_s t set "
                    + "REASON_SEWAGE='" + sewage + "',REASON_WATER_QUALITY='" + quality + "',"
                    + "REASON_COST_POWER='" + power + "',REASON_COST_CHEMICAL='" + chemical + "',"
                    + "REASON_COST_SLUDGE='" + sludge + "',REASON_COST_FIX='" + fix + "' where 1=1";
            String where = "";
            date = date.substring(0, 4) + date.substring(5, 7);
            where += " and t.report_date =" + date;
            where += " and t.factory_id =" + FactoryID;
            sqlstr += where;
            //System.out.println(sqlstr);
            int re = 0;
            re = db.executeUpdate(sqlstr);
            db.executeCommit();//提交事务
            String str_return = "";
            if (re < 1) {
                str_return = "对不起！系统在更新数据时出错，请重试或与系统管理员联系！";
            } else {
                str_return = "您好，更新原因说明成功！";
            }
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