<%
    /*********************************************************************************************************************
     *程序名称：RoleList.jsp
     *功能描述：以列表的形式显示当前所有的角色
     *编写人：万怀
     *编写时间：2014-09-17
     **********************************************************************************************************************/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="com.bws.dbOperation.DBOperation,com.bws.tools.ChStr,java.sql.ResultSet" %>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%
    //检查用户权限
    /****
     if(CheckUserRight.check(userInfo,"107","1",pageContext) == false)
     {
     return ;
     }//检查用户权限代码结束
     *****/
    int pageSize = 10;//取用户自定义的页面显示记录数
    if (request.getParameter("pageSize") != null)//取用户输入了的新的分页数
    {
        try {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        } catch (Exception e) {
            pageSize = 10;//如果用户输入的每页记录数不是数字，则将值设为：10
        }
    }

    int current_page = 1;//该变量是记录当前的页数
    if (request.getParameter("current_page") != null) {
        try {
            current_page = Integer.parseInt(request.getParameter("current_page"));
        } catch (Exception e) {
            current_page = 1;//如果取当前页的值不是数字，则显示第一页的信息
        }
    }

    int all_pages = 1;//该变量是记录当前的总页数

    //实例化数据库链接
    DBOperation db = new DBOperation(true);

    String positionStr = "角色信息管理";//当前位置
    String programName = "角色";//当前功能名称
    //打开数据库链接
    if (db.dbOpen()) {
        try {
            //positionStr=PositionUtil.getPosition("107",db);//根据功能编号，取当前页面所在位置
            //programName=PositionUtil.getProgramName("107",db);

            String sqlstr = "select role_id,role_name \"角色名称\",role_desc \"角色描述信息\",order_no \"排序号\" from bim.role_info";

            //取检索条件
            String where = "";

            if (request.getParameter("RoleName") != null && request.getParameter("RoleName").trim().length() > 0) {
                where = where + " where role_name like '%" + ChStr.chStr(request.getParameter("RoleName").trim()) + "%'";
            }
            sqlstr = sqlstr + where;//追加检索条件
            sqlstr = sqlstr + " order by order_no";

            ResultSet rs = null;

            rs = db.executeQuery(sqlstr);//通过数据库访问程序返回一个可滚动的记录集

            if (rs == null) {
                throw new Exception("对不起！系统在查询数据库时出错");
            }

            rs.last();//定位到最后一条记录
            int intRowCount = rs.getRow();//取总的记录数

            if (intRowCount % pageSize == 0) {
                all_pages = intRowCount / pageSize;
            } else {
                all_pages = intRowCount / pageSize + 1;
            }


            if (current_page < 1) {
                current_page = 1;
            }
            if (current_page > all_pages) {
                current_page = all_pages;
            }
            if (current_page < 1) {
                current_page = 1;
            }
            if (all_pages < 1) {
                all_pages = 1;
            }
%>
<html>
<head>
    <title>角色信息维护</title>
    <link href="../../css/style1.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../../js/function.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>
    function goPage(p) {
        tab_list.current_page.value = p;
        tab_list.action = "RoleList.jsp";
        tab_list.submit();
    }

    function next() {
        tab_list.current_page.value = parseInt(tab_list.current_page.value) + 1;
        tab_list.action = "RoleList.jsp";
        tab_list.submit();
    }

    function last() {
        tab_list.current_page.value = parseInt(tab_list.current_page.value) - 1;
        tab_list.action = "RoleList.jsp";
        tab_list.submit();
    }

    function allchecked(flag) {//全部选择
        if (window.tab_list.show_row.value != 1) {
            switch (flag) {
                case "0"://列表全选
                    if (tab_list.chkListSel_All.checked == true) {
                        tab_list.chkListSel_All.checked = true;
                        for (i = 0; i < window.tab_list.show_row.value; i++) {
                            window.tab_list.ids[i].checked = true;
                        }
                    }
                    else {
                        tab_list.chkListSel_All.checked = false;
                        for (i = 0; i < window.tab_list.show_row.value; i++) {
                            window.tab_list.ids[i].checked = false;
                        }
                    }
                    break;
                case "1"://按钮全选
                    if (tab_list.chkListSel_All.checked == false) {
                        tab_list.chkListSel_All.checked = true;
                        for (i = 0; i < window.tab_list.show_row.value; i++) {
                            window.tab_list.ids[i].checked = true;
                        }
                    }
                    else {
                        tab_list.chkListSel_All.checked = false;
                        for (i = 0; i < window.tab_list.show_row.value; i++) {
                            window.tab_list.ids[i].checked = false;
                        }
                    }
                    break;
            }
        } else {
            switch (flag) {
                case "0"://列表全选
                    if (tab_list.chkListSel_All.checked == true) {
                        tab_list.chkListSel_All.checked = true;
                        window.tab_list.ids.checked = true;
                    }
                    else {
                        tab_list.chkListSel_All.checked = false;
                        window.tab_list.ids.checked = false;
                    }
                    break;
                case "1"://按钮全选
                    if (tab_list.chkListSel_All.checked == false) {
                        tab_list.chkListSel_All.checked = true;
                        window.tab_list.ids.checked = true;
                    }
                    else {
                        tab_list.chkListSel_All.checked = false;
                        window.tab_list.ids.checked = false;
                    }
                    break;
            }
        }
    }
    function switchSysBar() {
        var SchFrm = null;
        SchFrm = document.all("frmTitle");
        if (SchFrm.style.display == "") {
            SchFrm.style.display = "none";
        }
        else {
            SchFrm.style.display = "";
        }
    }

    function clear_query()//该方法在修改时要求重写
    {
        tab_list.RoleName.value = "";
    }

    function deleteChoosedItems() {
        var primaryIDs = document.getElementsByName("ids");
        var ids_str = "";
        var ids_str2 = "";
        for (var i = 0; i < primaryIDs.length; i++) {
            if (primaryIDs[i].type == "checkbox" && primaryIDs[i].checked == true) {
                ids_str += primaryIDs[i].value + ",";
            }
        }
        ids_str2 = ids_str.substring(0, ids_str.length - 1);
        if (ids_str2 == "") {
            alert("请选择要删除的信息!");
            return;
        }
        else {
            confirm("真的要删除吗？");
        }
        document.getElementsByName("selectedIds")[0].value = ids_str2;
        document.getElementsByName("type")[0].value = "deleteChoosed";
        document.tab_list.action = "RoleCtl.jsp";
        document.tab_list.submit();
    }
</script>
<body bgcolor="#FFFFFF" background="../../images/back.jpg" leftmargin="0" topmargin="0" marginwidth="0"
      marginheight="0">
<table width="98%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="18">&nbsp;</td>
    </tr>
    <tr>
        <td height="18"><span id="lbCurPos"
                              class="lbl2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>>>>当前位置：<%=positionStr%></span>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="94%" align="left" valign="top">
                        <table id="table1" border="0" cellspacing="0" align="center" width="95%">
                            <tr>
                                <td height="2">&nbsp; </td>
                            </tr>
                            <tr>
                                <td>
                                    <form name="tab_list" method="POST" action="RoleList.jsp">
                                        <input type="hidden" name="current_page" value="<%=current_page%>">
                                        <input type="hidden" name="all_pages" value="<%=all_pages%>">
                                        <input type="hidden" name="selectedIds" value="">
                                        <input type="hidden" name="type" value="">
                                        <table id="Table2" class="tab1">
                                            <tr>
                                                <td colspan="8">
                                                    <div id="frmTitle" style="display:none">
                                                        <table id="t1" class="tab1" width="100%">
                                                            <tr>
                                                                <td>请输入检索条件:</td>
                                                            </tr>
                                                            <tr>
                                                                <td>角色名称：<input name="RoleName" type="text" size=12
                                                                                value=""/>
                                                                    <input type="submit" name="btnSearch" value="确定"
                                                                           id="btnSearch2" class="button"/>
                                                                    <input type="button" name="resetok" value="清空"
                                                                           onclick="clear_query()" class="button"/>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">
                                                    <table width="100%" height="25" border="0" cellpadding="0"
                                                           cellspacing="0">
                                                        <tr>
                                                            <td width="250" height="25" valign="middle"
                                                                background="../../images/back2.gif">
                                                                <table width="250" height="25" border="0"
                                                                       cellpadding="0" cellspacing="0">
                                                                    <tr>
                                                                        <td width="12%">&nbsp;</td>
                                                                        <td width="88%" valign="bottom"><span
                                                                                class="hight"
                                                                                id="lbRec"><%=programName%>列表</span>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                            <td height="21" align="right">
                                                                <input name="search" type="button" class="button"
                                                                       value="检索" onclick="switchSysBar()">
                                                                <input name="addNew" type="button" class="button"
                                                                       value="新建"
                                                                       onclick="self.location='RoleItf.jsp'">
                                                                <input name="delet_row" type="button" class="button"
                                                                       value="删除" onclick="deleteChoosedItems()">
                                                                <input name="refresh" type="button" class="button"
                                                                       value="刷新"
                                                                       onclick="goPage(tab_list.current_page.value)">
                                                                <input name="back" type="button" class="button"
                                                                       value="返回" onclick="history.back();">
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#97C6DF">
                                                <td width="7%" align="center" bgcolor="#97C6DF"><input type="checkbox"
                                                                                                       value="0"
                                                                                                       name="chkListSel_All"
                                                                                                       onclick="allchecked('0');">
                                                </td>
                                                <%
                                                    int k = 0;
                                                    k = rs.getMetaData().getColumnCount();
                                                    for (int i = 2; i <= k; i++) {
                                                %>
                                                <td bgcolor="#97C6DF" align="center" nowrap><font
                                                        color="#FFFFFF"><%=rs.getMetaData().getColumnName(i)%>
                                                </font></td>
                                                <%
                                                    }
                                                %>
                                            </tr>
                                            <%
                                                //将记录集定位指定的行数
                                                int show_row = 0;
                                                if (intRowCount > 0) {
                                                    rs.absolute((current_page - 1) * pageSize + 1);

                                                    while (show_row < pageSize && !rs.isAfterLast()) {
                                                        show_row = show_row + 1;//记录已经显示的行数
                                                        String bgcolor = "bgcolor=#EBEBEB";
                                                        if (show_row % 2 == 1) {
                                                            bgcolor = "";
                                                        } else {
                                                            bgcolor = "bgcolor=#EBEBEB";
                                                        }
                                            %>
                                            <tr  <%=bgcolor%> onclick='setRowIndex(this)'>
                                                <td width="7%">
                                                    <div align="center">
                                                        <input type="checkbox" name="ids"
                                                               value="<%=rs.getString(1).trim()%>">
                                                    </div>
                                                </td>
                                                <%
                                                    //打印各位列的值
                                                    for (int col = 2; col <= k; col++) {
                                                        if (col == 2) {
                                                %>
                                                <td align="center" nowrap><a
                                                        href='RoleItf.jsp?RoleID=<%=rs.getString(1)%>'><%=rs.getString(col)%>
                                                </a></td>
                                                <%
                                                } else {%>
                                                <td align="center" nowrap><%=rs.getString(col)%>
                                                </td>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </tr>
                                            <%
                                                        rs.next();
                                                    }
                                                }
                                            %>

                                        </table>
                                </td>
                            <tr>
                                <td align=right>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="59%">
                                                <input type="hidden" value="<%=show_row%>" name="show_row">每页
                                                <input size=1 value=<%=pageSize%> name=pageSize id=pageSize>条记录
                                                <input onClick="tab_list.submit();" type=button value="GO"
                                                       class="button" name=go>跳页：
                                                <input size=1 value="<%=current_page%>" name="goToPage">
                                                <input onClick="goPage(tab_list.goToPage.value)" type=button
                                                       value="确定" class="button" name=go2>
                                            </td>
                                            <td width="41%">
                                                <div align="right"><font color="#800080">页次:<%=current_page%>
                                                    /<%=all_pages%>
                                                </font>&nbsp;
                                                    <a href="javascript:goPage(1);"><u>首页</u></a> <a
                                                            href="javascript:last();"> <u> 上页</u></a>
                                                    <a href="javascript:next();"> <u> 下页</u></a> <a
                                                            href="javascript:goPage(<%=all_pages%>)"> <u> 尾页</u></a>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        </form>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
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
