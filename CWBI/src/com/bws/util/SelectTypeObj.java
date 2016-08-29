/*********************************************************************************************************
 *�������ƣ�SelectTypeObj.java
 *�����������ó����Ƕ�ϵͳ�еı������ͱ���з�װ��������ɶԱ������͵����ӡ��޸ġ�ɾ���ȹ��ܡ�
 *��д�ˣ���
 *��дʱ�䣺2014-09-01
 *********************************************************************************************************/
package com.bws.util;

import com.bws.dbOperation.DBOperation;

import java.util.Hashtable;
import java.util.Vector;

public class SelectTypeObj //extends entityObj
{
    protected String TypeID = "";
    protected String TypeName = "";
    protected Vector<Vector<String>> ve_values = new Vector<Vector<String>>();
    protected Vector<Vector<String>> ve_Ky_val = new Vector<Vector<String>>();
    protected Hashtable<String, String> hs_values = new Hashtable<String, String>();

    public SelectTypeObj() {
    }

    public SelectTypeObj(String TypeID, String TypeName) {
        this.TypeID = TypeID;
        this.TypeName = TypeName;

    }

    public SelectTypeObj(String TypeID, DBOperation db) {
        try {
            this.TypeID = TypeID;
            //ȡ�ñ�ŵ����б���ֵ
            ve_values = db.executeQueryVt("select SelectValue,SelectName,State from SelectValue where TypeID='" + TypeID + "'");
            if (ve_values != null && ve_values.size() > 0) {
                for (int i = 0; i < ve_values.size(); i++) {
                    String id = ve_values.elementAt(i).elementAt(0).toString();
                    String name = ve_values.elementAt(i).elementAt(1).toString();
                    hs_values.put(id, name);
                }
            }
            //ȡ��ǰ���п��õı���ֵ
            ve_Ky_val = db.executeQueryVt("select SelectValue,SelectName,State from SelectValue where State=1 and TypeID='" + TypeID + "'");

        } catch (Exception e) {
        }
    }

    //����ѡ����ã�SelectTypeObj(String TypeID,DBOpration db)���췽��
    public String getSelectName(String SelectValue) {
        try {
            String name = hs_values.get(SelectValue).toString();
            return name;
        } catch (Exception e) {
            return "";
        }

    }

    //����ѡ����ã�SelectTypeObj(String TypeID,DBOpration db)���췽��
    //�÷����Ǹ��ݴ����һ���������б�����ơ���ѡ���ֵ������һ�������б��HTML��䡣
    public String getSelHtml(String selName, String selVal) {
        try {
            String html = "";
            //String sqlstr="";
            Vector<Vector<String>> ve = new Vector<Vector<String>>();

            if (selVal.equals("")) {
                ve = this.ve_Ky_val;
            } else {
                ve = this.ve_values;
            }

            html = "<select name=\"" + selName + "\" size=1>";

            for (int i = 0; i < ve.size(); i++) {
                String id = ve.elementAt(i).elementAt(0).toString();
                String name = ve.elementAt(i).elementAt(1).toString();
                String state = ve.elementAt(i).elementAt(2).toString();

                if (selVal.equals(id)) {
                    html = html + "<option value='" + id + "' selected>" + name + "</option>";
                } else if (state.equals("1")) {
                    html = html + "<option value='" + id + "'>" + name + "</option>";
                }
            }

            html = html + "</select>";

            return html;
        } catch (Exception e) {
            return "";
        }
    }

    //����ѡ����ã�SelectTypeObj(String TypeID,DBOpration db)���췽��
    //�÷����Ǹ��ݴ����һ���������б�����ơ���ѡ���ֵ������һ�������б��HTML��䡣
    public String getSeacherHtml(String selName, String selVal) {
        try {
            String html = "";
            //String sqlstr="";
            Vector<Vector<String>> ve = new Vector<Vector<String>>();

            if (selVal.equals("")) {
                ve = this.ve_Ky_val;
            } else {
                ve = this.ve_values;
            }

            html = "<select name=\"" + selName + "\" size=1>";
            html = html + "<option value='' >ȫ��</option>";
            for (int i = 0; i < ve.size(); i++) {
                String id = ve.elementAt(i).elementAt(0).toString();
                String name = ve.elementAt(i).elementAt(1).toString();
                String state = ve.elementAt(i).elementAt(2).toString();

                if (selVal.equals(id)) {
                    html = html + "<option value='" + id + "' selected>" + name + "</option>";
                } else if (state.equals("1")) {
                    html = html + "<option value='" + id + "'>" + name + "</option>";
                }
            }

            html = html + "</select>";

            return html;
        } catch (Exception e) {
            return "";
        }
    }


    public boolean Load(String TypeID, DBOperation db) {
        Vector<Vector<String>> ve = new Vector<Vector<String>>();
        ve = db.executeQueryVt("select * from SelectType where " + "TypeID= " + TypeID);
        if (ve == null || ve.size() == 0) {
            return false;
        }
        this.TypeID = ve.elementAt(0).elementAt(0).toString();
        this.TypeName = ve.elementAt(0).elementAt(1).toString();

        return true;
    }

    public String getInStr() {
        String str = "";
        str = " insert  into SelectType(TypeID,TypeName) values('" + this.TypeID + "'," + "'" + this.TypeName + "'" + ")";
        return str;
    }

    public String getUpdateStr() {
        String str = "";
        str = "update SelectType set " + "TypeID='" + TypeID + "'," + "TypeName='" + TypeName + "'" + " where " + "TypeID= '" + TypeID + "'";
        return str;
    }

    public String getDelStr() {
        String str = "";
        str = "delete from SelectType where " + "TypeID= '" + TypeID + "'";
        return str;
    }
}