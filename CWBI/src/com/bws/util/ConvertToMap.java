package com.bws.util;

import java.util.HashMap;
import java.util.Map;

public class ConvertToMap {
    /*
	 * ��Json����ת����Map����
	 * params��strΪ���Ÿ������ַ������磺 "name"��"jack","age":"18"
	 */

    public static Map<String, Object> FormatToMap(String str) {
        if (null == str) {
            return null;
        } else {
            Map<String, Object> map = new HashMap<String, Object>();
            String[] strArray = str.split(",");
            for (String string : strArray) {
                String[] temp = string.split(":");
                map.put(temp[0], temp[1]);
            }
            return map;
        }
    }
}
