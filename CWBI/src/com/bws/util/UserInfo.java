package com.bws.util;

import com.bws.dbOperation.DBOperation;

import javax.servlet.http.HttpSession;
import java.io.Serializable;
import java.util.Vector;

public class UserInfo implements Serializable {
    private static final long serialVersionUID = 1L;
    private int user_id;
    private String user_account = "";
    private String user_password = "";
    private String user_name = "";
    private int company_id;
    private int dept_id;
    private String position = "";
    private int role_id;
    private String email = "";
    private String phone = "";
    private String mobile = "";
    private int page_size;
    private int status;

    private boolean loginFlag = false;
    private String moduleRoleStr = "";
    private int timeLimit = 6;
    private String loginTime = "";//��¼ʱ��
    private String RefreshTime = "600";//ˢ��ʱ��
    private HttpSession Session = null;
    //private int pageStyle;
    //private int pageSize;

    public UserInfo() {
    }

    public boolean check_login(String UserAccount, String UserPassword, DBOperation db, UserInfo user) {
        try {
            if (UserAccount == null || UserPassword == null || db == null) {
                return false;
            }

            String sqlstr = "select user_id,user_account,user_password,user_name,company_id,dept_id,position,role_id,email,phone,mobile,status,page_size from bim.user_info where status=1 and user_account='" + UserAccount + "' and user_password='" + UserPassword + "'";

            Vector<Vector<String>> ve = db.executeQueryVt(sqlstr);

            if (ve == null || ve.size() == 0)
            {
                return false;

            } else if (ve.size() > 0) {
                user.setUserID(Integer.parseInt((ve.elementAt(0)).elementAt(0).toString()));
                user.setUserAccount((ve.elementAt(0)).elementAt(1).toString());
                user.setUserPassword((ve.elementAt(0)).elementAt(2).toString());
                user.setUserName((ve.elementAt(0)).elementAt(3).toString());
                user.setCompanyID(Integer.parseInt((ve.elementAt(0)).elementAt(4).toString()));
                user.setDeptID(Integer.parseInt((ve.elementAt(0)).elementAt(5).toString()));
                user.setPosition((ve.elementAt(0)).elementAt(6).toString());
                user.setRoleID(Integer.parseInt((ve.elementAt(0)).elementAt(7).toString()));
                user.setEmail((ve.elementAt(0)).elementAt(8).toString());
                user.setPhone((ve.elementAt(0)).elementAt(9).toString());
                user.setMobile((ve.elementAt(0)).elementAt(10).toString());
                user.setStatus(Integer.parseInt((ve.elementAt(0)).elementAt(11).toString()));
                user.setPageSize(Integer.parseInt((ve.elementAt(0)).elementAt(12).toString()));

                user.setLoginFlag(true);

                int RoleID = user.getRoleID();

                Vector<Vector<String>> ve_module_right = db.executeQueryVt("select distinct(module_id), right_type from bim.role_module where role_id =" + RoleID);
                if (ve_module_right == null) {
                    return false;
                } else if (ve_module_right.size() > 0) {
                    String roleStr = "";
                    for (int i = 0; i < ve_module_right.size(); i++) {
                        String id = (ve_module_right.elementAt(i)).elementAt(0).toString();
                        String AccessType = (ve_module_right.elementAt(i)).elementAt(1).toString();
                        roleStr = roleStr + "$" + id + "," + AccessType;
                    }
                    roleStr = roleStr + "$";
                    user.setModuleRoleStr(roleStr);
                }
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public boolean ca_check_login(String UserPassword, DBOperation db, UserInfo user) {
        try {
            if (UserPassword == null || db == null) {
                return false;
            }

            String sqlstr = "select user_id,user_account,user_password,user_name,company_id,dept_id,position,role_id,email,phone,mobile,status,page_size from bim.user_info where status=1 and user_password='" + UserPassword + "'";

            Vector<Vector<String>> ve = db.executeQueryVt(sqlstr);

            if (ve == null || ve.size() == 0)
            {
                return false;

            } else if (ve.size() > 0) {
                user.setUserID(Integer.parseInt((ve.elementAt(0)).elementAt(0).toString()));
                user.setUserAccount((ve.elementAt(0)).elementAt(1).toString());
                user.setUserPassword((ve.elementAt(0)).elementAt(2).toString());
                user.setUserName((ve.elementAt(0)).elementAt(3).toString());
                user.setCompanyID(Integer.parseInt((ve.elementAt(0)).elementAt(4).toString()));
                user.setDeptID(Integer.parseInt((ve.elementAt(0)).elementAt(5).toString()));
                user.setPosition((ve.elementAt(0)).elementAt(6).toString());
                user.setRoleID(Integer.parseInt((ve.elementAt(0)).elementAt(7).toString()));
                user.setEmail((ve.elementAt(0)).elementAt(8).toString());
                user.setPhone((ve.elementAt(0)).elementAt(9).toString());
                user.setMobile((ve.elementAt(0)).elementAt(10).toString());
                user.setStatus(Integer.parseInt((ve.elementAt(0)).elementAt(11).toString()));
                user.setPageSize(Integer.parseInt((ve.elementAt(0)).elementAt(12).toString()));

                user.setLoginFlag(true);

                int RoleID = user.getRoleID();

                Vector<Vector<String>> ve_module_right = db.executeQueryVt("select distinct(module_id), right_type from bim.role_module where role_id =" + RoleID);
                if (ve_module_right == null) {
                    return false;
                } else if (ve_module_right.size() > 0) {
                    String roleStr = "";
                    for (int i = 0; i < ve_module_right.size(); i++) {
                        String id = (ve_module_right.elementAt(i)).elementAt(0).toString();
                        String AccessType = (ve_module_right.elementAt(i)).elementAt(1).toString();
                        roleStr = roleStr + "$" + id + "," + AccessType;
                    }
                    roleStr = roleStr + "$";
                    user.setModuleRoleStr(roleStr);
                }
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public Vector<Vector<String>> getFirstLevelModule(DBOperation db) {

        if (this.loginFlag == false)//����û��Ƿ��Ѿ���¼�ˣ����û�е�¼����˵������һ���յ�����
        {
            return new Vector<Vector<String>>();
        } else {
            try {
                String sqlstr = "";
                sqlstr = "select distinct(a.module_id), a.module_code, a.module_name, a.URL from bim.module a, bim.role_module b " +
                        " where b.role_id=" + this.role_id + " and a.module_id=b.module_id and a.module_level=1 and a.status=1 order by a.order_NO asc";

                Vector<Vector<String>> ve = db.executeQueryVt(sqlstr);

                if (ve != null) {
                    return ve;
                } else {
                    return new Vector<Vector<String>>();
                }
            } catch (Exception e) {
                return new Vector<Vector<String>>();
            }
        }
    }

    public Vector<Vector<String>> getSubModule(DBOperation db, String ModuleCode) {
        if (this.loginFlag == false)
        {
            return new Vector<Vector<String>>();
        } else {
            try {
                String sqlstr = "";
                sqlstr = "select distinct(a.module_id), a.module_code, a.module_name, a.URL" +
                        " from bim.module a, bim.role_module b where b.role_id=" + this.role_id +
                        "datalength(a.module_code) >" + ModuleCode.length() + " and a.module_code like '" + ModuleCode +
                        "%' and a.module_id=b.module_id order by a.order_NO asc";

                Vector<Vector<String>> ve = db.executeQueryVt(sqlstr);
                if (ve != null) {
                    return ve;
                } else {
                    return new Vector<Vector<String>>();
                }
            } catch (Exception e) {
                return new Vector<Vector<String>>();
            }
        }
    }

    public static String checkModuleRole(UserInfo user, String ModuleID, String AccessType) {
        try {
            if (user == null) {
                return "0";
            }
            String moduleStr = user.getModuleRoleStr();

            if (moduleStr.equals("")) {
                return "-1";
            } else {
                String se = "$" + ModuleID + "," + AccessType + "$";
                int f = -1;
                if (AccessType.equals("1")) {
                    f = moduleStr.indexOf(se);
                    if (f == -1)
                    {
                        se = "$" + ModuleID + ",2$";
                        f = moduleStr.indexOf(se);
                    }
                } else if (AccessType.equals("2")) {
                    f = moduleStr.indexOf(se);
                }

                if (f == -1) {
                    return "-1";
                } else {
                    return "1";
                }
            }

        } catch (Exception e) {
            return "-1";
        }
    }


    public int getUserID() {
        return user_id;
    }

    public void setUserID(int newUserID) {
        user_id = newUserID;
    }

    public String getUserAccount() {
        return user_account;
    }

    public void setUserAccount(String newUserAccount) {
        user_account = newUserAccount;
    }

    public String getUserPassword() {
        return user_password;
    }

    public void setUserPassword(String newUserPassword) {
        user_password = newUserPassword;
    }

    public String getUserName() {
        return user_name;
    }

    public void setUserName(String newUserName) {
        user_name = newUserName;
    }

    public int getCompanyID() {
        return company_id;
    }

    public void setCompanyID(int newCompanyID) {
        company_id = newCompanyID;
    }

    public int getDeptID() {
        return dept_id;
    }

    public void setDeptID(int newDeptID) {
        dept_id = newDeptID;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String newPosition) {
        position = newPosition;
    }

    public int getRoleID() {
        return role_id;
    }

    public void setRoleID(int newRoleID) {
        role_id = newRoleID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String newEmail) {
        email = newEmail;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String newPhone) {
        phone = newPhone;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String newMobile) {
        mobile = newMobile;
    }

    public int getStatus() {
        return status;
    }

    public int getPage_size() {
        return page_size;
    }

    public void setPageSize(int newPageSize) {
        page_size = newPageSize;
    }

    public void setStatus(int newStatus) {
        status = newStatus;
    }

    public String getModuleRoleStr() {
        return this.moduleRoleStr;
    }

    public void setModuleRoleStr(String str) {
        this.moduleRoleStr = str;
    }

    public int getTimeLimit() {
        return timeLimit;
    }

    public void setTimeLimit(int i) {
        timeLimit = i;
    }

    public boolean getLoginFlag() {
        return loginFlag;
    }

    public void setLoginFlag(boolean f) {
        loginFlag = f;
    }

    public String getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(String lt) {
        loginTime = lt;
    }

    public String getRefreshTime() {
        return RefreshTime;
    }

    public void setRefreshTime(String s) {
        RefreshTime = s;
    }

    public void setSession(HttpSession session) {
        Session = session;
    }

    public HttpSession getSession() {
        return Session;
    }


}
