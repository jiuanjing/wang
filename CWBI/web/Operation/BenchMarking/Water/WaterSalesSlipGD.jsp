<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
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
            //获取日期
            String date = request.getParameter("date");
            String CompanyID = request.getParameter("CompanyID");
            int month = 0;//当前月份
            String sqlstr1 = "select nvl(c.m1,0),nvl(c.m2,0),nvl(c.m3,0),nvl(c.m4,0),nvl(c.m5,0),nvl(c.m6,0),nvl(c.m7,0),nvl(c.m8,0),nvl(c.m9,0),nvl(c.m10,0),nvl(c.m11,0),nvl(c.m12,0) from echarts.dm_op_mr_kpi_actual c"
                    + " where c.kpi_code_num=1025 and c.company_id = " + CompanyID;
            String sqlstr2 = "select nvl(c.m1,0),nvl(c.m2,0),nvl(c.m3,0),nvl(c.m4,0),nvl(c.m5,0),nvl(c.m6,0),nvl(c.m7,0),nvl(c.m8,0),nvl(c.m9,0),nvl(c.m10,0),nvl(c.m11,0),nvl(c.m12,0) from echarts.dm_op_mr_kpi_actual c"
                    + " where c.kpi_code_num=1028 and c.company_id = " + CompanyID;
            String sqlstr3 = "select round(c.sum1,2),round(c.sum2,2),round(c.sum3,2),round(c.sum4,2),round(c.sum5,2),round(c.sum6,2),round(c.sum7,2),round(c.sum8,2),round(c.sum9,2),round(c.sum10,2),round(c.sum11,2),round(c.sum12,2) from echarts.dm_op_mr_kpi_actual c"
                    + " where c.kpi_code_num=1034 and c.company_id = " + CompanyID;
            String sqlstr4 = "select round(c.sum1,2),round(c.sum2,2),round(c.sum3,2),round(c.sum4,2),round(c.sum5,2),round(c.sum6,2),round(c.sum7,2),round(c.sum8,2),round(c.sum9,2),round(c.sum10,2),round(c.sum11,2),round(c.sum12,2) from echarts.dm_op_mr_kpi_actual c"
                    + " where c.kpi_code_num=1038 and c.company_id = " + CompanyID;

            String where = "";

            if (date != null && !(date.equals(""))) {
                month = Integer.parseInt(date.substring(5));
                date = date.substring(0, 4);
                String date_pre = (Integer.parseInt(date) - 1) + "";
                where += " and date_id >=" + date_pre;
                where += " and date_id <=" + date;
            } else {
                //默认日期为上个月
                date = DateTool.getPreMonDate03();
                month = Integer.parseInt(date.substring(4));
                date = date.substring(0, 4);
                String date_pre = (Integer.parseInt(date) - 1) + "";
                where += " and date_id >=" + date_pre;
                where += " and date_id <=" + date;
            }
            sqlstr1 = sqlstr1 + where;
            sqlstr2 = sqlstr2 + where;
            sqlstr3 = sqlstr3 + where;
            sqlstr4 = sqlstr4 + where;
            List<String> sqlList = new ArrayList<String>();
            sqlList.add(sqlstr1);
            sqlList.add(sqlstr2);
            sqlList.add(sqlstr3);
            sqlList.add(sqlstr4);

            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<String> list1 = new ArrayList<String>();
            List<String> list2 = new ArrayList<String>();
            List<String> list3 = new ArrayList<String>();
            List<String> list4 = new ArrayList<String>();
            for (int i = 0; i < sqlList.size(); i++) {
                //System.out.println(sqlList.get(i));
                ResultSet rs = null;
                rs = db.executeQuery(sqlList.get(i));//通过数据库访问程序返回一个可滚动的记录集
                if (rs == null) {
                    throw new Exception("对不起！系统在查询数据库时出错");
                }
                rs.last();//定位到最后一条记录
                int intRowCount = rs.getRow();//取总的记录数
                if (intRowCount > 0) {
                    rs.absolute(1);
                    while (!rs.isAfterLast()) {
                        if (i == 0) {
                            list1.add(rs.getString(1));
                            list1.add(rs.getString(2));
                            list1.add(rs.getString(3));
                            list1.add(rs.getString(4));
                            list1.add(rs.getString(5));
                            list1.add(rs.getString(6));
                            list1.add(rs.getString(7));
                            list1.add(rs.getString(8));
                            list1.add(rs.getString(9));
                            list1.add(rs.getString(10));
                            list1.add(rs.getString(11));
                            list1.add(rs.getString(12));
                        } else if (i == 1) {
                            list2.add(rs.getString(1));
                            list2.add(rs.getString(2));
                            list2.add(rs.getString(3));
                            list2.add(rs.getString(4));
                            list2.add(rs.getString(5));
                            list2.add(rs.getString(6));
                            list2.add(rs.getString(7));
                            list2.add(rs.getString(8));
                            list2.add(rs.getString(9));
                            list2.add(rs.getString(10));
                            list2.add(rs.getString(11));
                            list2.add(rs.getString(12));
                        } else if (i == 2) {
                            list3.add(rs.getString(1));
                            list3.add(rs.getString(2));
                            list3.add(rs.getString(3));
                            list3.add(rs.getString(4));
                            list3.add(rs.getString(5));
                            list3.add(rs.getString(6));
                            list3.add(rs.getString(7));
                            list3.add(rs.getString(8));
                            list3.add(rs.getString(9));
                            list3.add(rs.getString(10));
                            list3.add(rs.getString(11));
                            list3.add(rs.getString(12));
                        } else if (i == 3) {
                            list4.add(rs.getString(1));
                            list4.add(rs.getString(2));
                            list4.add(rs.getString(3));
                            list4.add(rs.getString(4));
                            list4.add(rs.getString(5));
                            list4.add(rs.getString(6));
                            list4.add(rs.getString(7));
                            list4.add(rs.getString(8));
                            list4.add(rs.getString(9));
                            list4.add(rs.getString(10));
                            list4.add(rs.getString(11));
                            list4.add(rs.getString(12));
                        }
                        rs.next();
                    }
                }
            }
            int number = 12;//数据数量
            if (list3.size() <= 12) {
                number = list3.size();
            } else {
                number += month;
            }
            mapAll.put("supply", list1);
            mapAll.put("sell", list2);
            mapAll.put("salesSlip", list3);
            mapAll.put("power", list4);
            mapAll.put("number", number);
            mapAll.put("year", date);

            String str_return = gson.toJson(mapAll);
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