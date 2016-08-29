/************************************************************************************
 *�����ƣ�entityObj
 *��˵����ʵ�����Ͷ���Ĺ��û����������һЩ�����ԵĹ�����
 *��Ҫ���õ��ࣺ���ݿ���ʳ���javax.servert.http��
 *��д�ˣ���
 *��дʱ�䣺2014-09-03
 ***********************************************************************************/
package com.bws.util;
//import java.lang.reflect.*;

import com.bws.dbOperation.DBOperation;

//import java.util.*;
public class entityObj {

    public entityObj() {
    }

    //���ݸ�������������������Ϣд�����ݿ�
    public boolean saveObj(String Type, DBOperation db) {
        String sqlstr = "";
        if (Type.equals("insert")) {
            sqlstr = this.getInStr();
        }
        if (Type.equals("update")) {
            sqlstr = this.getUpdateStr();
        }
        if (Type.equals("delete")) {
            sqlstr = this.getDelStr();
        }
        if (Type.equals("deleteChoosed")) {
            sqlstr = this.getDeleteChoosedStr();
        }

        if (sqlstr == null || sqlstr.length() < 1) {
            return false;
        }

        int re = 0;
        re = db.executeUpdate(sqlstr);

        if (re != 1) {
            return false;
        }
        return true;
    }

    public String getInStr() {
        return "";
    }

    public String getUpdateStr() {
        return "";
    }

    public String getDelStr() {
        return "";
    }

    public String getDeleteChoosedStr() {
        return "";
    }
    /*****
     public Field getFieldObject(Class obj,String fname)
     {
     Field myField=null;
     try
     {
     myField=obj.getDeclaredField(fname);

     return myField;
     }catch(NoSuchFieldException nse)
     {
     Class supclass=obj.getSuperclass();

     if(supclass == null)
     {
     return null;
     }else
     {
     return getFieldObject(supclass,fname);
     }
     }
     }
     ******/

    /**
     * �÷����Ǹ��ݴ�������Ե����ƣ���ȡ��ǰʵ���ĸ����Ե�ֵ��ֻ���Ǽ����͵�����ִ��
     * �ò���������Ƕ������͵����ԣ��÷�������NULL
     * @param fname
     * @return Object
     */
    /*****
     public Object getFieldVal(String fname)
     {
     try
     {
     Field myField=getFieldObject(this.getClass(),fname);
     Object  val=null;
     val=myField.get(this);

     return val;

     }catch(Exception e)	   {

     return (Object)null;
     }
     }
     *****/


    /**
     * �÷����Ǹ��ݴ�������Ե����ƣ���ȡ��ǰʵ���ĸ����Ե�ֵ��ֻ���Ǽ����͵�����ִ��
     * �ò���������Ƕ������͵����ԣ��÷�������NULL,���ص�ֵ����ת��Ϊ��String
     * @param fname
     * @return String
     */
    /******
     public String getFieldValStr(String fname)
     {
     try
     {
     Field myField=getFieldObject(this.getClass(),fname);
     String  val=null;
     val=myField.get(this).toString();

     return val;

     }catch(Exception e)
     {
     return "";
     }
     }
     ******/

    //�����û�������������ƣ����ظ����Ե�ֵ
    /*******
     public String getField(String name)
     {
     Field[] myfield=this.getClass().getDeclaredFields();
     String obj="";
     try
     {
     for (int i=0;i<myfield.length ;i++ )
     {

     if (myfield[i].getName().equals(name))
     {

     return myfield[i].get(this).toString();
     }

     }
     }catch(Exception e)
     {

     return (String)null;
     }

     return (String)null;
     }
     ******/

    /**
     * �ô��������ö����е����Ե�ֵ��Ҫ�������������һ�������Ե����ƣ�һ�������Ե�ֵ
     * @param fname
     * @param obj
     * @return boolean
     */
    /******
     public boolean setField(String fname, Object obj)
     {
     try
     {
     Field myField=getFieldObject(this.getClass(),fname);
     myField.set(this,obj);
     return true;

     }catch(Exception e)
     {
     e.printStackTrace();
     return false;
     }
     }
     ********/

    /**
     * �ô��������ö����е����Ե�ֵ��Ҫ�������������һ�������Ե����ƣ�һ�������Ե�ֵ
     * @param fname
     * @param obj
     * @return boolean
     */

    /********
     public boolean setField(String fname, int obj)
     {
     try
     {
     Field myField=getFieldObject(this.getClass(),fname);
     myField.setInt(this,obj);
     return true;

     }catch(Exception e)
     {
     return false;
     }
     }
     ******/

    /**
     * �ô��������ö����е����Ե�ֵ��Ҫ�������������һ�������Ե����ƣ�һ�������Ե�ֵ
     * @param fname
     * @param obj
     * @return boolean
     */

    /******
     public boolean setField(String fname, float obj)
     {
     try
     {
     Field myField=getFieldObject(this.getClass(),fname);
     myField.setFloat(this,obj);
     return true;

     }catch(Exception e)
     {
     return false;
     }
     }
     ******/

    /**
     * �ô��������ö����е����Ե�ֵ��Ҫ�������������һ�������Ե����ƣ�һ�������Ե�ֵ
     * @param fname
     * @param obj
     * @return boolean
     */

    /*******
     public boolean setField(String fname, double obj)
     {
     try
     {
     Field myField=getFieldObject(this.getClass(),fname);
     myField.setDouble(this,obj);
     return true;

     }catch(Exception e)
     {
     return false;
     }
     }
     ******/

    /**
     * �ô��������ö����е����Ե�ֵ��Ҫ�������������һ�������Ե����ƣ�һ�������Ե�ֵ
     * @param fname
     * @param obj
     * @return boolean
     */

    /*******
     public boolean setField(String fname, long obj)
     {
     try
     {
     Field myField=getFieldObject(this.getClass(),fname);
     myField.setLong(this,obj);
     return true;

     }catch(Exception e)
     {
     return false;
     }
     }
     ******/

    /**
     * �ô��������ö����е����Ե�ֵ��Ҫ�������������һ�������Ե����ƣ�һ�������Ե�ֵ
     * @param fname
     * @param obj
     * @return boolean
     */

    /******
     public boolean setField(String fname, boolean obj)
     {
     try
     {
     Field myField=getFieldObject(this.getClass(),fname);
     myField.setBoolean(this,obj);
     return true;

     }catch(Exception e)
     {
     return false;
     }
     }
     ******/
}

