package com.Dental.db;

public class DBConnection {
    // Database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/dental_db";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Method to establish a connection to the database
    public static java.sql.Connection getConnection() throws java.sql.SQLException {
        return java.sql.DriverManager.getConnection(URL, USER, PASSWORD);
    }
}