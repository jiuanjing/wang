<%
    /*********************************************************************************************************************
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
            String company_name = request.getParameter("company_name").trim();
            String order = request.getParameter("order");
            String sort = request.getParameter("sort");
            //当前页
            int pageNum = Integer.valueOf(request.getParameter("page"));
            //每页显示数
            int rows = Integer.valueOf(request.getParameter("rows"));

            sqlstr = "select t.company_id,t.company_code,t.company_name,t.brief_name,b.bu_name,"
                    + " d.brief_name,r.brief_name,t.company_level,c.brief_name,t.status,t.order_no,"
                    + " t.nc_code,t.leaf_flag,t.cw_stock_percent"
                    + " from echarts.dim_company_fn t"
                    + " left join echarts.dim_bu b on t.bu_id = b.bu_id"
                    + " left join echarts.dim_dept d on t.dept_id = d.dept_id"
                    + " left join echarts.dim_region r on t.region_id = r.region_id"
                    + " left join echarts.dim_company_fn c on t.uplevel_id = c.company_id";

            String where = "";
            if (company_name != null && !(company_name.equals(""))) {
                String name = new String(company_name.getBytes("ISO8859-1"), "UTF-8");
                where += " where t.company_name like '%" + name + "%'";
            }
            sqlstr = sqlstr + where + " order by t." + sort + " " + order;

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
                int absPage = (pageNum - 1) * rows + 1;
                rs.absolute(absPage);
                int absRows = 0;
                for (int i = 0; i < rows; i++) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("company_id", rs.getString(1));
                    map.put("company_code", rs.getString(2));
                    map.put("company_name", rs.getString(3));
                    map.put("brief_name", rs.getString(4));
                    map.put("bu_name", rs.getString(5));
                    map.put("dept_name", rs.getString(6));
                    map.put("region_name", rs.getString(7));
                    map.put("company_level", rs.getString(8));
                    map.put("uplevel_name", rs.getString(9));
                    map.put("status", rs.getString(10));
                    map.put("order_no", rs.getString(11));
                    map.put("cw_stock_percent", rs.getString(14));
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