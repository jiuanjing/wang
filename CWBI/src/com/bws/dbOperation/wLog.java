/***************************************
 �������ƣ�	wLog
 ���ܣ�		�ṩϵͳд����͹�����־�Ĺ���
 ���ߣ�		��
 ��д���ڣ�	2014-8-15
 ****************************************/

/********************************************************
 �÷�˵����
 ��import�������ã�Ȼ��ʵ������

 �����ṩ��ϵͳд��־�Ĺ��ܡ�
 ��־����Ϊ���֣�һ���� ������־����һ���� ������־��
 �ó���ÿ���Զ�����һ���µ���־�ļ����ļ�����Ϊ
 Error_2014-08-09.log
 Work_2014-08-09.log

 ������
 public wLog(String lg) //���췽��
 ʹ��ʱ�����ȵ��ø÷���
 lgΪ������ֻ��ȡ����ֵ��error �� work
 ���磺
 wLog errLog = new wLog("error")
 public wLog(String lg,String fn)
 lgΪ�����ַ���������������
 fnΪ�ļ�·�����ļ����Ƶ����崮
 ���磺
 wLog wg = new wLog("draft","c:\\draft\\draft2001.txt");

 public void writeLog(String wt)	//д��־����
 �ó����Զ��������ں�ʱ��
 ��־��¼Ϊ��
 [2014-08-09 09:10:07]  wt
 ����wtΪ������Ҫд������

 public char[] getLog()
 ��ȡ�ļ�����

 public int getFileLength()
 ��ȡ�ļ�����

 public boolean FileDelete()
 ɾ���ļ�

 *********************************************************/
package com.bws.dbOperation;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Calendar;
import java.util.ResourceBundle;

public class wLog {
    private String tmpDay = null;
    private String tmpTime = null;
    //private Date 	dt		 			= null;
    private String wType = null;
    private String nameOfTextFile = null;

    //ȱʡд���������־
    public wLog(String lg) {
        wType = "";
        if (lg.equals("error")) wType = "Error_";
        if (lg.equals("work")) wType = "Work_";
    }

    //�������ļ�����ʱ��Ϊһ���ļ�����
    public wLog(String lg, String fn) {
        wType = "";
        if (lg.equals("error")) wType = "Error_";
        if (lg.equals("work")) wType = "Work_";
        nameOfTextFile = fn;
    }

    //д��¼
    public void writeLog(String wt) {
        Calendar cal = Calendar.getInstance();
        int y = cal.get(Calendar.YEAR);
        int m = cal.get(Calendar.MONTH) + 1;
        int d = cal.get(Calendar.DATE);
        int h = cal.get(Calendar.HOUR_OF_DAY);
        int min = cal.get(Calendar.MINUTE);
        int s = cal.get(Calendar.SECOND);
        int ms = cal.get(Calendar.MILLISECOND);
        tmpDay = Integer.toString(y) + "-" + Integer.toString(m) + "-" + Integer.toString(d);
        tmpTime = tmpDay + " " + Integer.toString(h) + ":" + Integer.toString(min) + ":" + Integer.toString(s) + ":" + Integer.toString(ms);
        //���ļ�����

        String logPath = "";
        //����ϵͳ�����ļ�
        ResourceBundle rb = ResourceBundle.getBundle("sys");
        logPath = rb.getString("log_dir");

        if (nameOfTextFile == null) nameOfTextFile = logPath + wType + tmpDay + ".log";
        //��ȡ�ļ����Ȳ���������
        File fl = new File(nameOfTextFile);
        int flen = (int) fl.length();
        char file_content[] = new char[flen];

        //�ļ�����
        try {
            FileReader fis = new FileReader(nameOfTextFile);
            flen = fis.read(file_content);
            fis.close();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }

        //��ʱ
        //long ds=dt.getTime();
        //while(dt.getTime()-ds > 50)
        //	{}

        //д�ļ�����
        //String nameOfTextFile = logPath + wType + tmpDay + ".log";
        try {
            String head = "[" + tmpDay + " " + tmpTime + "]  " + wt;
            FileWriter pw = new FileWriter(nameOfTextFile);
            pw.write(head);
            pw.write(file_content, 0, flen);
            pw.close();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }

    }

    //��ȡ�ļ�����
    public int getFileLength() {
        File fl = new File(nameOfTextFile);
        int flen = (int) fl.length();
        return flen;
    }

    //ɾ���ļ�
    public boolean FileDelete() {
        File fl = new File(nameOfTextFile);
        return fl.delete();
    }

    //��ȡ��¼���� char[]
    public char[] getLog() {
        //��ȡ�ļ����Ȳ���������
        File fl = new File(nameOfTextFile);
        int flen = (int) fl.length();
        char file_content[] = new char[flen];

        //�ļ�����
        try {
            FileReader fis = new FileReader(nameOfTextFile);
            flen = fis.read(file_content);
            fis.close();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }

        return file_content;
    }
}

