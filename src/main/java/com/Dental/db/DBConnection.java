package com.Dental.db;

public class DBConnection {
    // Database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/dental_db";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Force the MySQL driver to load + register via THIS webapp's classloader.
    // Without this, "No suitable driver" can occur even with the jar in WEB-INF/lib
    // (auto-registration is unreliable across Tomcat hot-redeploys).
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found on classpath", e);
        }
    }

    // Method to establish a connection to the database
    public static java.sql.Connection getConnection() throws java.sql.SQLException {
        return java.sql.DriverManager.getConnection(URL, USER, PASSWORD);
    }
}