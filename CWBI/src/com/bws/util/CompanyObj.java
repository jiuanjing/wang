/*******************************************************************
 *�������ƣ�CompanyObj.java
 *����˵�����Ե�λ��Ϣ����ά������ɶ�company��ķ�װ��������ɶԸñ�����ӡ��޸ġ�ɾ��������
 *��д�ˣ���
 *��дʱ�䣺2014-09-12
 ********************************************************************/
package com.bws.util;

import com.bws.dbOperation.DBOperation;

import java.util.Vector;

public class CompanyObj extends entityObj {
    protected String CompanyID = "";
    protected String CompanyCode = "";
    protected String CompanyName = "";
    protected String BriefName = "";
    protected String OrderNO = "";
    protected String CompanyLevel = "";

    public CompanyObj() {
    }

    public CompanyObj(String CompanyID, String CompanyCode, String CompanyName, String BriefName, String OrderNO, String CompanyLevel) {
        this.CompanyID = CompanyID;
        this.CompanyCode = CompanyCode;
        this.CompanyName = CompanyName;
        this.BriefName = BriefName;
        this.OrderNO = OrderNO;
        this.CompanyLevel = CompanyLevel;
    }

    public boolean Load(String CompanyID, DBOperation db) {
        Vector<Vector<String>> ve = new Vector<Vector<String>>();
        ve = db.executeQueryVt("select * from odccbim.company where company_id= " + CompanyID);
        if (ve == null || ve.size() == 0) {
            return false;
        }
        this.CompanyID = ve.elementAt(0).elementAt(0).toString();
        this.CompanyCode = ve.elementAt(0).elementAt(1).toString();
        this.CompanyName = ve.elementAt(0).elementAt(2).toString();
        this.BriefName = ve.elementAt(0).elementAt(3).toString();
        this.OrderNO = ve.elementAt(0).elementAt(4).toString();
        this.CompanyLevel = ve.elementAt(0).elementAt(5).toString();
        return true;
    }

    public String getInStr() {
        String str = "";
        str = "insert into odccbim.company(company_id,company_code,company_name,brief_name,order_no,company_level) values("
                + this.CompanyID + ",'" + this.CompanyCode
                + "','" + this.CompanyName
                + "','" + this.BriefName
                + "'," + this.OrderNO
                + "," + this.CompanyLevel
                + ")";
        return str;
    }

    public String getUpdateStr() {
        String str = "";
        str = "update odccbim.company set company_id=" + CompanyID + ","
                + "company_code='" + CompanyCode + "',"
                + "company_name='" + CompanyName + "',"
                + "brief_name='" + BriefName + "',"
                + "order_no=" + OrderNO + ","
                + "company_level=" + CompanyLevel
                + " where company_id= " + CompanyID;
        return str;
    }

    public String getDelStr() {
        String str = "";
        str = "delete from odccbim.company where company_id= " + CompanyID;
        return str;
    }

    public String getCompanyID() {
        return this.CompanyID;
    }

    public void setCompanyID(String str) {
        this.CompanyID = str;
    }

    public String getCompanyCode() {
        return this.CompanyCode;
    }

    public void setCompanyCode(String str) {
        this.CompanyCode = str;
    }

    public String getCompanyName() {
        return this.CompanyName;
    }

    public void setCompanyName(String str) {
        this.CompanyName = str;
    }

    public String getBriefName() {
        return this.BriefName;
    }

    public void setBriefName(String str) {
        this.BriefName = str;
    }

    public String getOrderNO() {
        return this.OrderNO;
    }

    public void setOrderNO(String str) {
        this.OrderNO = str;
    }

    public String getCompanyLevel() {
        return this.CompanyLevel;
    }

    public void setCompanyLevel(String str) {
        this.CompanyLevel = str;
    }
}