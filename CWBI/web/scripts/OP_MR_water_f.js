/**
 * 作者：cjl
 * 时间：2015年10月23日
 * 月度分析报告-供水项目公司
 * 日期和公司的选择
 */
$(document).ready(function () {
    var Nowdate = new Date();
    var nowYear = Nowdate.getYear() + 1900;
    var preYear = Nowdate.getYear() + 1900 - 1;

    var month = Nowdate.getMonth() + 1; //当月
    var _month = month - 1;//上个月

    var nowMonth = month < 10 ? "0" + month : month; //当月
    var preMonth = _month < 10 && _month > 0 ? "0" + _month : _month; //上个月

    if (preMonth == 0) {
        nowYear = nowYear - 1;
        preMonth = "12";
    }
    //设置单个日期
    $("#date").datebox("setValue", nowYear + '-' + preMonth);

    $("#CompanyID").val("1204");
    $("#CompanyName").val("包头市申银水务有限公司");
    aotoCompanyName();
    getFactoryList();
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
                getFactoryList();

            });
        });
};

function getFactoryList() {
    $.ajax({
        url: "WaterFactoryGetFactory.jsp",
        dataType: "text",
        type: "post",
        data: {
            CompanyID: $("#CompanyID").val()
        },
        error: function (msg) {
            alert("Ajax获取数据失败");
        },
        success: function (return_data) {
            var arrayData = eval("(" + return_data + ")");
            $("#FactoryID").empty();
            if (arrayData.length > 0) {
                for (var i = 0; i < arrayData.length; i++) {
                    $("#FactoryID").append("<option value=\"" + arrayData[i].FactoryID + "\">" + arrayData[i].briefName + "</option>");
                }
            }
        }
    });
}