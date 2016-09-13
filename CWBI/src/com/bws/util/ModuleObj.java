/*******************************************************************
 *�������ƣ�ModuleObj.java
 *����˵������ģ����Ϣ����ά������ɶ�Module��ķ�װ��������ɶԸñ�����ӡ��޸ġ�ɾ��������
 *��д�ˣ���
 *��дʱ�䣺2014-09-03
 ********************************************************************/
package com.bws.util;

import com.bws.dbOperation.DBOperation;

import java.util.Vector;

public class ModuleObj extends entityObj {
    protected String ModuleID = "";
    protected String ModuleCode = "";
    protected String ModuleName = "";
    protected String URL = "";
    protected String ModuleLevel = "";
    protected String OrderNO = "";
    protected String Status = "";
    protected String HelpURL = "";
    protected String AddValueURL = "";
    protected String AccessMethod = "";

    public ModuleObj() {
    }

    public ModuleObj(String ModuleID, String ModuleCode, String ModuleName, String URL, String ModuleLevel, String OrderNO, String Status, String HelpURL, String AddValueURL, String AccessMethod) {
        this.ModuleID = ModuleID;
        this.ModuleCode = ModuleCode;
        this.ModuleName = ModuleName;
        this.URL = URL;
        this.ModuleLevel = ModuleLevel;
        this.OrderNO = OrderNO;
        this.Status = Status;
        this.HelpURL = HelpURL;
        this.AddValueURL = AddValueURL;
        this.AccessMethod = AccessMethod;
    }

    public boolean Load(String ModuleID, DBOperation db) {
        Vector<Vector<String>> ve = new Vector<Vector<String>>();
        ve = db.executeQueryVt("select * from bim.module where module_id= " + ModuleID);
        if (ve == null || ve.size() == 0) {
            return false;
        }
        this.ModuleID = ve.elementAt(0).elementAt(0).toString();
        this.ModuleCode = ve.elementAt(0).elementAt(1).toString();
        this.ModuleName = ve.elementAt(0).elementAt(2).toString();
        this.URL = ve.elementAt(0).elementAt(3).toString();
        this.ModuleLevel = ve.elementAt(0).elementAt(4).toString();
        this.OrderNO = ve.elementAt(0).elementAt(5).toString();
        this.Status = ve.elementAt(0).elementAt(6).toString();
        this.HelpURL = ve.elementAt(0).elementAt(7).toString();
        this.AddValueURL = ve.elementAt(0).elementAt(8).toString();
        this.AccessMethod = ve.elementAt(0).elementAt(9).toString();
        return true;
    }

    public String getInStr() {
        String str = "";
        str = "insert into bim.module(module_id,module_code,module_name,URL,module_level,order_NO,status,help_URL,add_value_URL,access_method) values("
                + this.ModuleID + ",'" + this.ModuleCode
                + "','" + this.ModuleName
                + "','" + this.URL
                + "'," + this.ModuleLevel
                + "," + this.OrderNO
                + "," + this.Status
                + ",'" + this.HelpURL
                + "','" + this.AddValueURL
                + "','" + this.AccessMethod
                + "')";
        return str;
    }

    public String getUpdateStr() {
        String str = "";
        str = "update bim.module set " + "module_id=" + ModuleID + ","
                + "module_code='" + ModuleCode + "',"
                + "module_name='" + ModuleName + "',"
                + "URL='" + URL + "',"
                + "module_level=" + ModuleLevel + ","
                + "order_NO=" + OrderNO + ","
                + "status=" + Status + ","
                + "help_URL='" + HelpURL + "',"
                + "add_value_URL='" + AddValueURL + "',"
                + "access_method='" + AccessMethod + "'"
                + " where module_id= " + ModuleID;
        return str;
    }

    public String getDelStr() {
        String str = "";
        str = "delete from bim.module where module_id= " + ModuleID;
        return str;
    }

    public String getModuleID() {
        return this.ModuleID;
    }

    public void setModuleID(String str) {
        this.ModuleID = str;
    }

    public String getModuleCode() {
        return this.ModuleCode;
    }

    public void setModuleCode(String str) {
        this.ModuleCode = str;
    }

    public String getModuleName() {
        return this.ModuleName;
    }

    public void setModuleName(String str) {
        this.ModuleName = str;
    }

    public String getURL() {
        return this.URL;
    }

    public void setURL(String str) {
        this.URL = str;
    }

    public String getModuleLevel() {
        return this.ModuleLevel;
    }

    public void setModuleLevel(String str) {
        this.ModuleLevel = str;
    }

    public String getOrderNO() {
        return this.OrderNO;
    }

    public void setOrderNO(String str) {
        this.OrderNO = str;
    }

    public String getStatus() {
        return this.Status;
    }

    public void setStatus(String str) {
        this.Status = str;
    }

    public String getHelpURL() {
        return this.HelpURL;
    }

    public void setHelpURL(String str) {
        this.HelpURL = str;
    }

    public String getAddValueURL() {
        return this.AddValueURL;
    }

    public void setAddValueURL(String str) {
        this.AddValueURL = str;
    }

    public String getAccessMethod() {
        return this.AccessMethod;
    }

    public void setAccessMethod(String str) {
        this.AccessMethod = str;
    }


}