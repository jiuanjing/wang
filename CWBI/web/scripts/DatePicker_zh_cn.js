﻿jQuery(function ($) {

    $.datepicker.regional['zh-CN'] = {

        clearText: '清除',

        clearStatus: '清除已选日期',

        closeText: '关闭',

        closeStatus: '不改变当前选择',

        prevText: '<上月',

        prevStatus: '显示上月',

        prevBigText: '<<',

        prevBigStatus: '显示上一年',

        nextText: '下月>',

        nextStatus: '显示下月',

        nextBigText: '>>',

        nextBigStatus: '显示下一年',

        currentText: '今天',

        currentStatus: '显示本月',

        monthNames: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],

        monthNamesShort: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],

        yearStatus: '选择年份',

        monthStatus: '选择月份',

        weekHeader: '周',

        weekStatus: '年内周次',

        dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],

        dayNamesShort: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],

        dayNamesMin: ['日', '一', '二', '三', '四', '五', '六'],

        dayStatus: '设置 DD 为一周起始',

        dateStatus: '选择 m月 d日, DD',

        dateFormat: 'yy-mm-dd',

        firstDay: 1,

        initStatus: '请选择日期',

        isRTL: false
    };

    $.datepicker.setDefaults($.datepicker.regional['zh-CN']);

});