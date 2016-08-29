/*******************************************************************
 *�������ƣ�DepartmentObj.java
 *����˵�����Բ�����Ϣ����ά������ɶ�department��ķ�װ��������ɶԸñ�����ӡ��޸ġ�ɾ��������
 *��д�ˣ���
 *��дʱ�䣺2014-09-12
 ********************************************************************/
package com.bws.util;

import com.bws.dbOperation.DBOperation;

import java.util.Vector;

public class DepartmentObj extends entityObj {
    protected String DeptID = "";
    protected String DeptCode = "";
    protected String DeptName = "";
    protected String DeptDesc = "";
    protected String OrderNO = "";
    protected String DeptLevel = "";

    public DepartmentObj() {
    }

    public DepartmentObj(String DeptID, String DeptCode, String DeptName, String DeptDesc, String OrderNO, String DeptLevel) {
        this.DeptID = DeptID;
        this.DeptCode = DeptCode;
        this.DeptName = DeptName;
        this.DeptDesc = DeptDesc;
        this.OrderNO = OrderNO;
        this.DeptLevel = DeptLevel;
    }

    public boolean Load(String DeptID, DBOperation db) {
        Vector<Vector<String>> ve = new Vector<Vector<String>>();
        ve = db.executeQueryVt("select * from odccbim.department where dept_id= " + DeptID);
        if (ve == null || ve.size() == 0) {
            return false;
        }
        this.DeptID = ve.elementAt(0).elementAt(0).toString();
        this.DeptCode = ve.elementAt(0).elementAt(1).toString();
        this.DeptName = ve.elementAt(0).elementAt(2).toString();
        this.DeptDesc = ve.elementAt(0).elementAt(3).toString();
        this.OrderNO = ve.elementAt(0).elementAt(4).toString();
        this.DeptLevel = ve.elementAt(0).elementAt(5).toString();
        return true;
    }

    public String getInStr() {
        String str = "";
        str = "insert into odccbim.department(dept_id,dept_code,dept_name,dept_desc,order_no,dept_level) values("
                + this.DeptID + ",'" + this.DeptCode
                + "','" + this.DeptName
                + "','" + this.DeptDesc
                + "'," + this.OrderNO
                + "," + this.DeptLevel
                + ")";
        return str;
    }

    public String getUpdateStr() {
        String str = "";
        str = "update odccbim.department set dept_id=" + DeptID + ","
                + "dept_code='" + DeptCode + "',"
                + "dept_name='" + DeptName + "',"
                + "dept_desc='" + DeptDesc + "',"
                + "order_no=" + OrderNO + ","
                + "dept_level=" + DeptLevel
                + " where dept_id= " + DeptID;
        return str;
    }

    public String getDelStr() {
        String str = "";
        str = "delete from odccbim.department where dept_id=" + DeptID;
        return str;
    }

    public String getDeptID() {
        return this.DeptID;
    }

    public void setDeptID(String str) {
        this.DeptID = str;
    }

    public String getDeptCode() {
        return this.DeptCode;
    }

    public void setDeptCode(String str) {
        this.DeptCode = str;
    }

    public String getDeptName() {
        return this.DeptName;
    }

    public void setDeptName(String str) {
        this.DeptName = str;
    }

    public String getDeptDesc() {
        return this.DeptDesc;
    }

    public void setDeptDesc(String str) {
        this.DeptDesc = str;
    }

    public String getOrderNO() {
        return this.OrderNO;
    }

    public void setOrderNO(String str) {
        this.OrderNO = str;
    }

    public String getDeptLevel() {
        return this.DeptLevel;
    }

    public void setDeptLevel(String str) {
        this.DeptLevel = str;
    }
}