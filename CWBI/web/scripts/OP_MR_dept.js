/**
 * 作者：cjl
 * 时间：2015年10月23日
 * 月度分析报告-供水大区
 * 日期和公司的选择
 */
$(document).ready(function () {
    var date = new Date();
    //设置单个日期
    $("#date").datebox("setValue", date.getLastMonth());
    aotoDeptName();
});
//大区名称模糊查询，自动提示-大区
function aotoDeptName() {
    jQuery.post("AutoDeptList.jsp",
        {
            tableName: "dim_dept_op"
        },
        function (data) {
            var list = eval(data);
            var htmList = [];
            for (var i = 0; i < list.length; i++) {
                var temp = {
                    name: list[i].fullPinyin + "," + list[i].shortPinyin + "," + list[i].deptId,
                    to: list[i].deptName
                };
                htmList.push(temp);
            }
            $("#DeptID").val(list[0].deptId);
            $("#DeptName").val(list[0].deptName);
            $("#DeptName").autocomplete(
                htmList, {
                    max: 50,    //列表里的条目数
                    minChars: 0,    //自动完成激活之前填入的最小字符
                    width: 280,     //提示的宽度，溢出隐藏
                    scrollHeight: 300,   //提示的高度，溢出显示滚动条
                    matchContains: true,    //包含匹配，就是data参数里的数据，是否只要包含文本框里的数据就显示
                    mustMatch: true,      //必须选择下拉列表的值
                    autoFill: false,    //自动填充
                    formatItem: function (row, i, max) {
                        //return i + '/' + max + ':"' + row.name + '"[' + row.to + ']';
                        return row.to;
                    },
                    formatMatch: function (row, i, max) {
                        return row.name + row.to;
                    },
                    formatResult: function (row) {
                        return row.to;
                    }
                }).result(function (event, row, formatted) {
                var data001 = row.name;
                var data002 = data001.split(",");
                $("#DeptID").val(data002[2]);
            });
        });
}
function mergeRow(id, col) {
    var trs = $("#" + id + " > tr");
    var rows = 1;
    for (var i = trs.length; i >= 0; i--) {
        var cur = $($(trs[i]).find("td")[col]).text();
        var next = $($(trs[i - 1]).find("td")[col]).text();
        if (cur == next) {
            rows++;
            $($(trs[i]).find("td")[col]).remove();
        } else {
            $($(trs[i]).find("td")[col]).attr("rowspan", rows);
            rows = 1;
        }
    }
}