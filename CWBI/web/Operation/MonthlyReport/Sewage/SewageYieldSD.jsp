<%
    /*********************************************************************************************************************
     *功能描述：存储污水公司水量管理 原因说明
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
            String CompanyID = request.getParameter("CompanyID");
            String date = request.getParameter("date");
            String Sewage = new String(request.getParameter("Sewage").getBytes("ISO8859-1"), "UTF-8");
            String sqlstr = "";
            sqlstr = "update echarts.DM_OP_MR_REASON_S t set REASON_SEWAGE='" + Sewage + "' "
                    + "where 1=1";
            String where = "";
            date = date.substring(0, 4) + date.substring(5, 7);
            where += " and t.report_date =" + date;
            where += " and t.company_id =" + CompanyID;
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