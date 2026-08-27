package com.Dental.db;

public class DBConnection {
    // Connection details come from environment variables (set by Docker /
    // Railway) and fall back to the local dev defaults when unset, so this
    // still works unchanged with a plain local Tomcat + XAMPP MySQL setup.
    private static final String HOST = env("DB_HOST", "localhost");
    private static final String PORT = env("DB_PORT", "3306");
    private static final String NAME = env("DB_NAME", "dental_db");
    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + NAME;
    private static final String USER = env("DB_USER", "root");
    private static final String PASSWORD = env("DB_PASSWORD", "");

    private static String env(String key, String fallback) {
        String value = System.getenv(key);
        return (value == null || value.isEmpty()) ? fallback : value;
    }

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