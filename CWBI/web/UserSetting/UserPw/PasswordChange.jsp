<%
    /*********************************************************************************************************************
     *程序名称：UserItf.jsp
     *功能描述：显示用户信息的界面程序，如果传入一个用户的账号则显示该用户信息的具体内容，否则显示新增界面
     *编写人：万怀
     *编写时间：2014-09-12
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%
    //检查用户权限
    /*****
     if(CheckUserRight.check(userInfo,"107","1",pageContext) == false)
     {
     return ;
     }//检查用户权限代码结束
     ******/

    String positionStr = "密码修改";//当前位置
    String programName = "Ukey密码修改";//当前功能名称
%>
<html>
<head>
    <title>Ukey密码修改</title>
    <link href="../../css/style1.css" rel="stylesheet" type="text/css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="../../scripts/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="../../scripts/jquery.easyui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../../scripts/easyui-1.3.6/themes/pepper-grinder/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../scripts/easyui-1.3.6/themes/icon.css">
    <script type="text/javascript" src="../../scripts/login/auth.js"></script>
    <script type="text/javascript">

    </script>
</head>
<body bgcolor="#FFFFFF" background="../../images/back.jpg" leftmargin="0" topmargin="0" marginwidth="0"
      marginheight="0">
<form method="post" name="f2">
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
                                                                       value="确定" onclick="changeKeyPIN();"><input
                                                                    name="Submit22" type="button" class="button"
                                                                    value="重置" onclick="f2.reset();">
                                                                <input class="button"
                                                                       onclick="window.location.reload();"
                                                                       type=button value=刷新 name=refesh><input
                                                                    name="back_but" type="button" class="button"
                                                                    value="返回"
                                                                    onclick="self.location='PasswordChange.jsp';">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            <tr>
                                                <td>
                                                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                        <tr>
                                                            <td width="13%" align="right" height="30">旧密码：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="password" name="KeyPIN_OLD" size="50">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">新密码：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="password" name="KeyPIN_NEW1" size="50"
                                                                       placeholder="不少于6位，最多16位">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="13%" align="right" height="30">重复新密码：</td>
                                                            <td width="32%" align="left" height="30">
                                                                <input type="password" name="KeyPIN_NEW2" size="50">
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
<OBJECT CLASSID="CLSID:F83A15A2-BAD8-465E-85C4-74ACB165924C" ID="SafeCtrl" onerror="SafeCtrlCOMErrorTrap();"></OBJECT>
</html>