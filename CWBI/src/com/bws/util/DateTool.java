/*****************************************************************
 *��ȡ��ǰʱ�䣬��ʽΪyyyy-MM-dd
 *��ȡ��ǰʱ�䣬��ʽΪyyyyMM
 *��ȡ�ϸ��µĵ�ǰʱ�䣬��ʽΪyyyy-MM-dd
 *��ȡ�ϸ��µĵ�ǰʱ�䣬��ʽΪyyyyMM
 ******************************************************************/
package com.bws.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateTool {
    public DateTool() {

    }

    public static String getNowDate01() {
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.format(date);

    }

    public static String getNowDate02() {
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMM");
        return df.format(date);
    }

    public static String getPreMonDate01() {
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, -1);
        return df.format(cal.getTime());

    }

    public static String getPreMonDate02() {
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMM");
        int day = Calendar.getInstance().get(Calendar.DAY_OF_MONTH);
        Calendar cal = Calendar.getInstance();
        if (day > 15) {
            cal.setTime(date);
            cal.add(Calendar.MONTH, -1);
        } else {
            cal.setTime(date);
            cal.add(Calendar.MONTH, -2);
        }
        return df.format(cal.getTime());
    }

    public static String getPreMonDate03() {
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMM");
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, -1);
        return df.format(cal.getTime());
    }

}