/*******************************************************************
 *�������ƣ�UserObj.java
 *����˵�������û���Ϣ����ά������ɶ�user_info��ķ�װ��������ɶԸñ�����ӡ��޸ġ�ɾ��������
 *��д�ˣ���
 *��дʱ�䣺2014-09-11
 ********************************************************************/
package com.bws.util;

import com.bws.dbOperation.DBOperation;

import java.util.Vector;

public class UserObj extends entityObj {
    protected String UserID = "";
    protected String UserAccount = "";
    protected String UserPassword = "";
    protected String UserName = "";
    protected String CompanyID = "";
    protected String DeptID = "";
    protected String Position = "";
    protected String RoleID = "";
    protected String EMail = "";
    protected String Phone = "";
    protected String Mobile = "";
    protected String Status = "";
    protected String PageSize = "";
    protected String MicroMSG = "";
    protected String QQNO = "";


    public UserObj() {
    }

    public UserObj(String UserID, String UserAccount, String UserPassword, String UserName, String CompanyID, String DeptID, String Position, String RoleID, String EMail, String Phone, String Mobile, String Status, String PageSize, String MicroMSG, String QQNO) {
        this.UserID = UserID;
        this.UserAccount = UserAccount;
        this.UserPassword = UserPassword;
        this.UserName = UserName;
        this.CompanyID = CompanyID;
        this.DeptID = DeptID;
        this.Position = Position;
        this.RoleID = RoleID;
        this.EMail = EMail;
        this.Phone = Phone;
        this.Mobile = Mobile;
        this.Status = Status;
        this.PageSize = PageSize;
        this.MicroMSG = MicroMSG;
        this.QQNO = QQNO;
    }

    public boolean Load(String UserID, DBOperation db) {
        Vector<Vector<String>> ve = new Vector<Vector<String>>();
        ve = db.executeQueryVt("select * from odccbim.user_info where user_id= " + UserID);
        if (ve == null || ve.size() == 0) {
            return false;
        }
        this.UserID = ve.elementAt(0).elementAt(0).toString();
        this.UserAccount = ve.elementAt(0).elementAt(1).toString();
        this.UserPassword = ve.elementAt(0).elementAt(2).toString();
        this.UserName = ve.elementAt(0).elementAt(3).toString();
        this.CompanyID = ve.elementAt(0).elementAt(4).toString();
        this.DeptID = ve.elementAt(0).elementAt(5).toString();
        this.Position = ve.elementAt(0).elementAt(6).toString();
        this.RoleID = ve.elementAt(0).elementAt(7).toString();
        this.EMail = ve.elementAt(0).elementAt(8).toString();
        this.Phone = ve.elementAt(0).elementAt(9).toString();
        this.Mobile = ve.elementAt(0).elementAt(10).toString();
        this.Status = ve.elementAt(0).elementAt(11).toString();
        this.PageSize = ve.elementAt(0).elementAt(12).toString();
        this.MicroMSG = ve.elementAt(0).elementAt(13).toString();
        this.QQNO = ve.elementAt(0).elementAt(14).toString();
        return true;
    }

    public String getInStr() {
        String str = "";
        str = "insert into odccbim.user_info(user_id,user_account,user_password,user_name,company_ID,dept_ID,position,role_ID,email,phone,mobile,status,page_size,micro_MSG,QQ_NO) values("
                + this.UserID + ",'" + this.UserAccount
                + "','" + this.UserPassword
                + "','" + this.UserName
                + "'," + this.CompanyID
                + "," + this.DeptID
                + ",'" + this.Position
                + "'," + this.RoleID
                + ",'" + this.EMail
                + "','" + this.Phone
                + "','" + this.Mobile
                + "'," + this.Status
                + "," + this.PageSize
                + ",'" + this.MicroMSG
                + "','" + this.QQNO
                + "')";
        return str;
    }

    public String getUpdateStr() {
        String str = "";
        str = "update odccbim.user_info set user_id=" + UserID + ","
                + "user_account='" + UserAccount + "',"
                + "user_password='" + UserPassword + "',"
                + "user_name='" + UserName + "',"
                + "company_ID=" + CompanyID + ","
                + "dept_ID=" + DeptID + ","
                + "position='" + Position + "',"
                + "role_ID=" + RoleID + ","
                + "email='" + EMail + "',"
                + "phone='" + Phone + "',"
                + "mobile='" + Mobile + "',"
                + "status=" + Status + ","
                + "page_size=" + PageSize + ","
                + "micro_MSG='" + MicroMSG + "',"
                + "QQ_NO='" + QQNO + "'"
                + " where user_id= " + UserID;
        return str;
    }

    public String getDelStr() {
        String str = "";
        str = "delete from odccbim.user_info where user_id= " + UserID;
        return str;
    }

    public String getUserID() {
        return UserID;
    }

    public void setUserID(String newUserID) {
        UserID = newUserID;
    }

    public String getUserAccount() {
        return UserAccount;
    }

    public void setUserAccount(String newUserAccount) {
        UserAccount = newUserAccount;
    }

    public String getUserPassword() {
        return UserPassword;
    }

    public void setUserPassword(String newUserPassword) {
        UserPassword = newUserPassword;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String newUserName) {
        UserName = newUserName;
    }

    public String getCompanyID() {
        return CompanyID;
    }

    public void setCompanyID(String newCompanyID) {
        CompanyID = newCompanyID;
    }

    public String getDeptID() {
        return DeptID;
    }

    public void setDeptID(String newDeptID) {
        DeptID = newDeptID;
    }

    public String getPosition() {
        return Position;
    }

    public void setPosition(String newPosition) {
        Position = newPosition;
    }

    public String getRoleID() {
        return RoleID;
    }

    public void setRoleID(String newRoleID) {
        RoleID = newRoleID;
    }

    public String getEMail() {
        return EMail;
    }

    public void setEMail(String newEMail) {
        EMail = newEMail;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String newPhone) {
        Phone = newPhone;
    }

    public String getMobile() {
        return Mobile;
    }

    public void setMobile(String newMobile) {
        Mobile = newMobile;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String newStatus) {
        Status = newStatus;
    }

    public String getPageSize() {
        return PageSize;
    }

    public void setPageSize(String newPageSize) {
        PageSize = newPageSize;
    }

    public String getMicroMSG() {
        return MicroMSG;
    }

    public void setMicroMSG(String newMicroMSG) {
        MicroMSG = newMicroMSG;
    }

    public String getQQNO() {
        return QQNO;
    }

    public void setQQNO(String newQQNO) {
        QQNO = newQQNO;
    }
}