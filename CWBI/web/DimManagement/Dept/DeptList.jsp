<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<jsp:useBean id="userInfo" class="com.bws.util.UserInfo" scope="session"/>
<%
    String positionStr = "部门信息管理";
    String programName = "部门列表";
%>
<!DOCTYPE html>
<html>
<head>
    <title>部门信息维护</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="Expires" content="0">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-control" content="no-cache">
    <meta http-equiv="Cache" content="no-cache">
    <link href="../../css/style1.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="../../scripts/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="../../scripts/jquery.easyui.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../../scripts/easyui-1.3.6/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../../scripts/easyui-1.3.6/themes/icon.css">
    <script type="text/javascript" src="../../scripts/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="../../css/condition-table.css"/>
</head>
<script>
    $(function () {
        $('#tg').datagrid({
            url: 'DoGetDeptList.jsp',
            title: '部门信息列表',
            height: $(window).height() - 36,
            pagination: true,
            pageSize: 50,
            pageNumber: 1,
            pageList: [10, 20, 30, 50, 100, 150, 200],
            fitColumns: true,
            singleSelect: false,
            method: 'post',
            nowrap: false,
            rownumbers: true,
            striped: true,
            toolbar: '#query_condition',
            loadMsg: '正在加载数据，请稍等......',
            queryParams: {
                dept_name: $("#dept_name").val()
            },
            idField: 'dept_id',
            sortName: 'order_no', //默认排序字段
            sortOrder: 'asc', //排序方式
            columns: [[
                {field: 'ck', checkbox: true},
                {field: 'dept_id', hidden: true},
                {
                    field: 'dept_name', title: '部门名称', width: 30,
                    formatter: function (value, rowData, rowIndex) {
                        var row = "";
                        row += "<a href=\"DeptItf.jsp?dept_id=" + rowData.dept_id + "\">" + value + "</a>";
                        return row;
                    }
                },
                {field: 'brief_name', title: '部门简称', width: 20, align: 'center'},
                {field: 'dept_code', title: '部门编号', width: 20, align: 'center'},
                {field: 'status', title: '部门状态', width: 20, align: 'center'},
                {field: 'order_no', title: '部门排序号', width: 30, align: 'center', sortable: true}
            ]]
        });
    });
    function doSearch() {
        $('#tg').datagrid('load', {
            dept_name: $("#dept_name").val()
        });
    }
    function doRemove() {

        var ids = $('#tg').datagrid('getChecked');
        var idsArray = [];

        $.each(ids, function (i, n) {
            idsArray.push(n.dept_id);
        });
        var selectedIds = idsArray.join(",");
        if (selectedIds == "") {
            alert("请选择要删除的信息!");
            return;
        }
        if (confirm("真的要删除吗？")) {
            f1.type.value = "delete";
            f1.selectedIds.value = selectedIds;
            f1.submit();
        }

    }
</script>
<body bgcolor="#FFFFFF" background="../../images/back.jpg" leftmargin="0" topmargin="0" marginwidth="0"
      marginheight="0">
<form name="f1" method="post" action="DeptCtl.jsp">
    <input name="type" type="hidden">
    <input name="selectedIds" type="hidden">
</form>
<table width="98%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="18">&nbsp;</td>
    </tr>
    <tr>
        <td height="18"><span id="lbCurPos"
                              class="lbl2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;>>>>当前位置：<%=positionStr%></span>
        </td>
    </tr>
</table>
<div id="query_condition">
    <div style="padding: 5px;">
        部门名称：<input style='width:280px;' id='dept_name'></input>
        <a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="doSearch();">确&nbsp;&nbsp;&nbsp;&nbsp;定</a>
        &nbsp;&nbsp;
        <a style="float: right;" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true"
           href="javascript:void(0)" onclick="doRemove();">删除</a>
        <a style="float: right;" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true"
           href="javascript:void(0)" onclick="javascript:self.location='DeptItf.jsp'">新建</a>
    </div>
</div>
<div style="height:100%;width: 98%;overflow: visible;padding-left: 10px;padding-right: 10xp;">
    <table id="tg">
    </table>
</div>
</body>
</html>
