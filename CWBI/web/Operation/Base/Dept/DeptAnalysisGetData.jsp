<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     *编写时间：2016-2-25
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
            String DeptID = request.getParameter("DeptID");
            String where = "";
            if ("".equals(DeptID) || DeptID == null) {
                //
            } else {
                where += " and t.dept_id = " + DeptID;
            }
            String sqlstr = "select t.dept_id,b.dept_name, nvl(sum(t.company_count),0),nvl(sum(t.factory_count),0),"
                    + " nvl(round(sum(t.register_capital),2),0), nvl( sum(t.total_employee),0),"
                    + " nvl(sum(t.actual_capacity),0), nvl(sum(t.sign_capacity_water),0),"
                    + " nvl(sum(t.sign_capacity_sewage),0), nvl(sum(t.sign_capacity_reclaimed),0),"
                    + " nvl(sum(t.sign_capacity_total),0), nvl(sum(t.sign_capacity_sw),0)"
                    + " from echarts.dm_op_company_basic_info t,echarts.dim_dept_op b"
                    + " where t.dept_id = b.dept_id";
            sqlstr = sqlstr + where + " group by t.dept_id,b.dept_name order by t.dept_id";
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
            List<Map<String, Object>> list_b = new ArrayList<Map<String, Object>>();
            //拼返回串
            String str_return = "";
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("_parentId", "");
                    map.put("ID", rs.getString(1));
                    map.put("dept_name", rs.getString(2));
                    map.put("company_count", rs.getString(3));
                    map.put("factory_count", rs.getString(4));
                    map.put("register_capital", rs.getString(5));
                    map.put("total_employee", rs.getString(6));
                    map.put("actual_capacity", rs.getString(7));
                    map.put("sign_capacity_water", rs.getString(8));
                    map.put("sign_capacity_sewage", rs.getString(9));
                    map.put("sign_capacity_reclaimed", rs.getString(10));
                    map.put("sign_capacity_total", rs.getString(11));
                    map.put("sign_capacity_sw", rs.getString(12));
                    map.put("memo", "");
                    list.add(map);
                    rs.next();
                }
            }
            sqlstr = "select nvl(t.dept_id,''), nvl(t.brief_name,''), nvl(t.project_type,''),"
                    + " nvl(t.business_type,''), nvl(t.company_count,''), nvl(t.factory_count,''),"
                    + " nvl(t.build_year,''), nvl(t.stock_percent,''), nvl(t.register_capital,''),"
                    + " nvl(t.total_employee,''), nvl(t.leader_heads,''), nvl(t.manager_heads,''),"
                    + " nvl(t.worker_heads,''), nvl(t.actual_capacity,''), nvl(t.sign_capacity_water,''),"
                    + " nvl(t.sign_capacity_sewage,''),nvl(t.sign_capacity_reclaimed,''), nvl(t.sign_capacity_total,''),"
                    + " nvl(t.sign_capacity_sw,''), nvl(t.memo,'')"
                    + " from echarts.dm_op_company_basic_info t where 1=1";
            sqlstr = sqlstr + where + " order by t.dept_id";
            //System.out.println(sqlstr);
            rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            intRowCount = rs.getRow();//取总的记录数
            if (intRowCount > 0) {
                rs.absolute(1);
                int i = 0;
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("_parentId", rs.getString(1));
                    map.put("ID", rs.getString(1) + i);
                    map.put("dept_name", rs.getString(2));
                    map.put("project_type", rs.getString(3));
                    map.put("business_type", rs.getString(4));
                    map.put("company_count", rs.getString(5));
                    map.put("factory_count", rs.getString(6));
                    map.put("build_year", rs.getString(7));
                    map.put("stock_percent", rs.getString(8));
                    map.put("register_capital", rs.getString(9));
                    map.put("total_employee", rs.getString(10));
                    map.put("leader_heads", rs.getString(11));
                    map.put("manager_heads", rs.getString(12));
                    map.put("worker_heads", rs.getString(13));
                    map.put("actual_capacity", rs.getString(14));
                    map.put("sign_capacity_water", rs.getString(15));
                    map.put("sign_capacity_sewage", rs.getString(16));
                    map.put("sign_capacity_reclaimed", rs.getString(17));
                    map.put("sign_capacity_total", rs.getString(18));
                    map.put("sign_capacity_sw", rs.getString(19));
                    map.put("memo", rs.getString(20));
                    list_b.add(map);
                    i++;
                    rs.next();
                }
            }
            list.addAll(list_b);

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