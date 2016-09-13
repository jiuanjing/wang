/**
 * 作者：cjl
 * 时间：2015年10月23日
 * 月度分析报告-供水项目公司
 * 日期和公司的选择
 */
$(document).ready(function () {
    var date = new Date();
    //设置单个日期
    $("#date").datebox("setValue", date.getLastMonth());

    aotoCompanyName();
});
//公司名称模糊查询，自动提示_供水项目公司
function aotoCompanyName() {
    jQuery.post("AutoCompanyList.jsp",
        {
            tableName: "dim_op_company"
        },
        function (data) {
            var list = eval(data);
            var htmList = [];
            for (var i = 0; i < list.length; i++) {
                var temp = {
                    name: list[i].fullPinyin + "," + list[i].shortPinyin + "," + list[i].companyId,
                    to: list[i].companyName
                };
                htmList.push(temp);
            }
            $("#CompanyID").val(list[0].companyId);
            $("#CompanyName").val(list[0].companyName);
            $("#CompanyName").autocomplete(
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
                $("#CompanyID").val(data002[2]);
            });
        });
}