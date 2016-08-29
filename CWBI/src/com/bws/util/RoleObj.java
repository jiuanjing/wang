/*******************************************************************
 *�������ƣ�RoleObj.java
 *����˵�����Խ�ɫ��Ϣ����ά������ɶ�role_info��ķ�װ��������ɶԸñ�����ӡ��޸ġ�ɾ��������
 *��д�ˣ���
 *��дʱ�䣺2014-09-17
 ********************************************************************/
package com.bws.util;

import com.bws.dbOperation.DBOperation;

import java.util.Vector;

public class RoleObj extends entityObj {
    protected String RoleID = "";
    protected String RoleName = "";
    protected String RoleDesc = "";
    protected String OrderNO = "";

    public RoleObj() {
    }

    public RoleObj(String RoleID, String RoleName, String RoleDesc, String OrderNO) {
        this.RoleID = RoleID;
        this.RoleName = RoleName;
        this.RoleDesc = RoleDesc;
        this.OrderNO = OrderNO;
    }

    public boolean Load(String RoleID, DBOperation db) {
        Vector<Vector<String>> ve = new Vector<Vector<String>>();
        ve = db.executeQueryVt("select * from odccbim.role_info where role_id= " + RoleID);
        if (ve == null || ve.size() == 0) {
            return false;
        }
        this.RoleID = ve.elementAt(0).elementAt(0).toString();
        this.RoleName = ve.elementAt(0).elementAt(1).toString();
        this.RoleDesc = ve.elementAt(0).elementAt(2).toString();
        this.OrderNO = ve.elementAt(0).elementAt(3).toString();
        return true;
    }

    public String getInStr() {
        String str = "";
        str = "insert into odccbim.role_info(role_id,role_name,role_desc,order_no) values("
                + this.RoleID
                + ",'" + this.RoleName
                + "','" + this.RoleDesc
                + "'," + this.OrderNO
                + ")";
        return str;
    }

    public String getUpdateStr() {
        String str = "";
        str = "update odccbim.role_info set role_id=" + RoleID + ","
                + "role_name='" + RoleName + "',"
                + "role_desc='" + RoleDesc + "',"
                + "order_no=" + OrderNO
                + " where role_id= " + RoleID;
        return str;
    }

    public String getDelStr() {
        String str = "";
        str = "delete from odccbim.role_info where role_id=" + RoleID;
        return str;
    }

    public String getRoleID() {
        return this.RoleID;
    }

    public void setRoleID(String str) {
        this.RoleID = str;
    }

    public String getRoleName() {
        return this.RoleName;
    }

    public void setRoleName(String str) {
        this.RoleName = str;
    }

    public String getRoleDesc() {
        return this.RoleDesc;
    }

    public void setRoleDesc(String str) {
        this.RoleDesc = str;
    }

    public String getOrderNO() {
        return this.OrderNO;
    }

    public void setOrderNO(String str) {
        this.OrderNO = str;
    }
}