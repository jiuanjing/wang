/**
 * 作者：cjl
 */
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
$(document).ready(function () {
    var Request = new Object();
    Request = GetRequest();
    var date = Request['date'];
    if (date == null || date == "") {
        //设置单个日期
        $("#date").datebox("setValue", nowYear + '-' + preMonth);
    } else {
        $("#date").datebox("setValue", date);
    }
});
function FormatDate(date) {
    return date.getFullYear() + "-" + ((date.getMonth() + 1));
}
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