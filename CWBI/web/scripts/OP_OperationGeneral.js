/**
 * 作者：cjl
 * 时间：2016年4月23日
 * 被Operation-OperationGeneral下的html引用，用做初始化时间
 */
$(document).ready(function () {
    var date = new Date();
    //设置单个日期
    $("#date").datebox("setValue", date.getLastMonth());

});

