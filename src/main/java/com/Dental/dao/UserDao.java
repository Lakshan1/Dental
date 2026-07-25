package com.Dental.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.Dental.db.DBConnection;
import com.Dental.model.User;

public class UserDao {
    // Method to retrieve a user by email from the database
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";

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
            e.printStackTrace();
        }
        return null; // Return null if the user is not found
    }
    
}
