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
    UserID = Integer.toString(userInfo.getUserID());

    String positionStr = "个人信息修改";//当前位置
    String programName = "个人信息修改";//当前功能名称

    String type = "";//操作类型
    String butName = "";//操作名称

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
%>
<html>
<head>
    <title>个人信息修改</title>
    <link href="../../css/style1.css" rel="stylesheet" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript">
        function sendReq(str) {

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
    <input type="hidden" name="UserAccount" size="50" value="<%=userObj.getUserAccount() %>">
    <input type="hidden" name="UserPassword" size="50" value="<%=userObj.getUserPassword() %>">
    <input type="hidden" name="Status" size="50" value="<%=userObj.getStatus() %>">
    <input type="hidden" name="PageSize" size="50" value="<%=userObj.getPageSize() %>">
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
                                                                       onclick="sendReq('<%=type%>')"><input
                                                                    name="Submit22" type="button" class="button"
                                                                    value="重置" onclick="f2.reset();">
                                                                <input class="button"
                                                                       onclick="window.location.reload();"
                                                                       type=button value=刷新 name=refesh><input
                                                                    name="back_but" type="button" class="button"
                                                                    value="返回"
                                                                    onclick="self.location='UserInfoChange.jsp';">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            <tr>
                                                <td>
                                                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                        <tr>
                                                            <td width="13%" align="right" height="30">姓名：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="UserName" size="50"
                                                                       value="<%=userObj.getUserName() %>"
                                                                       readonly="readonly">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">所属单位：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" size="50"
                                                                       value="<%=companyObj.getCompanyName() %>"
                                                                       readonly="readonly">
                                                                <input type="hidden" name="CompanyID" size="50"
                                                                       value="<%=userObj.getCompanyID() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">所属部门：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" size="50"
                                                                       value="<%=deptObj.getDeptName() %>"
                                                                       readonly="readonly">
                                                                <input type="hidden" name="DeptID" size="50"
                                                                       value="<%=userObj.getDeptID() %>">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">职位：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" name="Position" size="50"
                                                                       value="<%=userObj.getPosition() %>"
                                                                       readonly="readonly">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">角色：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="text" size="50"
                                                                       value="<%=roleObj.getRoleName() %>"
                                                                       readonly="readonly">
                                                                <input type="hidden" name="RoleID" size="50"
                                                                       value="<%=userObj.getRoleID() %>">
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
        } catch (Exception e) {
            throw e;
        } finally {
            db.dbClose();
        }
    } else {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
%>
