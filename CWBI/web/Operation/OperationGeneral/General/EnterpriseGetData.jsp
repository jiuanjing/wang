<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.text.DecimalFormat,java.text.SimpleDateFormat,java.util.ArrayList,java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            Gson gson = new Gson();
            List<String> listData = new ArrayList<String>();
            List<String> listData2 = new ArrayList<String>();
            List<String> sqlList = new ArrayList<String>();
            String str_return = "";
            String date = request.getParameter("date").trim();
            String now = ""; //输入的时间
            String pre = ""; //输入的时间上一个月
            String pre01 = ""; //输入的时间上上个月

            String ly = "";//输入的时间去年同期
            String ly01 = "";//输入的时间去年同期的上个月

            if (date != null && !(date.equals(""))) {
                Date input = new Date(date.replace("-", "/") + "/01");
                SimpleDateFormat df = new SimpleDateFormat("yyyyMM");
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(input);
                now = df.format(calendar.getTime());
                calendar.add(Calendar.MONTH, -1);
                pre = df.format(calendar.getTime());
                calendar.add(Calendar.MONTH, -1);
                pre01 = df.format(calendar.getTime());
                calendar.add(Calendar.MONTH, 2);
                calendar.add(Calendar.YEAR, -1);
                ly = df.format(calendar.getTime());
                calendar.add(Calendar.MONTH, -1);
                ly01 = df.format(calendar.getTime());
            }
            //System.out.print(now+"-"+pre+"-"+pre01+"-"+ly+"-"+ly01+"-");
            //年累计收入
            String sql1 = "select round(OPERATING_REVENUE_TY/10000,0) from echarts.dm_operating_growth where company_id=1 and date_id = " + now;
            //年累计收入上个月
            String sql2 = "select round(OPERATING_REVENUE_TY/10000,0) from echarts.dm_operating_growth where company_id=1 and date_id = " + pre;
            //年累计收入上上个月
            String sql3 = "select round(OPERATING_REVENUE_TY/10000,0) from echarts.dm_operating_growth where company_id=1 and date_id = " + pre01;
            //同期年累计收入
            String sql4 = "select round(OPERATING_REVENUE_TY/10000,0) from echarts.dm_operating_growth where company_id=1 and date_id = " + ly;
            //同期的上个月年累计收入
            String sql5 = "select round(OPERATING_REVENUE_TY/10000,0) from echarts.dm_operating_growth where company_id=1 and date_id = " + ly01;

            sqlList.add(sql1);
            sqlList.add(sql2);
            sqlList.add(sql3);
            sqlList.add(sql4);
            sqlList.add(sql5);
            ////////////////////////////////////////////1
            for (int i = 0; i < sqlList.size(); i++) {
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
                        listData.add(rs.getString(1));
                        rs.next();
                    }
                } else {
                    listData.add("0");
                }
                rs.close();
            }
            DecimalFormat df = new DecimalFormat("#,###");
            if (!(date.equals("")) && date.substring(5, 7).equals("01")) {
                //一月份本期值就为一月份值
                listData2.add(listData.get(0));
                //上个月值
                if (!(listData.get(1).equals("-")) && !(listData.get(2).equals("-"))) {
                    String preData = (Integer.parseInt(listData.get(1)) - Integer.parseInt(listData.get(2))) + "";
                    Double d0 = Double.parseDouble(preData);
                    String m0 = df.format(d0);
                    listData2.add(m0);
                } else {
                    listData2.add("-");
                }
                //去年同期收入
                Double d1 = Double.parseDouble(listData.get(3));
                String m1 = df.format(d1);
                listData2.add(m1);
                //年累计收入
                Double d2 = Double.parseDouble(listData.get(0));
                String m2 = df.format(d2);
                listData2.add(m2);
                //去年年累计收入
                Double d3 = Double.parseDouble(listData.get(3));
                String m3 = df.format(d3);
                listData2.add(m3);
            } else {
                //本期值
                if (!(listData.get(0).equals("-")) && !(listData.get(1).equals("-"))) {
                    String preData = (Integer.parseInt(listData.get(0)) - Integer.parseInt(listData.get(1))) + "";
                    Double d0 = Double.parseDouble(preData);
                    String m0 = df.format(d0);
                    listData2.add(m0);
                } else {
                    listData2.add("0");
                }
                //上个月值
                if (!(listData.get(1).equals("-")) && !(listData.get(2).equals("-"))) {
                    String preData = (Integer.parseInt(listData.get(1)) - Integer.parseInt(listData.get(2))) + "";
                    Double d0 = Double.parseDouble(preData);
                    String m0 = df.format(d0);
                    listData2.add(m0);
                } else {
                    listData2.add("0");
                }
                //去年同期收入
                if (!(listData.get(3).equals("-")) && !(listData.get(4).equals("-"))) {
                    String preData = (Integer.parseInt(listData.get(3)) - Integer.parseInt(listData.get(4))) + "";
                    Double d0 = Double.parseDouble(preData);
                    String m0 = df.format(d0);
                    listData2.add(m0);
                } else {
                    listData2.add("0");
                }
                //年累计收入
                Double d1 = Double.parseDouble(listData.get(0));
                String m1 = df.format(d1);
                listData2.add(m1);
                //去年年累计收入
                Double d2 = Double.parseDouble(listData.get(3));
                String m2 = df.format(d2);
                listData2.add(m2);
            }

            str_return = gson.toJson(listData2);
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