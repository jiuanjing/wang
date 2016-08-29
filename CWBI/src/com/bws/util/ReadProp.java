package com.bws.util;

import java.io.IOException;
import java.util.Properties;

public class ReadProp {
    private static Properties p = new Properties();

    /**
     * ��ȡproperties�����ļ���Ϣ 
     */
    static {
        try {
            p.load(ReadProp.class.getClassLoader().getResourceAsStream("sys.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * ����key�õ�value��ֵ
     */
    public static String getValue(String key) {
        return p.getProperty(key);
    }
}
