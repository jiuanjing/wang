package com.bws.dbOperation;

import java.sql.*;
import java.util.Hashtable;
import java.util.Vector;

public class DBOperation {
    private Connection conn = null;
    private Statement stmt = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    private boolean AutoCommit;
    private String fileName = null;
    private SQLException Ex = null;
    private wLog errLog = new wLog("error");
    private boolean isNull = false;

    public DBOperation() {
        AutoCommit = true;
    }

    public DBOperation(boolean AC) {
        AutoCommit = AC;
    }

    //建立数据库访问Connection
    public Connection getConn() {
        try {
            //建立数据库连接(jndi方式)
//            Context initCtx = null;
//            initCtx = new InitialContext();
//            DataSource ds = (DataSource) initCtx.lookup("cwbi");

            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "echarts", "Welcome1");

            conn.setAutoCommit(AutoCommit);
        } catch (java.lang.SecurityException e) {
            errLog.writeLog("database Connection:  " + e.toString() + "\r\n");
        } catch (java.sql.SQLException e) {
            Ex = e;
        } catch (Exception e) {
            errLog.writeLog("database Connection:  " + e.toString() + "\r\n");
        }

        if (Ex != null) {
            errLog.writeLog("database Connection:  " + Ex.toString() + "\r\n");
        }

