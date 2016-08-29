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
    String company_id = "";
    String company_code = "";
    String company_name = "";
    String brief_name = "";
    String bu_id = "";
    String dept_id = "";
    String region_id = "";
    String company_level = "";
    String uplevel_id = "";
    String status = "";
    String order_no = "";
    String nc_code = "";
    String leaf_flag = "";
    String cw_stock_percent = "";

    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    company_id = request.getParameter("company_id");

    String positionStr = "公司信息维护";//当前位置
    String programName = "新增/修改公司信息";//当前功能名称

    String type = "insert";//操作类型
    String butName = "保存";//操作名称
    if (db.dbOpen()) {
        try {

            String sqlstr = "";
            if ((company_id != null && company_id != "")) {
                sqlstr = "select t.company_id,t.company_code,t.company_name,t.brief_name,t.BU_ID,t.DEPT_ID,t.REGION_ID,t.company_level,t.status,t.order_no,t.uplevel_id,t.NC_CODE,t.LEAF_FLAG,t.CW_STOCK_PERCENT from echarts.dim_company_fn t";
                sqlstr += " where t.company_id = " + company_id;
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
                        company_id = rs.getString(1);
                        company_code = rs.getString(2);
                        company_name = rs.getString(3);
                        brief_name = rs.getString(4);
                        bu_id = rs.getString(5);
                        dept_id = rs.getString(6);
                        region_id = rs.getString(7);
                        company_level = rs.getString(8);
                        status = rs.getString(9);
                        order_no = rs.getString(10);
                        uplevel_id = rs.getString(11);
                        nc_code = rs.getString(12);
                        leaf_flag = rs.getString(13);
                        cw_stock_percent = rs.getString(14);
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
    <title>公司信息维护</title>
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
            var bu_id = "<%=bu_id %>";
            var dept_id = "<%=dept_id %>";
            var region_id = "<%=region_id %>";
            $.ajax({
                url: "DoGetCompanyUplevel.jsp",
                dataType: "text", //传参的数据类型
                type: "post", //传参方式，get 或post
                data: {
                    uplevel_id: uplevel_id
                },
                error: function (msg) { //若Ajax处理失败后返回的信息
                    alert("Ajax获取数据失败");
                },
                success: function (return_data) { //若Ajax处理成功后返回的信息
                    $("#company_uplevel").html(return_data);
                }
            });
            $.ajax({
                url: "DoGetCompanyBU.jsp",
                dataType: "text", //传参的数据类型
                type: "post", //传参方式，get 或post
                data: {
                    bu_id: bu_id
                },
                error: function (msg) { //若Ajax处理失败后返回的信息
                    alert("Ajax获取数据失败");
                },
                success: function (return_data) { //若Ajax处理成功后返回的信息
                    $("#company_bu").html(return_data);
                }
            });
            $.ajax({
                url: "DoGetCompanyDept.jsp",
                dataType: "text", //传参的数据类型
                type: "post", //传参方式，get 或post
                data: {
                    dept_id: dept_id
                },
                error: function (msg) { //若Ajax处理失败后返回的信息
                    alert("Ajax获取数据失败");
                },
                success: function (return_data) { //若Ajax处理成功后返回的信息
                    $("#company_dept").html(return_data);
                }
            });
            $.ajax({
                url: "DoGetCompanyRegion.jsp",
                dataType: "text", //传参的数据类型
                type: "post", //传参方式，get 或post
                data: {
                    region_id: region_id
                },
                error: function (msg) { //若Ajax处理失败后返回的信息
                    alert("Ajax获取数据失败");
                },
                success: function (return_data) { //若Ajax处理成功后返回的信息
                    $("#company_region").html(return_data);
                }
            });

        });
        function sendReq(str) {
            if (str == "delete") {
                if (!confirm("您是否确认要执行删除操作！")) {
                    return;
                }
                f2.type.value = "delete";
                f2.selectedIds.value = "<%=company_id %>";
            }
            f2.submit();
        }


    </script>
</head>
<body bgcolor="#FFFFFF" background="../../images/back.jpg" leftmargin="0" topmargin="0" marginwidth="0"
      marginheight="0">
<form method="post" name="f2" action="CompanyCtl.jsp">
    <input type="hidden" name="company_id" size="11" value="<%=company_id %>">
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
                                                                   onclick="javascript:self.location='CompanyItf.jsp'"><input
                                                                name="del" type="button" class="button" value="删除"
                                                                onclick="javascript:sendReq('delete')">
                                                            <%
                                                                }
                                                            %>
                                                            <INPUT class="button"
                                                                   onclick="javascript:window.location.reload();"
                                                                   type=button value=刷新 name=refesh><input
                                                                name="back_but" type="button" class="button" value="返回"
                                                                onclick="javascript:self.location='CompanyList.jsp';">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        <tr>
                                            <td>
                                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td width="13%" align="right" height="30">公司编号：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="company_code" size="50"
                                                                   value="<%=company_code %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">公司名称：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="company_name" size="50"
                                                                   value="<%=company_name %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">公司简称：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="brief_name" size="50"
                                                                   value="<%=brief_name %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">公司级别：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="company_level" size="50"
                                                                   value="<%=company_level %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">公司状态：</td>
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
                                                        <td width="13%" align="right" height="30">上级公司：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <div id="company_uplevel"></div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">所属板块：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <div id="company_bu"></div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">所属部门：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <div id="company_dept"></div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">所属区域：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <div id="company_region"></div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">NC系统编号：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="nc_code" size="50"
                                                                   value="<%=nc_code %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">页级标志：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="leaf_flag" size="50"
                                                                   value="<%=leaf_flag %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="13%" align="right" height="30">所占股比：</td>
                                                        <td width="32%" align="left" height="30">
                                                            <input type="text" name="cw_stock_percent" size="50"
                                                                   value="<%=cw_stock_percent %>">
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
