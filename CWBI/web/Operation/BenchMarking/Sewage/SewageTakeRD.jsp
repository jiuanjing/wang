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
            String sqlstr = "";
            //部门DeptId
            String DeptId = request.getParameter("DeptId");
            //接收排序规则
            String order = request.getParameter("order");
            //获取日期yy-MM
            String date = request.getParameter("date");
            int month = 0;
            if (date != null && !(date.equals(""))) {
                //传来的日期格式为yyyy-MM
                month = Integer.parseInt(date.substring(5));
                date = date.substring(0, 4);
            } else {
                //转化的日期格式为yyyyMM
                date = DateTool.getPreMonDate03();
                month = Integer.parseInt(date.substring(4));
                date = date.substring(0, 4);
            }
            String ddd = "sum" + month;
            sqlstr = "select b.company_id,b.brief_name, round(c." + ddd + ",2) from echarts.dim_dept_op a, echarts.dim_op_company b, echarts.dm_op_mr_kpi_actual c";
            String where = " where a.dept_id=b.dept_id and b.company_id=c.company_id"
                    + " and c.kpi_code_num=103"//1003水费回收率指标
                    + " and b.Flag_Sewage = 1 and b.status = 1 and date_id =" + date;
            String orderBy = " order by c." + ddd + " " + order;
            sqlstr = sqlstr + where + orderBy;
            //System.out.println(sqlstr);
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
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("companyId", rs.getString(1));
                    map.put("briefName", rs.getString(2));
                    map.put("value", Float.parseFloat(rs.getString(3)));
                    list.add(map);
                    rs.next();
                }
            }
            mapAll.put("total", list.size());
            mapAll.put("rows", list);

            str_return = gson.toJson(mapAll);
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