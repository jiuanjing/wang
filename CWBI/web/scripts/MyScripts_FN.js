/**
 * 作者：cjl
 * 时间：2015年10月23日
 * 用于财务主题，创建时间函数，还有公司名称模糊查询dim_company_fn
 * 合并报表在15日以后完成，所以月份 在15日之前 为上上月，15日后 为上月。
 */
$(document).ready(function () {
    var Nowdate = new Date();
    var nowYear = Nowdate.getYear() + 1900;
    var preYear = Nowdate.getYear() + 1900 - 1;

    var month = Nowdate.getMonth() + 1; //当月
    var _month = month - 1;//上个月
    var _month2 = month - 2;//上上个月

    var today = Nowdate.getDate(); //当前日

    var nowMonth = month < 10 ? "0" + month : month; //当月
    var preMonth = _month < 10 && _month > 0 ? "0" + _month : _month; //上个月
    var preMonth2 = _month2 < 10 && _month2 > 0 ? "0" + _month2 : _month2; //上上个月
    if (preMonth == 0) {
        nowYear = nowYear - 1;
        preMonth = "12";
    }
    if (preMonth2 == -1) {
        preMonth2 = "11";
    } else if (preMonth2 == 0) {
        nowYear = nowYear - 1;
        preMonth2 = "12";
    }

    if (today <= 15) {
        preMonth = preMonth2;
    }

    //设置开始日期
    $("#begin_date").datebox("setValue", preYear + '-01');
    //设置结束日期
    $("#end_date").datebox("setValue", nowYear + '-' + preMonth);
    //设置单个日期
    $("#date").datebox("setValue", nowYear + '-' + preMonth);

    //使echarts自适应页面高度
    var h = $(window).height() - 60;
    if ($("#main").length > 0) {
        $("#main").height(h);
    }
    if ($("#main_1").length > 0) {
        $("#main_1").height(h);
    }
    if ($("#main1").length > 0) {
        $("#main1").height(h / 2);
    }
    if ($("#main2").length > 0) {
        $("#main2").height(h / 2);
    }
    if ($("#main3").length > 0) {
        $("#main3").height(h / 2);
    }
    if ($("#main4").length > 0) {
        $("#main4").height(h / 2);
    }
});
//公司名称模糊查询，自动提示
function aotoCompanyName() {
    jQuery.post("../../common/AutoCompanyList.jsp",
        {
            tableName: "dim_company_fn"
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
            });
        });
}
var click = 1;
function lookup() {
    if (click == 1) {
        $("#lookup").css("background-color", "lime");
        click = 2;
        $(".hiddenSytle").each(function () {
            $(this).remove();
        });
        $("#append").before("<td class='hiddenSytle2' width='10%'>公司名称： </td>"
            + "<td class='hiddenSytle2' width='8%'><input style='width:280px;' id='CompanyName'></input>"
            + "<input type='hidden' id='CompanyID'></input>"
            + "</td>");
        aotoCompanyName();
    } else {
        $("#lookup").css("background-color", "#fff");
        click = 1;
        $(".hiddenSytle2").each(function () {
            $(this).remove();
        });
        $("#append").before("<td class='hiddenSytle' width='10%'>所属管理部门：</td>"
            + "<td class='hiddenSytle' width='10'><div id='select_dept'></div></td>"
            + "<td class='hiddenSytle' width='4%'>地区：</td>"
            + "<td class='hiddenSytle' width='8%'><div id='select_region'></div></td>"
            + "<td class='hiddenSytle' width='4%'>公司： </td>"
            + "<td class='hiddenSytle' width='8%'><div id='select_company'/></div></td>");
        DoAjaxGetDeptData();
        DoAjaxGetRegionData();
        DoAjaxGetCompanyData();
    }
}