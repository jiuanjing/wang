package com.bws.util;

import com.bws.dbOperation.DBOperation;
import com.bws.tools.ChStr;

import javax.servlet.ServletRequest;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Vector;

//import javax.servlet.jsp.*;

public class CheckUserRight {
    private static Hashtable<String, String> hs_type = new Hashtable<String, String>();

    static {
        hs_type.put("1", "ֻ������");
        hs_type.put("2", "���ӡ�ɾ�����޸Ĳ���");
    }

    public static boolean check(UserInfo user, javax.servlet.jsp.PageContext pageContext) {
        javax.servlet.jsp.JspWriter out = pageContext.getOut();
        try {
            if (user == null || user.getLoginFlag() == false) {
                out.println("<script language='javascript' >");
                out.println("alert(\"�Բ������Ѿ���ʱ�������µ�¼\")");
                out.println("</script>");

                return false;
            } else {
                return true;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean check(UserInfo user, String[] progid, String type, javax.servlet.jsp.PageContext pageContext) {
        try {
            javax.servlet.jsp.JspWriter out = pageContext.getOut();
            if (user == null || user.getLoginFlag() == false || progid.length == 0) {
                out.println("<script language='javascript' >");
                out.println("alert(\"�Բ������Ѿ���ʱ�������µ�¼��\")");
                out.println("</script>");

                return false;
            } else {
                //��¼�û�������־
                writeLog(user.getUserID(), progid[0], hs_type.get(type).toString(), pageContext.getRequest().getRemoteAddr());

                boolean f = false;
                for (int i = 0; i < progid.length; i++) {
                    String re = UserInfo.checkModuleRole(user, progid[i], type);//����û�Ȩ��

                    if (re.equals("0")) {
                        out.println("<script language='javascript' >");
                        out.println("alert(\"�Բ������Ѿ���ʱ�������µ�¼��\")");
                        out.println("</script>");
                        return false;
                    } else if (re.equals("1")) {
                        f = true;
                    } else {
                        continue;
                    }
                }

                if (!f) {
                    if (type.equals("2")) {
                        out.println("<script language='javascript' >");
                        out.println("alert(\"�Բ�����û�а�ȫ���Ƶ�Ȩ�ޣ�������ִ�����ӡ��޸ġ�ɾ��������\")");
                        out.println("</script>");

                    } else if (type.equals("1")) {
                        out.println("<script language='javascript' >");
                        out.println("alert(\"�Բ�����û�жԸù��ܶ���Ȩ�ޣ�������ִ�в鿴������\")");
                        out.println("</script>");
                    }
                }

                return f;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean check(UserInfo user, String[] progid, String type) {
        try {
            if (user == null || user.getLoginFlag() == false || progid.length == 0) {
                return false;
            } else {
                //��¼�û�������־
                writeLog(user.getUserID(), progid[0], hs_type.get(type).toString(), "");

                boolean f = false;
                for (int i = 0; i < progid.length; i++) {
                    String re = UserInfo.checkModuleRole(user, progid[i], type);//����û�Ȩ��

                    if (re.equals("0")) {
                        return false;
                    } else if (re.equals("1")) {
                        f = true;
                    } else {
                        continue;
                    }
                }

                return f;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean check(UserInfo user, String progid, String type) {
        try {
            //��¼�û�������־
            writeLog(user.getUserID(), progid, hs_type.get(type).toString(), "");

            if (user == null || user.getLoginFlag() == false) {
                return false;
            } else {
                String re = UserInfo.checkModuleRole(user, progid, type);//����û�Ȩ��
                if (re.equals("0")) {
                    return false;

                } else if (re.equals("-1")) {
                    return false;
                } else {
                    return true;
                }
            }

        } catch (Exception e) {
            return false;
        }
    }

    public static boolean check(UserInfo user, String progid, String type, javax.servlet.jsp.PageContext pageContext) {
        try {
            //��¼�û�������־
            writeLog(user.getUserID(), progid, hs_type.get(type).toString(), pageContext.getRequest().getRemoteAddr());

            javax.servlet.jsp.JspWriter out = pageContext.getOut();
            if (user == null || user.getLoginFlag() == false) {
                out.println("<script language='javascript' >");
                out.println("alert(\"�Բ������Ѿ���ʱ�������µ�¼��\")");
                out.println("</script>");

                return false;
            } else {
                String re = UserInfo.checkModuleRole(user, progid, type);//����û�Ȩ��
                if (re.equals("0")) {
                    out.println("<script language='javascript' >");
                    out.println("alert(\"�Բ������Ѿ���ʱ�������µ�¼��\")");
                    out.println("</script>");

                    return false;
                } else if (re.equals("-1")) {
                    if (type.equals("2")) {
                        out.println("<script language='javascript' >");
                        out.println("alert(\"�Բ�����û�а�ȫ���Ƶ�Ȩ�ޣ�������ִ�����ӡ��޸ġ�ɾ��������\")");
                        out.println("</script>");

                    } else if (type.equals("1")) {
                        out.println("<script language='javascript' >");
                        out.println("alert(\"�Բ�����û�жԸù��ܶ���Ȩ�ޣ�������ִ�в鿴������\")");
                        out.println("</script>");
                    }

                    return false;
                } else {
                    return true;
                }
            }

        } catch (Exception e) {
            return false;
        }
    }

    public static boolean checkAndSave(UserInfo user, String progid, String type, javax.servlet.jsp.PageContext pageContext) {

        if (check(user, progid, type, pageContext)) {
            return saveOperator(user, progid, pageContext);

        } else {
            return false;
        }
    }

    public static boolean saveOperator(UserInfo user, String progid, javax.servlet.jsp.PageContext pageContext) {

        DBOperation db = new DBOperation(true);
        if (db.dbOpen()) {
            try {
                String url = "";
                ServletRequest request = pageContext.getRequest();
                Enumeration<String> names = request.getParameterNames();

                while (names.hasMoreElements()) {
                    String name = names.nextElement().toString();
                    String[] values = request.getParameterValues(name);

                    for (int i = 0; i < values.length; i++) {
                        if (url.equals("")) {
                            url = name + "=" + ChStr.chStr(values[i]);
                        } else {
                            url = url + "&" + name + "=" + ChStr.chStr(values[i]);
                        }
                    }

                }

                String sqlstr = "";
                Vector<Vector<String>> v = db.executeQueryVt("select URL from UserOperator where ProgramID='" + progid + "' and EmployeeID='" + user.getUserID() + "'");

                String oldUrl = "";
                if (v != null && v.size() > 0) {
                    oldUrl = v.elementAt(0).elementAt(0).toString();
                }

                if (!oldUrl.equals(url)) {
                    if (v != null && v.size() == 0) {
                        sqlstr = "insert into UserOperator(ProgramID,EmployeeID,URL) values('" + progid + "','" + user.getUserID() + "','" + url + "')";
                    } else {
                        sqlstr = "update UserOperator set URL='" + url + "' where ProgramID='" + progid + "' and EmployeeID='" + user.getUserID() + "'";
                    }
                    db.executeUpdate(sqlstr);
                }

                return true;

            } catch (Exception e) {
                return true;

            } finally {
                db.dbClose();
            }
        }

        return true;
    }

    //��¼�û�������־
    public static void writeLog(int EmployeeID, String ProgramID, String note, String ip) {
        DBOperation db = new DBOperation(true);
        if (db.dbOpen()) {
            try {
                db.executeUpdate("insert into SystemLog(ProgramID,EmployeeID,UseTime,Note,IPAddress) values('" + ProgramID + "'," + EmployeeID + ",'" + DateTimeFormat.getNowDateTimeStr() + "','" + note + "','" + ip + "')");

            } catch (Exception e) {

            } finally {
                db.dbClose();
            }
        }
    }

    public static void writeLog(int EmployeeID, String ProgramID, String note) {
        writeLog(EmployeeID, ProgramID, note, "");
    }
}
