/******************************************************************************************************
 *�������ƣ�UserRoleObj.java
 *����˵�����ó����Ƕ�ϵͳ�е��û���ɫ����Ϣ���з�װ��������ɶ��û���ɫ������ӡ��޸ġ�ɾ��������
 *��д�ˣ���
 *��дʱ�䣺2014-09-01
 ******************************************************************************************************/
package com.bws.util;

import com.bws.dbOperation.DBOperation;

import java.util.Vector;

public class UserRoleObj //extends entityObj
{
    protected String RoleID = "";
    protected String RoleName = "";

    public UserRoleObj() {
    }

    public UserRoleObj(String RoleID, String RoleName) {
        this.RoleID = RoleID;
        this.RoleName = RoleName;

    }

    public boolean Load(String RoleID, DBOperation db) {
        Vector<Vector<String>> ve = new Vector<Vector<String>>();
        ve = db.executeQueryVt("select RoleID,RoleName from odccbim.UserRole where " + "RoleID= " + RoleID);
        if (ve == null || ve.size() == 0) {
            return false;
        }
        this.RoleID = ((Vector<String>) (ve.elementAt(0))).elementAt(0).toString();
        this.RoleName = ((Vector<String>) (ve.elementAt(0))).elementAt(1).toString();

        return true;
    }

    public String getInStr() {
        String str = "";
        str = " insert into odccbim.UserRole(RoleID,RoleName) values(" + this.RoleID + "," + "'" + this.RoleName + "'" + ")";
        return str;
    }

    public String getUpdateStr() {
        String str = "";
        str = "update odccbim.UserRole set " + "RoleID=" + RoleID + "," + "RoleName='" + RoleName + "'" + " where " + "RoleID= " + RoleID;
        return str;
    }

    public String getDelStr() {
        String str = "";
        str = "delete from odccbim.UserRole where " + "RoleID= " + RoleID;
        return str;
    }
}