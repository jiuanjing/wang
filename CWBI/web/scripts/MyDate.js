/**
 * 作者：cjl
 * 时间：2016年5月1日
 * 扩展Date对象，直接获取响应的时间值
 */
$(document).ready(function () {
    //时间格式yyyy-MM,上个月
    Date.prototype.getLastMonth = function () {
        var date = new Date();
        var y = date.getFullYear();
        var m = date.getMonth();
        return y + "-" + (m < 10 ? "0" + m : m);
    };
    //时间格式yyyy-MM, 财务合并报表在15日以后完成，所以月份 在15日之前 为上上月，15日后 为上月。
    Date.prototype.getLastMonthAfter15 = function () {
        var date = new Date();
        var d = date.getDate();
        var y = date.getFullYear();
        var m = date.getMonth();
        if (d <= 15) {
            m = m - 1;
        }
        return y + "-" + (m < 10 ? "0" + m : m);
    };
    //时间格式yyyy-MM,去年
    Date.prototype.getLastYear = function () {
        var date = new Date();
        var y = date.getFullYear() - 1;
        var m = date.getMonth();
        return y + "-" + (m < 10 ? "0" + m : m);
    };
    //时间格式yyyy-MM,去年,月份在-1
    Date.prototype.getLastYearAndMonth = function () {
        var date = new Date();
        var y = date.getFullYear() - 1;
        var m = date.getMonth();
        return y + "-" + (m < 10 ? "0" + m : m);
    };
    //时间格式yyyy-MM,去年一月份
    Date.prototype.getLastYear01 = function () {
        var date = new Date();
        var y = date.getFullYear() - 1;
        return y + "-01";
    };
    //时间格式yyyy-MM,当年一月份（如果上月为12月，则返回去年1月）
    Date.prototype.getYear01 = function () {
        var date = new Date();
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        date.setMonth(0);
        var m1 = date.getMonth() + 1;
        return (m == 1 ? (y - 1) : y) + "-" + (m1 < 10 ? "0" + m1 : m1);
    };
});
