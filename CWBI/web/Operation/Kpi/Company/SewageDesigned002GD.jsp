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
            String CompanyID = request.getParameter("CompanyID");
            int year = Integer.valueOf(date.substring(0, 4));
            String column = "";
            for (int i = 0; i < 12; i++) {
                column += "nvl(round(m" + (i + 1) + ",2),0),";
            }
            column = column.substring(0, column.length() - 1).trim();
            //累计值
            String sumcolumn = "nvl(round(m13,2),0)";

            String sqlstr1 = "select " + column + "," + sumcolumn + " from echarts.dm_op_mr_kpi_actual t where t.company_id = " + CompanyID + " and t.kpi_code_num=2041 and t.date_id = " + (year - 1);//同期设计水量
            String sqlstr2 = "select " + column + "," + sumcolumn + " from echarts.dm_op_mr_kpi_actual t where t.company_id = " + CompanyID + " and t.kpi_code_num=2041 and t.date_id = " + year;//设计水量实际值

            List<String> sqlList = new ArrayList<String>();
            sqlList.add(sqlstr1);
            sqlList.add(sqlstr2);

            Gson gson = new Gson();
            List<Object> list0 = new ArrayList<Object>();
            Map<String, Object> map1 = new HashMap<String, Object>();
            Map<String, Object> map2 = new HashMap<String, Object>();
            map1.put("kpi", "设计水量同期值(万吨/日)");
            map2.put("kpi", "设计水量实际值(万吨/日)");
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
                            for (int a = 0; a < 13; a++) {
                                map1.put("m" + (a + 1), rs.getDouble(a + 1));
                            }
                        } else if (i == 1) {
                            for (int a = 0; a < 13; a++) {
                                map2.put("m" + (a + 1), rs.getDouble(a + 1));
                            }
                        }
                        rs.next();
                    }
                } else {
                    if (i == 0) {
                        for (int a = 0; a < 13; a++) {
                            map1.put("m" + (a + 1), 0D);
                        }
                    } else if (i == 1) {
                        for (int a = 0; a < 13; a++) {
                            map2.put("m" + (a + 1), 0D);
                        }
                    }
                }
            }
            Map<String, Object> map5 = new HashMap<String, Object>();
            DecimalFormat df = new DecimalFormat("0.00");
            //同比
            map5.put("kpi", "同比(%)");
            for (int i = 0; i < map2.size() - 1; i++) {
                if (!(map1.isEmpty()) && (Double) map1.get("m" + (i + 1)) != 0) {
                    Double d = ((Double) map2.get("m" + (i + 1)) - (Double) map1.get("m" + (i + 1))) / (Double) map1.get("m" + (i + 1)) * 100;
                    map5.put("m" + (i + 1), df.format(d));
                } else {
                    map5.put("m" + (i + 1), 0D);
                }
            }
            list0.add(map1);
            list0.add(map2);
            list0.add(map5);
            Map<String, Object> mapAll = new HashMap<String, Object>();
            mapAll.put("rows", list0);
            mapAll.put("total", list0.size());
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