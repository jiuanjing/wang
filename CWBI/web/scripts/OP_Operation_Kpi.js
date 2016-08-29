/**
 * 作者：cjl
 * 时间：2016年4月23日
 * 被Operation-Kpi下的html引用，用做初始化时间
 */
$(document).ready(function () {
    var tdate = new Date();
    //设置开始日期
    $("#begin_date").datebox("setValue", tdate.getYear01());
    //设置结束日期
    $("#end_date").datebox("setValue", tdate.getLastMonth());
    var Request = new Object();
    Request = GetRequest();
    var date = Request['date'];
    if (date == null || date == "") {
        //设置单个日期
        $("#date").datebox("setValue", tdate.getLastMonthAfter15());
    } else {
        $("#date").datebox("setValue", date);
    }
});
//获取URL参数
function GetRequest() {
    var url = location.search; //获取url中"?"符后的字串
    var theRequest = new Object();
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for (var i = 0; i < strs.length; i++) {
            theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
        }
    }
    return theRequest;
} 
