/***********************************************************************************************
 *�������ƣ�LoginUserManager.java
 *�����������ó����Ƕ�ϵͳ�е�ǰ���еĵ�¼�û����й����ṩ�����¼�û��Ļ�������
 *��д�ˣ���
 *��дʱ�䣺2014-09-01
 **************************************************************************************************/
package com.bws.util;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;

public class LoginUserManager {
    private static Hashtable<String, UserInfo> loginUsers = new Hashtable<String, UserInfo>();
    private static Hashtable<String, UserInfo> waitUsers = new Hashtable<String, UserInfo>();

    public static void addUser(String id, UserInfo userInfo) {
        loginUsers.put(id, userInfo);
    }

    public static boolean delUser(String id) {
        try {
            loginUsers.remove(id);

            return true;

        } catch (Exception e) {
            return false;
        }
    }

    public static int getUsersCount() {
        return loginUsers.size();
    }

    public static Enumeration<UserInfo> getAllUsers() {
        Enumeration<UserInfo> waitU = waitUsers.elements();
        while (waitU.hasMoreElements()) {
            UserInfo user = (UserInfo) waitU.nextElement();
            HttpSession session = user.getSession();
            long lasta = session.getLastAccessedTime();
            long now = (new Date()).getTime();
            long wait = (now - lasta) / 1000 / 60;
            if (wait > 45) {
                waitUsers.remove(String.valueOf(user.getUserID()));
            } else if (wait < 2) {
                loginUsers.put(String.valueOf(user.getUserID()), user);
            }
        }

        Enumeration<UserInfo> users = loginUsers.elements();
        while (users.hasMoreElements()) {
            UserInfo user = (UserInfo) users.nextElement();
            HttpSession session = user.getSession();
            long lasta = session.getLastAccessedTime();
            long now = (new Date()).getTime();
            long wait = (now - lasta) / 1000 / 60;
            if (wait > 2) {
                waitUsers.put(String.valueOf(user.getUserID()), user);
                delUser(String.valueOf(user.getUserID()));
            }
        }
        return loginUsers.elements();
    }
}
