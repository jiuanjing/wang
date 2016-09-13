<%
    /**************************************************************************************************************
     *程序名称：RoleModuleSave.jsp
     *功能说明：该程序接收RoleModuleList.jsp的请求，完成角色授权信息的保存
     *编写人：万怀
     *编写时间：2014-09-22
     **************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,java.util.Vector" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>

<HTML>
<HEAD><TITLE>模块信息维护</TITLE>
</HEAD>
<BODY>
<%
    //检查用户权限
    /*****
     if(CheckUserRight.check(userInfo,"107","2",pageContext) == false)
     {
     return ;
     }//检查用户权限代码结束
     *****/
    String str_test = "";
    String selectedIds = "";
    selectedIds = request.getParameter("selectedIds");
    String unselectedIds = "";
    unselectedIds = request.getParameter("unselectedIds");
    String RoleID = "";
    RoleID = request.getParameter("RoleID");
    DBOperation db = new DBOperation(false);
    String str_maxID = "";
    int maxID = 0;
    Vector<Vector<String>> v1 = null;
    Vector<Vector<String>> v2 = null;
    String sql_select = "";
    String str_row_count = "";

    if (db.dbOpen()) {
        try {
            v1 = db.executeQueryVt("select nvl(max(role_module_id),0) from bim.role_module");
            str_maxID = v1.elementAt(0).elementAt(0).toString();
            maxID = Integer.parseInt(str_maxID);
            str_test = str_test + "maxID=" + maxID;
            v1 = null;

            String[] str_have_right = selectedIds.split(",");
            String[] str_no_right = unselectedIds.split(",");

            if (str_have_right.length > 0) {
                for (int i = 0; i < str_have_right.length; i++) {
                    String ModuleID = str_have_right[i];
                    String sql_insert = "";
                    String sql_update = "";
                    //str_test = str_test + "str_have_right[" + i + "]:" + str_have_right[i] + "    ";
                    if (!ModuleID.equals("")) {
                        sql_select = "select count(*) from bim.role_module where role_id=" + RoleID + " and module_id=" + ModuleID;
                        v2 = db.executeQueryVt(sql_select);
                        str_row_count = v2.elementAt(0).elementAt(0).toString();
                        str_test = str_test + "  str_have_right[" + i + "]:ModuleID=" + ModuleID + "记录条数： " + str_row_count;
                        v2 = null;
                        if (str_row_count.equals("0")) {
                            maxID = maxID + 1;
                            sql_insert = "insert into bim.role_module(role_module_id,role_id,module_id,right_type) values(" + maxID + "," + RoleID + "," + ModuleID + ",1)";
                            db.executeUpdate(sql_insert);
                        } else {
                            sql_update = "update bim.role_module set right_type=1 where role_id=" + RoleID + " and module_id=" + ModuleID;
                            db.executeUpdate(sql_update);
                        }
                    }
                }
            }

            String sql_update_no_right = "delete bim.role_module where role_id=" + RoleID + " and module_id in(" + unselectedIds + ")";
            db.executeUpdate(sql_update_no_right);

            db.executeCommit();
            //db.dbClose();
%>
<script>
    alert("您好，授权信息修改成功！");
    self.location = "RoleModuleList.jsp?RoleID=" +;
    <%=RoleID %>
</script>
<%
} catch (Exception e) {
    db.executeRollback();
%>
<script>
    alert("对不起！系统在保存数据时出错，请仔细检查后重新操作！");
    window.history.back();
</script>
<%
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
%>
</BODY>
</HTML>