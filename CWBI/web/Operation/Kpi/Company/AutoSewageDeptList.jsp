<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     *编写时间：2016-2-25
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Map" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            //查询用户所在大区
            //用户dept_id对应DEPARTMENT表，在查出dept_id_op则是对应数据dim_op_dept表id，根据此ID过滤大区数据
            int dept_id = userInfo.getDeptID();
            String sql4dept = "select a.dept_id_op from bim.department a where a.dept_id = " + dept_id;
            ResultSet rs = null;
            rs = db.executeQuery(sql4dept);
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            //当前用户对应的部门ID
            int deptId = 0;
            rs.last();//定位到最后一条记录
            int intRowCount0 = rs.getRow();//取总的记录数
            if (intRowCount0 > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    deptId = rs.getInt(1);
                    rs.next();
                }
            }
            String DeptID = request.getParameter("DeptID");
            String where = "";
            if ("".equals(DeptID) || DeptID == null) {
                //
            } else {
                where += " and t.dept_id = " + DeptID;
            }
            String sqlstr = "";
            if (deptId > 0) {
                sqlstr = "select t.dept_id,t.dept_name from echarts.dim_dept_op t where t.dept_id = " + deptId + " and t.status = 1 order by t.dept_id";
            } else {
                sqlstr = "select t.dept_id,t.dept_name from echarts.dim_dept_op t where t.status = 1 order by t.dept_id";
            }
            //System.out.println(sqlstr);
            rs = null;
            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集
            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }
            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数
            Gson gson = new Gson();
            //Map<String,Object> mapAll = new HashMap<String,Object>();
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> list_b = new ArrayList<Map<String, Object>>();
            //拼返回串
            String str_return = "";
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("id", rs.getString(1));
                    map.put("text", rs.getString(2));
                    map.put("children", "");
                    list.add(map);
                    rs.next();
                }
            }
            sqlstr = "select t.dept_id,t.company_id,t.company_name from echarts.dim_op_company t where t.flag_sewage = 1 and t.status = 1 order by t.dept_id";
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
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("pid", rs.getString(1));
                    map.put("id", rs.getString(2));
                    map.put("text", rs.getString(3));
                    list_b.add(map);
                    rs.next();
                }
            }
            for (int i = 0; i < list.size(); i++) {
                String id = list.get(i).get("id").toString();
                List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
                for (int j = 0; j < list_b.size(); j++) {
                    String pid = list_b.get(j).get("pid").toString();
                    if (id.equals(pid)) {
                        children.add(list_b.get(j));
                    }
                }
                list.get(i).put("children", children);
            }
            str_return = gson.toJson(list);
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