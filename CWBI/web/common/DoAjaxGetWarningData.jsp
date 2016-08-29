<%
    /*********************************************************************************************************************
     *程序名称：DoAjaxGetWarningData.jsp
     *功能描述：从数据库中动态取得数据，并返回
     *需要参数：dateId："yy-MM"，target:"字段名"，tableName:"数据库表名",DeptId:"部门ID",order:"排序规则（由easyui确定）"
     *返回：target字段值、公司ID、公司简称 的json对象
     *编写人：cjl
     *编写时间：2015-10-28
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
            //获取日期yy-MM
            String date = request.getParameter("date").trim();
            //获取分析的字段名字
            String target = request.getParameter("target").trim();
            //获取分析的数据库表的名字
            String tableName = request.getParameter("tableName").trim();
            //部门DeptId
            String DeptId = request.getParameter("DeptId");
            //接收排序规则
            String order = request.getParameter("order");

            sqlstr = "select a." + target + ",a.company_id,b.brief_name from echarts." + tableName + " a,echarts.DIM_COMPANY_FN b";

            String where = " where a.company_id = b.company_id and b.status=1";

            if (date != null && !(date.equals(""))) {
                date = date.substring(0, 4) + date.substring(5, 7);
                where += " and a.date_id =" + date;
            } else {
                //默认日期为上个月
                String date_str = DateTool.getPreMonDate02();
                where += " and date_id =" + date_str;
            }
            if (DeptId != null && !(DeptId.equals(""))) {
                where += " and b.dept_id =" + DeptId;
            }
            String orderBy = " order by a." + target + " " + order;
            sqlstr += where;
            sqlstr += orderBy;
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
                    map.put("value", Float.parseFloat(rs.getString(1)));
                    map.put("companyId", rs.getString(2));
                    map.put("briefName", rs.getString(3));
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