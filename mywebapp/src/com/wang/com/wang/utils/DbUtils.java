package com.wang.com.wang.utils;

import java.sql.*;

/**
 * Created by wangdegang on 2016/9/4.
 */
public class DbUtils {
    private Connection connection;
    private ResultSet resultSet;

    public ResultSet executeQuery(String sql) throws SQLException {
        Statement statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        resultSet = statement.executeQuery(sql);
        return resultSet;
    }

    public boolean dbOpen() {

        if (connection == null) {
            connection = getConnection();
        }
        return true;
    }

    public Connection getConnection() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "wang", "1230");
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }
}
