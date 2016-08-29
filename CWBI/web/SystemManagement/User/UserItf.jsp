<%
    /*********************************************************************************************************************
     *程序名称：UserItf.jsp
     *功能描述：显示用户信息的界面程序，如果传入一个用户的账号则显示该用户信息的具体内容，否则显示新增界面
     *编写人：万怀
     *编写时间：2014-09-12
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.bws.util.CompanyObj,com.bws.util.DepartmentObj" %>
<%@ page import="com.bws.util.RoleObj" %>
<%@ page import="com.bws.util.UserObj" %>
<%@ page import="java.sql.ResultSet" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%
    //检查用户权限
    /*****
     if(CheckUserRight.check(userInfo,"107","1",pageContext) == false)
     {
     return ;
     }//检查用户权限代码结束
     ******/

    UserObj userObj = new UserObj();
    CompanyObj companyObj = new CompanyObj();
    DepartmentObj deptObj = new DepartmentObj();
    RoleObj roleObj = new RoleObj();
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    String UserID = "";
    UserID = request.getParameter("UserID");

    String positionStr = "用户信息管理";//当前位置
    String programName = "新增/修改用户信息";//当前功能名称

    String type = "insert";//操作类型
    String butName = "保存";//操作名称

    String sqlstr_company = "select company_id,company_name from odccbim.company order by order_no";
    String sqlstr_dept = "select dept_id,dept_name from odccbim.department order by order_no";
    String sqlstr_role = "select role_id,role_name from odccbim.role_info order by order_no";
    ResultSet rs_company = null;
    ResultSet rs_dept = null;
    ResultSet rs_role = null;

    if (db.dbOpen()) {
        try {
            //如果程序接收到一个客户服务方式型的编号，则取该专卖许可证类型的详细信息
            if ((UserID != null && UserID != "")) {
                userObj.Load(UserID, db);
                companyObj.Load(userObj.getCompanyID(), db);
                deptObj.Load(userObj.getDeptID(), db);
                roleObj.Load(userObj.getRoleID(), db);
                type = "update";//有编号，则执行修改
                butName = "修改";
            }
            rs_company = db.executeQuery(sqlstr_company);
            rs_dept = db.executeQuery(sqlstr_dept);
            rs_role = db.executeQuery(sqlstr_role);
%>
<html>
<head>
    <title>模块注册信息管理</title>
    <link href="../../css/style1.css" rel="stylesheet" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript">
        function sendReq(str) {
            if (str == "delete") {
                if (!confirm("您是否确认要执行删除操作！")) {
                    return;
                }
            }

            f2.action = "UserCtl.jsp?type=" + str;
            f2.submit();
        }


    </script>
</head>
<body bgcolor="#FFFFFF" background="../../images/back.jpg" leftmargin="0" topmargin="0" marginwidth="0"
      marginheight="0">
<form method="post" name="f2" action="UserCtl.jsp">
    <input type="hidden" name="UserID" size="11" value="<%=userObj.getUserID() %>">
    <input type="hidden" name="type" size="20" value="<%=type %>">
    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="18">&nbsp;</td>
        </tr>
        <tr>
            <td height="18"><span id="lbCurPos"
                                  class="lbl2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>>>>当前位置：<%=positionStr%></span></td>
        </tr>
        <tr>
            <td height="18"></td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="70%" align="left" valign="top">
                            <table id="table1" border="0" cellspacing="0" align="center" width="95%">
                                <tr>
                                    <td align=right>
                                        <table id="table4" class="tab3" width="87%">
                                            <tr>
                                                <td height="40">
                                                    <table width="100%" height="25" border="0" cellpadding="0"
                                                           cellspacing="0">
                                                        <tr>
                                                            <td width="250" height="25" valign="middle"
                                                                background="../../images/back2.gif">
                                                                <table width="251" height="20" border="0"
                                                                       cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="12%">&nbsp;</td>
                                                                        <td width="88%" valign="bottom"><%=programName%>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td height="21" align="right">
                                                                <input name="Submit4" type="button" class="button"
                                                                       value="<%=butName%>"
                                                                       onclick="javascript:sendReq('<%=type%>')"><input
                                                                    name="Submit22" type="button" class="button"
                                                                    value="重置" onclick="javascript:f2.reset();"><%
                                                                if (type.equals("update"))//如果新增界面，则不显示删除和新建按钮
                                                                {
                                                            %><input name="addNew" type="button" class="button"
                                                                     value="新建"
                                                                     onclick="javascript:self.location='UserItf.jsp'"><input
                                                                    name="del" type="button" class="button" value="删除"
                                                                    onclick="javascript:sendReq('delete')"><%
                                                                }
                                                            %><INPUT class="button"
                                                                     onclick="javascript:window.location.reload();"
                                                                     type=button value=刷新 name=refesh><input
                                                                    name="back_but" type="button" class="button"
                                                                    value="返回"
                                                                    onclick="javascript:self.location='UserList.jsp';">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            <tr>
                                                <td>
                                                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                        <tr>
                                                            <td width="13%" align="right" height="30">账号：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="UserAccount" size="50"
                                                                       value="<%=userObj.getUserAccount() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">密码：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="UserPassword" size="50"
                                                                       value="<%=userObj.getUserPassword() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">姓名：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="UserName" size="50"
                                                                       value="<%=userObj.getUserName() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">所属单位：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <select name="CompanyID" id="CompanyID"
                                                                        style="width:42.2%">
                                                                    <option value="<%=userObj.getCompanyID() %>"
                                                                            selected><%=companyObj.getCompanyName() %>
                                                                    </option>
                                                                    <%
                                                                        while (rs_company.next()) {
                                                                    %>
                                                                    <option value=<%=rs_company.getString(1) %>><%=rs_company.getString(2) %>
                                                                    </option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">所属部门：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <select name="DeptID" id="DeptID" style="width:42.2%">
                                                                    <option value="<%=userObj.getDeptID() %>"
                                                                            selected><%=deptObj.getDeptName() %>
                                                                    </option>
                                                                    <%
                                                                        while (rs_dept.next()) {
                                                                    %>
                                                                    <option value=<%=rs_dept.getString(1) %>><%=rs_dept.getString(2) %>
                                                                    </option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">职位：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="Position" size="50"
                                                                       value="<%=userObj.getPosition() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">角色：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <select name="RoleID" id="RoleID" style="width:42.2%">
                                                                    <option value="<%=userObj.getRoleID() %>"
                                                                            selected><%=roleObj.getRoleName() %>
                                                                    </option>
                                                                    <%
                                                                        while (rs_role.next()) {
                                                                    %>
                                                                    <option value=<%=rs_role.getString(1) %>><%=rs_role.getString(2) %>
                                                                    </option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">电子邮件：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="EMail" size="50"
                                                                       value="<%=userObj.getEMail() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">固定电话：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="Phone" size="50"
                                                                       value="<%=userObj.getPhone() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">手机号码：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="Mobile" size="50"
                                                                       value="<%=userObj.getMobile() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">状态：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="Status" size="50"
                                                                       value="<%=userObj.getStatus() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">每页行数：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="PageSize" size="50"
                                                                       value="<%=userObj.getPageSize() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">微信号：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="MicroMSG" size="50"
                                                                       value="<%=userObj.getMicroMSG() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">QQ号：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="QQNO" size="50"
                                                                       value="<%=userObj.getQQNO() %>">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
</body>
</html>

<%
            rs_company.close();
            rs_dept.close();
            rs_role.close();
        } catch (Exception e) {
            throw e;
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
%>