        return conn;
    }

    public PreparedStatement getPrepareStmt(String sqlstr) {
        try {
            if (pstmt != null) {
                pstmt.close();
                pstmt = null;
            } else {
                pstmt = null;
            }
            pstmt = conn.prepareStatement(sqlstr);

            return pstmt;

        } catch (SQLException e) {
            return null;
        }
    }

    public Statement getStmt() {
        try {
            if (stmt != null) {
                stmt.close();
                stmt = null;
            } else {
                stmt = null;
            }
            stmt = conn.createStatement();

            return stmt;
        } catch (SQLException e) {
            return null;
        }
    }

    //打开对数据库的访问
    public boolean dbOpen() {
        if (conn == null) {
            conn = getConn();
        }
        if (conn != null) {
            return true;
        } else {
            return false;
        }
    }

    //关闭对数据库的访问
    public boolean dbClose() {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
            return true;
        } catch (Exception e) {
            errLog.writeLog("dbClose()  Exception:  " + e.toString());
            return false;
        }
    }

    //执行提交
    public boolean executeCommit() {
        boolean Successed = false;
        try {
            conn.commit();
            Successed = true;
        } catch (SQLException e) {
            Ex = e;
        }

        if (Ex != null) {
            errLog.writeLog("Program:  " + fileName + "\r\n                       SQL:  commit" + "                       SQLException:  " + Ex.toString() + "\r\n");
            Successed = false;
        }

        return Successed;
    }

    //执行回滚
    public boolean executeRollback() {
        boolean Successed = false;
        try {
            conn.rollback();
            Successed = true;
        } catch (SQLException e) {
            Ex = e;
        }

        if (Ex != null) {
            errLog.writeLog("Program:  " + fileName + "\r\n                       SQL:  rollback" + "                       SQLException:  " + Ex.toString() + "\r\n");
            Successed = false;
        }

        return Successed;
    }

    public void closeStmt() {
        try {
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //执行对数据库的更改操作
    public int executeUpdate(String sqlQuery) {
        int count = -1;
        rs = null;
        stmt = null;
        try {
            stmt = conn.createStatement();
            //sqlQuery=new String(sqlQuery.getBytes("ISO-8859-1"),"GBK");
            count = stmt.executeUpdate(sqlQuery);
            if (count != -1) {
                if (AutoCommit) conn.commit();
            }
            stmt.close();
        } catch (SQLException e) {
            Ex = e;
        } catch (Exception e) {
            errLog.writeLog("Program:  " + fileName + "\r\n                       SQL:  " + sqlQuery + "\r\n                       Exception:  " + e.toString() + "\r\n");
        }

        if (Ex != null)
            errLog.writeLog("Program:  " + fileName + "\r\n                       SQL:  " + sqlQuery + "\r\n                       SQL Error Code:  " + String.valueOf(Ex.getErrorCode()) + "\r\n" + "                       SQL Exception:   " + Ex.toString() + "\r\n");

        return count;
    }

    //该方法是根据传入的数据库查询语句，返回一个可以滚动的记录集
    public ResultSet executeQuery(String sql) {
        rs = null;
        try {
            stmt = null;
            if (dbOpen()) {
                stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
                rs = stmt.executeQuery(sql);
            } else {
                errLog.writeLog("未能打开数据库，execquery connection is null \r\n");
            }
        } catch (SQLException ex) {
            System.err.println("sql_data.executeQuery:" + ex.getMessage());
        }
        return rs;
    }

    //执行数据库查询语句返回向量类型的数据
    public Vector<Vector<String>> executeQueryVt(String sqlQuery) {
        Vector<Vector<String>> vRS = new Vector<Vector<String>>();
        stmt = null;
        rs = null;
        try {
            if (dbOpen()) {
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sqlQuery);
                if (!vRS.isEmpty()) vRS.removeAllElements();
                //Get the ResultSetMetaData. This will be used for the column headings
                ResultSetMetaData rsmd = rs.getMetaData();
                //Get the number of columns in the result set
                int numCols = rsmd.getColumnCount();
                boolean more = rs.next();
                while (more) {
                    //Found=true;
                    Vector<String> columns = new Vector<String>();
                    for (int i = 1; i <= numCols; i++) {
                        String tempStr = rs.getString(i);
                        if (tempStr == null) tempStr = "";
                        tempStr = tempStr.trim();
                        columns.addElement(tempStr);
                    }
                    vRS.addElement(columns);
                    more = rs.next();
                }
                rs.close();
                stmt.close();
            } else {
                errLog.writeLog("未能打开数据库，execquery connection is null \r\n");
            }
        } catch (SQLException e) {
            Ex = e;
        } catch (Exception ec) {
            return (Vector<Vector<String>>) null;
        }
        //如果出错写错误日志，主要用于获取程序调试时和数据分析时的SQL语句执行出错的信息。
        if (Ex != null) {
            errLog.writeLog("Program:  " + fileName + "\r\n                       SQL:  " + sqlQuery + "\r\n                       SQL Error Code:  " + String.valueOf(Ex.getErrorCode()) + "\r\n" + "                       SQL Exception:   " + Ex.toString() + "\r\n");
            return (Vector<Vector<String>>) null;
        }
        return vRS;
    }

    //该方法是根据传入的一个SQL语句，和当前页数、每页的记录数，返回一个指定的行数。
    public Vector<Vector<String>> executeQueryPage(String sqlstr, int currPage, int rowCount) {
        try {
            Vector<Vector<String>> ve = executeQueryVt(sqlstr);
            if (ve == null) {
                return null;
            } else if (ve.size() < rowCount)//如果当前的查询记录的总行数，小于一页显示的记录数，则不做分页处理
            {
                return ve;
            } else {
                Vector<Vector<String>> re_ve = new Vector<Vector<String>>();
                int begin_row = (currPage - 1) * rowCount;
                int end_row = currPage * rowCount;
                for (int i = begin_row; i < ve.size(); i++) {
                    Vector<String> v = (Vector<String>) ve.elementAt(i);
                    re_ve.addElement(v);
                    if (i > end_row) {
                        break;
                    }
                }
                ve = null;//释放VE所占用的内存
                return re_ve;
            }
        } catch (Exception e) {
            return null;
        }

    }

    //获得数据集
    public Vector<Hashtable<String, String>> getDbResultSet(String sql) {
        Statement stmt = null;
        ResultSet rset = null;
        ResultSetMetaData rsmd = null;
        Vector<Hashtable<String, String>> vct = new Vector<Hashtable<String, String>>();
        Vector<String[]> vcp = new Vector<String[]>();

        int columnCount = 0;
        //boolean flag = true;

        try {
            stmt = conn.createStatement();
            if (stmt == null) return null;
            rset = stmt.executeQuery(sql);
            if (rset == null) return null;
            rsmd = rset.getMetaData();
            if (rsmd == null) return null;
            columnCount = rsmd.getColumnCount();    //得到字段数量
            if (columnCount == 0) return null;

            //String[] type = new String[columnCount];
            String[] keys = new String[columnCount];
            //String[] columnSize = new String[columnCount];
            //String[] isNullable = new String[columnCount];

            for (int i = 1; i <= columnCount; i++) {
                keys[i - 1] = rsmd.getColumnName(i);     //获得字段名
            }
            vcp.add(keys);
            while (rset.next()) {
                Hashtable<String, String> rht = new Hashtable<String, String>();
                rht.clear();
                for (int i = 1; i <= columnCount; i++) {
                    String result = rset.getString(i);
                    if (result == null) result = "null";
                    rht.put(keys[i - 1], result);        //将每条记录保存到一个哈希表中，key为字段名，result为值
                }
                vct.add(rht);               //将数据集的每一行插入向量
            }
        } catch (Exception e) {
            System.out.println("Get Date Set Error:" + e);
            return null;
        } finally {
            try {
                rset.close();
                stmt.close();
                dboFree(conn);
            } catch (SQLException e) {
                dboFree(conn);
                System.out.println("Rset Rr Stmt Close Error");
                return null;
            }
        }
        return vct;        //返回SQL语言的查询结果集。
    }//end of getDbResultSet

    //获得数据集
    public Vector<Hashtable<String, String>> getDbRS(String sql) {
        Statement stmt = null;
        ResultSet rset = null;
        ResultSetMetaData rsmd = null;
        Vector<Hashtable<String, String>> vct = new Vector<Hashtable<String, String>>();
        Vector<String[]> vcp = new Vector<String[]>();

        int columnCount = 0;

        try {
            stmt = conn.createStatement();
            if (stmt == null) return null;
            rset = stmt.executeQuery(sql);
            if (rset == null) return null;
            rsmd = rset.getMetaData();
            if (rsmd == null) return null;
            columnCount = rsmd.getColumnCount();    //得到字段数量
            if (columnCount == 0) return null;

            String[] keys = new String[columnCount];

            for (int i = 1; i <= columnCount; i++) {
                keys[i - 1] = rsmd.getColumnName(i);     //获得字段名
            }

            vcp.add(keys);

            while (rset.next()) {
                Hashtable<String, String> rht = new Hashtable<String, String>();
                rht.clear();
                for (int i = 1; i <= columnCount; i++) {
                    String result = rset.getString(i);
                    if (result == null) result = "null";
                    rht.put(keys[i - 1], result);        //将每条记录保存到一个哈希表中，key为字段名，result为值
                }


                vct.add(rht);               //将数据集的每一行插入向量
            }
        } catch (Exception e) {
            System.out.println("Get Date Set Error:" + e);
            return null;
        } finally {
            try {
                rset.close();
                stmt.close();

            } catch (SQLException e) {
                System.out.println("Rset Rr Stmt Close Error");
                return null;
            }
        }
        return vct;        //返回SQL语言的查询结果集。
    }//end of getDbResultSet


    //修改、插入、删除
    public boolean updateDb(String sql) {
        boolean flag = false;
        Statement stmt = null;
        try {
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            flag = true;
        } catch (Exception e) {
            System.out.println("Date Update Error:" + e);
        } finally {
            try {
                stmt.close();
                dboFree(conn);
            } catch (SQLException e) {
                dboFree(conn);
                System.out.println("Rset Rr Stmt Close Error");
                return false;
            }
        }
        return flag;        //对SQL语言操作成功返回true，失败返回false。
    }//end of updateDb.

    //修改、插入、删除
    public boolean updDb(String sql) {
        boolean flag = false;
        Statement stmt = null;
        try {
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            flag = true;
        } catch (Exception e) {
            System.out.println("Date Update Error:" + e);
        } finally {
            try {
                stmt.close();
            } catch (SQLException e) {
                System.out.println("Rset Rr Stmt Close Error");
                return false;
            }
        }
        return flag;        //对SQL语言操作成功返回true，失败返回false。
    }//end of updateDb.

    public void dboFree() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.out.print("Connection Close Error :" + e);
            }
        }
    }

    public void dboFree(Connection coninner) {
        if (coninner != null) {
            try {
                coninner.close();
            } catch (SQLException e) {
                System.out.print("Connection Close Error :" + e);
            }
        }
    }

    public boolean isNull() {
        return isNull;
    }
}
