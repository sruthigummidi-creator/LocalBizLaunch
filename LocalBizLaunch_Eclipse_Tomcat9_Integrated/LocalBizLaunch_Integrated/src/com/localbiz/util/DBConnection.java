package com.localbiz.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/localbiz_launch?useSSL=false&serverTimezone=Asia/Kolkata&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    // Replace this placeholder with your local MySQL password.
    private static final String PASSWORD = "sruthi72";
    private DBConnection() { }
    public static Connection getConnection() throws SQLException {
        try { Class.forName("com.mysql.cj.jdbc.Driver"); }
        catch (ClassNotFoundException e) { throw new SQLException("MySQL Connector/J is missing from WEB-INF/lib or the project build path.", e); }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
