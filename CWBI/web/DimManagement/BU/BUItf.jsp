<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,java.sql.ResultSet" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%
    //检查用户权限
    /*****
     if(CheckUserRight.check(userInfo,"107","1",pageContext) == false)
     {
     return ;
     }//检查用户权限代码结束
     ******/
    String bu_id = "";
    String bu_code = "";
    String bu_name = "";
    String bu_level = "";
    String status = "";
    String order_no = "";
    String uplevel_id = "";

    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    bu_id = request.getParameter("bu_id");

    String positionStr = "板块信息维护";//当前位置
    String programName = "新增/修改板块信息";//当前功能名称

    String type = "insert";//操作类型
    String butName = "保存";//操作名称
    if (db.dbOpen()) {
        try {

            String sqlstr = "";
            if ((bu_id != null && bu_id != "")) {
                sqlstr = "select t.bu_id,t.bu_code,t.bu_name,t.bu_level,t.status,t.order_no,t.uplevel_id from echarts.dim_bu t";
                sqlstr += " where t.bu_id = " + bu_id;
                ResultSet rs = null;
                rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集

                if (rs == null) {
                    throw new Exception("对不起！系统在查询数据库时出错");
                }

                rs.last();//定位到最后一条记录
                int intRowCount = rs.getRow();//取总的记录数

                if (intRowCount > 0) {
                    rs.absolute(1);
                    while (!rs.isAfterLast()) {
                        bu_id = rs.getString(1);
                        bu_code = rs.getString(2);
                        bu_name = rs.getString(3);
                        bu_level = rs.getString(4);
                        status = rs.getString(5);
                        order_no = rs.getString(6);
                        uplevel_id = rs.getString(7);
                        rs.next();
                    }
                }
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
    <title>板块信息维护</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Expires" content="0">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-control" content="no-cache">
    <meta http-equiv="Cache" content="no-cache">
    <link href="../../css/style1.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../../scripts/jquery-1.6.min.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript">
        $(function () {
            var uplevel_id = "<%=uplevel_id %>";
            $.ajax({
                url: "DoGetBUSelect.jsp",
                dataType: "text", //传参的数据类型
                type: "post", //传参方式，get 或post
                data: {
                    uplevel_id: uplevel_id
                },
                error: function (msg) { //若Ajax处理失败后返回的信息
                    alert("Ajax获取数据失败");
                },
                success: function (return_data) { //若Ajax处理成功后返回的信息
                    $("#bu_uplevel").html(return_data);
                }
            });
        });
        function sendReq(str) {
            if (str == "delete") {
                if (!confirm("您是否确认要执行删除操作！")) {
                    return;
                }
                f2.type.value = "delete";
                f2.selectedIds.value = "<%=bu_id %>";
            }
            f2.submit();
        }


    </script>
</head>
<body bgcolor="#FFFFFF" background="../../images/back.jpg" leftmargin="0" topmargin="0" marginwidth="0"
      marginheight="0">
<form method="post" name="f2" action="BUCtl.jsp">
    <input type="hidden" name="bu_id" size="11" value="<%=bu_id %>">
    <input type="hidden" name="type" size="20" value="<%=type %>">
    <input type="hidden" name="selectedIds" size="20" value="">
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
                                                            <input type="button" class="button" value="<%=butName%>"
                                                                   onclick="javascript:sendReq('<%=type%>')"><input
                                                                type="button" class="button" value="重置"
                                                                onclick="javascript:f2.reset();">
                                                            <%
                                                                if (type.equals("update")) {//如果新增界面，则不显示删除和新建按钮
                                                            %>
                                                            <input name="addNew" type="button" class="button" value="新建"
                                                                   onclick="javascript:self.location='BUItf.jsp'"><input
                                                                name="del" type="button" class="button" value="删除"
                                                                onclick="javascript:sendReq('delete')">
                                                            <%
                                                                }
                                                            %>
                                                            <INPUT class="button"
                                                                   onclick="javascript:window.location.reload();"
                                                                   type=button value=刷新 name=refesh><input
                                                                name="back_but" type="button" class="button" value="返回"
                                                                onclick="javascript:self.location='BUList.jsp';">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        <tr>
                                            <td>
                                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td width="13%" align="right" height="30">板块编号：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="bu_code" size="50"
                                                                   value="<%=bu_code %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">板块名称：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="bu_name" size="50"
                                                                   value="<%=bu_name %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">板块级别：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="bu_level" size="50"
                                                                   value="<%=bu_level %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">板块状态：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="status" size="50"
                                                                   value="<%=status %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">排序号：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="order_no" size="50"
                                                                   value="<%=order_no %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">上级板块：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <div id="bu_uplevel"></div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
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
