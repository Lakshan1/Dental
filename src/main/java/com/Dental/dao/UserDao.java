package com.Dental.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.Dental.db.DBConnection;
import com.Dental.model.User;

public class UserDao {
    // Method to retrieve a user by email from the database.
    // Only staff roles can log in - dentists (doctor) and patients cannot,
    // so they are excluded here even though they exist in the users table.
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ? AND role IN ('staff', 'admin')";

        // Database connection and query execution logic
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email); // set the email parameter in the SQL query
            ResultSet resultSet = statement.executeQuery(); // Execute the query and get the result set

            if (resultSet.next()) {
                // Create and return a User object based on the retrieved data
                User user = new User(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("email"),
                    resultSet.getString("passwordHash"),
                    resultSet.getString("role"),
                    resultSet.getString("status")
                );
                return user;
            } 
        } catch (SQLException e) {
            // Deliberately NOT swallowed into a null return here: a DB connectivity
            // problem (wrong host/creds/unreachable) must look different from "no
            // such user", otherwise both show the same "Invalid email or password"
            // and there's no way to tell which one you're looking at from the login
            // page alone. Letting it propagate surfaces a 500 error page instead -
            // a clear, immediate signal it's a DB problem, not bad credentials.
            throw new RuntimeException("Database error while looking up user by email", e);
        }
        return null; // Return null if the user is not found (query ran fine, no match)
    }
    
}
