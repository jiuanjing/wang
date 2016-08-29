/*******************************************************************************************
 *�������ƣ�SelectValueObj.java
 *����˵�����ó����Ƕ�ϵͳ�е�SelectValue����з�װ��������ɶԱ���ֵ�Ĺ���.
 *��д�ˣ����
 *��дʱ�䣺2004-7-7
 **********************************************************************************************/
package com.bws.util;

import com.bws.dbOperation.DBOperation;

import java.util.Vector;

public class SelectValueObj //extends entityObj
{
    protected String SelectValue = "";
    protected String SelectName = "";
    protected String TypeID = "";
    protected String State = "";

    public SelectValueObj() {
    }

    public SelectValueObj(String SelectValue, String SelectName, String TypeID, String State) {
        this.SelectValue = SelectValue;
        this.SelectName = SelectName;
        this.TypeID = TypeID;
        this.State = State;

    }

    public boolean Load(String SelectValue, String TypeID, DBOperation db) {
        Vector<Vector<String>> ve = new Vector<Vector<String>>();
        ve = db.executeQueryVt("select * from SelectValue where " + "SelectValue= '" + SelectValue + "' and TypeID='" + TypeID + "'");
        if (ve == null || ve.size() == 0) {
            return false;
        }
        this.SelectValue = ((Vector<String>) (ve.elementAt(0))).elementAt(0).toString();
        this.SelectName = ((Vector<String>) (ve.elementAt(0))).elementAt(1).toString();
        this.TypeID = ((Vector<String>) (ve.elementAt(0))).elementAt(2).toString();
        this.State = ((Vector<String>) (ve.elementAt(0))).elementAt(3).toString();

        return true;
    }

    public String getInStr() {
        String str = "";
        str = " insert  into SelectValue(SelectValue,SelectName,TypeID,State) SelectNames('" + this.SelectValue + "'," + "'" + this.SelectName + "','" + this.TypeID + "'," + "'" + this.State + "'" + ")";
        return str;
    }

    public String getUpdateStr() {
        String str = "";
        str = "update SelectValue set " + "SelectValue='" + SelectValue + "'," + "SelectName='" + SelectName + "'," + "TypeID='" + TypeID + "'," + "State='" + State + "'" + " where " + "SelectValue= '" + SelectValue + "' and TypeID='" + this.TypeID + "'";
        return str;
    }

    public String getDelStr() {
        String str = "";
        str = "delete from SelectValue  where " + "SelectValue= '" + SelectValue + "' and TypeID='" + this.TypeID + "'";
        return str;
    }
}