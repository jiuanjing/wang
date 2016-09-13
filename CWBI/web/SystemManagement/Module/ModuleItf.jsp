<%
    /*********************************************************************************************************************
     *程序名称：ModuleItf.jsp
     *功能描述：显示模块内容的界面程序，如果传入一个模块的编号则显示该模块的具体内容，否则显示新增界面
     *编写人：万怀
     *编写时间：2014-09-02
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.bws.util.ModuleObj" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%
    //检查用户权限
    /*****
     if(CheckUserRight.check(userInfo,"107","1",pageContext) == false)
     {
     return ;
     }//检查用户权限代码结束
     ******/

    ModuleObj Obj = new ModuleObj();
    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    String ModuleID = "";
    ModuleID = request.getParameter("ModuleID");

    String positionStr = "模块信息注册";//当前位置
    String programName = "新增/修改模块注册信息";//当前功能名称

    String type = "insert";//操作类型
    String butName = "保存";//操作名称
    if (db.dbOpen()) {
        try {
            //positionStr=PositionUtil.getPosition("107",db);//根据功能编号，取当前页面所在位置
            //programName=PositionUtil.getProgramName("107",db);

            //如果程序接收到一个客户服务方式型的编号，则取该专卖许可证类型的详细信息
            if ((ModuleID != null && ModuleID != "")) {
                Obj.Load(ModuleID, db);
                type = "update";//有编号，则执行修改
                butName = "修改";
            }

        } catch (Exception e) {
            throw e;
        } finally {
            db.dbClose();
        }

    } else//如果无法与数据库建立链接
    {
        throw new Exception("对不起！系统无法与数据库建立链接，请稍后再试或与系统管理员联系！");
    }
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

            f2.action = "ModuleCtl.jsp?type=" + str;
            f2.submit();
        }


    </script>
</head>
<body bgcolor="#FFFFFF" background="../../images/back.jpg" leftmargin="0" topmargin="0" marginwidth="0"
      marginheight="0">
<form method="post" name="f2" action="ModuleCtl.jsp">
    <input type="hidden" name="ModuleID" size="11" value="<%=Obj.getModuleID() %>">
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
                                <td align=right>
                                    <table id="table4" class="tab3" width="87%">
                                        <tr>
                                            <td height="40">
                                                <table width="100%" height="25" border="0" cellpadding="0"
                                                       cellspacing="0">
                                                    <tr>
                                                        <td width="250" height="25" valign="middle"
                                                            background="../../images/back2.gif">
                                                            <table width="251" height="20" border="0" cellpadding="0"
                                                                   cellspacing="0">
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
                                                                name="Submit22" type="button" class="button" value="重置"
                                                                onclick="f2.reset();"><%
                                                            if (type.equals("update"))//如果新增界面，则不显示删除和新建按钮
                                                            {
                                                        %><input name="addNew" type="button" class="button" value="新建"
                                                                 onclick="self.location='ModuleItf.jsp'"><input
                                                                name="del" type="button" class="button" value="删除"
                                                                onclick="sendReq('delete')"><%
                                                            }
                                                        %><INPUT class="button"
                                                                 onclick="window.location.reload();"
                                                                 type=button value=刷新 name=refesh><input name="back_but"
                                                                                                         type="button"
                                                                                                         class="button"
                                                                                                         value="返回"
                                                                                                         onclick="self.location='ModuleList.jsp';">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        <tr>
                                            <td>
                                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td width="13%" align="right" height="30">模块编号：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="ModuleCode" size="50"
                                                                   value="<%=Obj.getModuleCode() %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">模块名称：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="ModuleName" size="50"
                                                                   value="<%=Obj.getModuleName() %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">URL：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="URL" size="50"
                                                                   value="<%=Obj.getURL() %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">访问方式：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="AccessMethod" size="50"
                                                                   value="<%=Obj.getAccessMethod() %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">模块级别：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="ModuleLevel" size="50"
                                                                   value="<%=Obj.getModuleLevel() %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">排序号：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="OrderNO" size="50"
                                                                   value="<%=Obj.getOrderNO() %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">状态：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="Status" size="50"
                                                                   value="<%=Obj.getStatus() %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">帮助URL：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="HelpURL" size="50"
                                                                   value="<%=Obj.getHelpURL() %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">红宝书：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="AddValueURL" size="50"
                                                                   value="<%=Obj.getAddValueURL() %>">
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
