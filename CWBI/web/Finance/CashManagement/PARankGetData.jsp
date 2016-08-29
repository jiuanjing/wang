<%
    /*********************************************************************************************************************
     *程序名称：PARankGetData.jsp
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     *编写时间：2015-10-22
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
            //获取开始时间，结束时间
            String begin_date = request.getParameter("begin_date").trim();
            String end_date = request.getParameter("end_date").trim();
            String CompanyID = request.getParameter("CompanyID").trim();
            String order = request.getParameter("order").trim();
            String sort = request.getParameter("sort").trim();
            String base_value = request.getParameter("base_value").trim();
            //当前页
            int pageNum = Integer.valueOf(request.getParameter("page"));
            //每页显示数
            int rows = Integer.valueOf(request.getParameter("rows"));

            sqlstr = "select a.date_id,a.company_id,b.brief_name,a.voucher_no,a.debit_amount,a.credit_amount from echarts.dm_large_cash_payment a,echarts.dim_company_fn b where a.company_id = b.company_id";

            String where = "";

            if (begin_date != null && !(begin_date.equals(""))) {
                int begin_date_int = Integer.valueOf(begin_date.substring(0, 4) + begin_date.substring(5, 7) + begin_date.substring(8));
                where += " and a.date_id >=" + begin_date_int;
            }
            if (end_date != null && !(end_date.equals(""))) {
                int end_date_int = Integer.valueOf(end_date.substring(0, 4) + end_date.substring(5, 7) + end_date.substring(8));
                where += " and a.date_id <=" + end_date_int;
            }
            if (CompanyID != null && !(CompanyID.equals(""))) {
                where += " and a.company_id =" + CompanyID;
            }
            if (base_value != null && !(base_value.equals(""))) {
                where += " and (a.debit_amount >=" + base_value + " or a.credit_amount >=" + base_value + ")";
            }
            sqlstr = sqlstr + where + " and b.status=1 order by a." + sort + " " + order;

            //System.out.print(sqlstr);

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
            //System.out.println(intRowCount);
            if (intRowCount > 0) {
                int absPage = (pageNum - 1) * rows + 1;
                rs.absolute(absPage);
                int absRows = 0;
                for (int i = 0; i < rows; i++) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("date_id", rs.getString(1));
                    map.put("company_id", rs.getString(2));
                    map.put("brief_name", rs.getString(3));
                    map.put("voucher_no", rs.getString(4));
                    map.put("debit_amount", rs.getString(5));
                    map.put("credit_amount", rs.getString(6));
                    list.add(map);
                    if (rs.isLast()) {
                        break;
                    } else {
                        rs.next();
                    }

                }
            }
            mapAll.put("total", intRowCount);
            mapAll.put("rows", list);
            str_return = gson.toJson(mapAll);
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