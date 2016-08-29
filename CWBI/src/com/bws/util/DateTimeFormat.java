/*****************************************************************
 * �÷����Ǹ��ݴ����һ�����ڶ�������ڸ�ʽ�����ط������ڸ�ʽ���ַ��������ڸ�ʽ�е�
 * �ַ��У�YYYY��ʾ��λ�꣬MM��ʾ��λ�£�DD��ʾ��λ�գ�hh��ʾ��λʱ��mm��ʾ��λ�֣�
 * ss��ʾ��λ�롣�û����Ը�����Ҫʹ����Щ�ַ����,mmss��ʾ���롣
 * *��YYYY-MM-DD hh:mm:ss:ms�ĸ�ʽ�淶�����ڼ�ʱ��
 ******************************************************************/
package com.bws.util;

import java.util.Calendar;

public class DateTimeFormat {
    public DateTimeFormat() {
    }

    public static String getNowDateTimeStr() {
        Calendar cal = Calendar.getInstance();
        return fmtDateTime(cal);
    }

    public static String fmtDateTime(Calendar cal) {
        try {
            int y = cal.get(Calendar.YEAR);
            String MM = "";
            int m = cal.get(Calendar.MONTH) + 1;
            if (m < 10) {
                MM = "0" + m;
            } else {
                MM = "" + m;
            }
            String DD = "";
            int d = cal.get(Calendar.DATE);
            if (d >= 10) {
                DD = "" + d;
            } else {
                DD = "0" + d;
            }
            int h = cal.get(Calendar.HOUR_OF_DAY);
            String hh = "";
            if (h >= 10) {
                hh = "" + h;
            } else {
                hh = "0" + h;
            }
            int min = cal.get(Calendar.MINUTE);
            String mm = "";
            if (min >= 10) {
                mm = "" + min;
            } else {
                mm = "0" + min;
            }
            int s = cal.get(Calendar.SECOND);
            String ss = "";
            if (s >= 10) {
                ss = "" + s;
            } else {
                ss = "0" + s;
            }
            int ms = cal.get(Calendar.MILLISECOND);
            String mmss = "";
            if (ms >= 100) {
                mmss = "" + ms;
            } else if (ms >= 10) {
                mmss = "0" + ms;
            }
            {
                mmss = "00" + ms;
            }
            String tmpDay = Integer.toString(y) + "-" + MM + "-" + DD;
            String tmpTime = tmpDay + " " + hh + ":" + mm + ":" + ss + ":" + mmss;
            return tmpTime;
        } catch (Exception e) {
            return null;
        }
    }
}