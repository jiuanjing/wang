<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.text.DecimalFormat,java.util.ArrayList,java.util.HashMap,java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            //获取日期
            String date = request.getParameter("date");
            String DeptID = request.getParameter("DeptID");
            int year = Integer.valueOf(date.substring(0, 4));
            String column = "";
            for (int i = 0; i < 12; i++) {
                column += "nvl(round(m" + (i + 1) + ",2),0),";
            }
            column = column.substring(0, column.length() - 1).trim();

            String sqlstr1 = "select " + column + " from echarts.dm_op_mr_kpi_actual_sum t where t.sum_id=" + DeptID + " and t.kpi_code_num=1063 and t.date_id = " + (year - 1);//同期平均水价
            String sqlstr2 = "select " + column + " from echarts.dm_op_mr_kpi_actual_sum t where t.sum_id=" + DeptID + " and t.kpi_code_num=1063 and t.date_id = " + year;//实际平均水价
            String sqlstr3 = "select " + column + " from echarts.dm_op_mr_kpi_budget_sum t where t.sum_id=" + DeptID + " and t.kpi_code_num=1063 and t.date_id = " + year;//预算平均水价

            List<String> sqlList = new ArrayList<String>();
            sqlList.add(sqlstr1);
            sqlList.add(sqlstr2);
            sqlList.add(sqlstr3);

            Gson gson = new Gson();
            Map<String, Object> mapAll = new HashMap<String, Object>();
            List<Double> list1 = new ArrayList<Double>();  //
            List<Double> list2 = new ArrayList<Double>();
            List<Double> list3 = new ArrayList<Double>();
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
                            for (int a = 0; a < 12; a++) {
                                list1.add(rs.getDouble(a + 1));
                            }
                        } else if (i == 1) {
                            for (int a = 0; a < 12; a++) {
                                list2.add(rs.getDouble(a + 1));
                            }
                        } else if (i == 2) {
                            for (int a = 0; a < 12; a++) {
                                list3.add(rs.getDouble(a + 1));
                            }
                        }
                        rs.next();
                    }
                } else {
                    if (i == 0) {
                        for (int a = 0; a < 12; a++) {
                            list1.add(0D);
                        }
                    } else if (i == 1) {
                        for (int a = 0; a < 12; a++) {
                            list2.add(0D);
                        }
                    } else if (i == 2) {
                        for (int a = 0; a < 12; a++) {
                            list3.add(0D);
                        }
                    }
                }
            }

            List<String> list5 = new ArrayList<String>();//计划完成率
            List<String> list6 = new ArrayList<String>();//同比增长率
            List<String> list7 = new ArrayList<String>();//日期
            DecimalFormat df = new DecimalFormat("0.00");
            for (int i = 0; i < list2.size(); i++) {
                Double a = list1.get(i);
                Double b = list2.get(i);
                Double c = list3.get(i);
                if (c != 0) {
                    list5.add(df.format(b / c * 100));
                } else {
                    list5.add("0");
                }
                if (b != 0) {
                    list6.add(df.format((b - c) / c * 100));
                } else {
                    list6.add("0");
                }
            }
            for (int i = 0; i < 12; i++) {
                if (i < 9) {
                    list7.add(year + "-0" + (i + 1));
                } else {
                    list7.add(year + "-" + (i + 1));
                }
            }
            mapAll.put("ly", list1);
            mapAll.put("cy", list2);
            mapAll.put("bt", list3);
            mapAll.put("yoy", list6);
            mapAll.put("apr", list5);
            mapAll.put("date", list7);


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