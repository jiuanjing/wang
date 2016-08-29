<%
    /*********************************************************************************************************************
     *功能描述：从数据库中动态取得数据，并返回
     *编写人：cjl
     *编写时间：2016-2-25
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.google.gson.Gson,java.sql.ResultSet,java.text.DecimalFormat,java.util.ArrayList,java.util.HashMap,java.util.List,java.util.Map" %>
<%
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    //打开数据库链接
    if (db.dbOpen()) {
        try {
            String sqlstr = "";
            sqlstr = "select t.dept_id,d.dept_name,"
                    + "t.comp_count_subtotal,t.comp_count_all_bu,"
                    + "t.comp_count_w_s,t.comp_count_s_r,"
                    + "t.COMP_COUNT_S_SW,t.COMP_COUNT_w,t.COMP_COUNT_s,"
                    + "t.COMP_COUNT_r,t.COMP_COUNT_sw,"
                    + "t.FACTORY_COUNT_SUBTOTAL,t.FACTORY_COUNT_W,"
                    + "t.FACTORY_COUNT_S,t.FACTORY_COUNT_R,"
                    + "t.FACTORY_COUNT_SW,t.REGISTER_CAPITAL,"
                    + "t.EMPLOYEE_HEADS,t.CAPABILITY_W,"
                    + "t.CAPABILITY_S,t.CAPABILITY_R,"
                    + "t.CAPABILITY_TOTAL,t.CAPABILITY_SW "
                    + "from echarts.dm_op_cw_basic_analysis t, echarts.dim_dept_op d "
                    + "where t.dept_id = d.dept_id";
            String where = "";
            sqlstr = sqlstr + where + " order by d.order_no";

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
            List<Map<String, Object>> list_footer = new ArrayList<Map<String, Object>>();
            String dept_name = "合计";
            Double comp_count_subtotal = 0D;
            Double comp_count_all_bu = 0D;
            Double comp_count_w_s = 0D;
            Double comp_count_s_r = 0D;
            Double comp_count_s_sw = 0D;
            Double comp_count_w = 0D;
            Double comp_count_s = 0D;
            Double comp_count_r = 0D;
            Double comp_count_sw = 0D;
            Double factory_count_subtotal = 0D;
            Double factory_count_w = 0D;
            Double factory_count_s = 0D;
            Double factory_count_r = 0D;
            Double factory_count_sw = 0D;
            Double register_capital = 0D;
            Double employee_heads = 0D;
            Double capability_w = 0D;
            Double capability_s = 0D;
            Double capability_r = 0D;
            Double capability_total = 0D;
            Double capability_sw = 0D;
            //拼返回串
            String str_return = "";
            if (intRowCount > 0) {
                rs.absolute(1);
                while (!rs.isAfterLast()) {
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("dept_name", rs.getString(2));
                    map.put("comp_count_subtotal", rs.getString(3));
                    map.put("comp_count_all_bu", rs.getString(4));
                    map.put("comp_count_w_s", rs.getString(5));
                    map.put("comp_count_s_r", rs.getString(6));
                    map.put("comp_count_s_sw", rs.getString(7));
                    map.put("comp_count_w", rs.getString(8));
                    map.put("comp_count_s", rs.getString(9));
                    map.put("comp_count_r", rs.getString(10));
                    map.put("comp_count_sw", rs.getString(11));
                    map.put("factory_count_subtotal", rs.getString(12));
                    map.put("factory_count_w", rs.getString(13));
                    map.put("factory_count_s", rs.getString(14));
                    map.put("factory_count_r", rs.getString(15));
                    map.put("factory_count_sw", rs.getString(16));
                    map.put("register_capital", rs.getString(17));
                    map.put("employee_heads", rs.getString(18));
                    map.put("capability_w", rs.getString(19));
                    map.put("capability_s", rs.getString(20));
                    map.put("capability_r", rs.getString(21));
                    map.put("capability_total", rs.getString(22));
                    map.put("capability_sw", rs.getString(23));

                    dept_name = "合计";
                    comp_count_subtotal += Double.parseDouble(rs.getString(3));
                    comp_count_all_bu += Double.parseDouble(rs.getString(4));
                    comp_count_w_s += Double.parseDouble(rs.getString(5));
                    comp_count_s_r += Double.parseDouble(rs.getString(6));
                    comp_count_s_sw += Double.parseDouble(rs.getString(7));
                    comp_count_w += Double.parseDouble(rs.getString(8));
                    comp_count_s += Double.parseDouble(rs.getString(9));
                    comp_count_r += Double.parseDouble(rs.getString(10));
                    comp_count_sw += Double.parseDouble(rs.getString(11));
                    factory_count_subtotal += Double.parseDouble(rs.getString(12));
                    factory_count_w += Double.parseDouble(rs.getString(13));
                    factory_count_s += Double.parseDouble(rs.getString(14));
                    factory_count_r += Double.parseDouble(rs.getString(15));
                    factory_count_sw += Double.parseDouble(rs.getString(16));
                    register_capital += Double.parseDouble(rs.getString(17));
                    employee_heads += Double.parseDouble(rs.getString(18));
                    capability_w += Double.parseDouble(rs.getString(19));
                    capability_s += Double.parseDouble(rs.getString(20));
                    capability_r += Double.parseDouble(rs.getString(21));
                    capability_total += Double.parseDouble(rs.getString(22));
                    capability_sw += Double.parseDouble(rs.getString(23));

                    list.add(map);
                    rs.next();
                }
            }
            DecimalFormat df = new DecimalFormat("#######.##");
            Map<String, Object> map_footer = new HashMap<String, Object>();
            map_footer.put("dept_name", dept_name);
            map_footer.put("comp_count_subtotal", df.format(comp_count_subtotal));
            map_footer.put("comp_count_all_bu", df.format(comp_count_all_bu));
            map_footer.put("comp_count_w_s", df.format(comp_count_w_s));
            map_footer.put("comp_count_s_r", df.format(comp_count_s_r));
            map_footer.put("comp_count_s_sw", df.format(comp_count_s_sw));
            map_footer.put("comp_count_w", df.format(comp_count_w));
            map_footer.put("comp_count_s", df.format(comp_count_s));
            map_footer.put("comp_count_r", df.format(comp_count_r));
            map_footer.put("comp_count_sw", df.format(comp_count_sw));
            map_footer.put("factory_count_subtotal", df.format(factory_count_subtotal));
            map_footer.put("factory_count_w", df.format(factory_count_w));
            map_footer.put("factory_count_s", df.format(factory_count_s));
            map_footer.put("factory_count_r", df.format(factory_count_r));
            map_footer.put("factory_count_sw", df.format(factory_count_sw));
            map_footer.put("register_capital", df.format(register_capital));
            map_footer.put("employee_heads", df.format(employee_heads));
            map_footer.put("capability_w", df.format(capability_w));
            map_footer.put("capability_s", df.format(capability_s));
            map_footer.put("capability_r", df.format(capability_r));
            map_footer.put("capability_total", df.format(capability_total));
            map_footer.put("capability_sw", df.format(capability_sw));
            list.add(map_footer);

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