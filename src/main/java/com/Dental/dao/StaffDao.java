package com.Dental.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Dental.db.DBConnection;
import com.Dental.model.User;

public class StaffDao {
    // Method to retrieve all the staffs
    public List<User> getAllStaffs() {
        String sql = "SELECT * FROM users WHERE role = 'admin'";

        try (Connection connection = DBConnection.getConnection()){
            // Execute the query and get the result set
            var statement = connection.createStatement();
            var resultSet = statement.executeQuery(sql);

            // Create an array to hold the User objects
            List<User> staffs = new ArrayList<>(); // Using ArrayList for dynamic sizing
            int index = 0;

            while (resultSet.next()) {
                // Create and add a User object to the array based on the retrieved data
                staffs.add(new User(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("email"),
                    resultSet.getString("passwordHash"),
                    resultSet.getString("role"),
                    resultSet.getString("status")
                ));
            }
            return staffs; // Return the array of staff members
        } catch (SQLException e){
            e.printStackTrace();
        }

        return null;
    }

    // Method to retrieve all the staffs with pagination
    public List<User> getAllStaffs(int page, int recordsPerPage) {
        String sql = "SELECT * FROM users WHERE role = 'admin' LIMIT ? OFFSET ?";

        try (Connection connection = DBConnection.getConnection();
    PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1, recordsPerPage);
            statement.setInt(2, (page - 1) * recordsPerPage);
            var resultSet = statement.executeQuery();

            // Create an array to hold the User objects
            List<User> staffs = new ArrayList<>(); // Using ArrayList for dynamic sizing

            while (resultSet.next()) {
                // Create and add a User object to the array based on the retrieved data
                staffs.add(new User(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("email"),
                    resultSet.getString("passwordHash"),
                    resultSet.getString("role"),
                    resultSet.getString("status")
                ));
            }
            return staffs; // Return the array of staff members
        } catch (SQLException e){
            e.printStackTrace();
        }

        return null;
    }

    public List<User> searchStaffs(String searchQuery) {
        String sql = "SELECT * FROM users WHERE role = 'admin' AND (name LIKE ? OR email LIKE ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            String searchPattern = "%" + searchQuery + "%";
            statement.setString(1, searchPattern);
            statement.setString(2, searchPattern);
            var resultSet = statement.executeQuery();

            List<User> staffs = new ArrayList<>();

            while (resultSet.next()) {
                staffs.add(new User(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("email"),
                    resultSet.getString("passwordHash"),
                    resultSet.getString("role"),
                    resultSet.getString("status")
                ));
            }
            return staffs;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public int getTotalActiveStaffCount() {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role = 'admin' AND status = 'active'";

        try (Connection connection = DBConnection.getConnection()){
            var statement = connection.createStatement();
            var resultSet = statement.executeQuery(sql);

            if (resultSet.next()) {
                return resultSet.getInt("total");
            }
        } catch (SQLException e){
            e.printStackTrace();
        }

        return 0;
    }

    public int getTotalStaffCount() {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role = 'admin'";

        try (Connection connection = DBConnection.getConnection()){
            var statement = connection.createStatement();
            var resultSet = statement.executeQuery(sql);

            if (resultSet.next()) {
                return resultSet.getInt("total");
            }
        } catch (SQLException e){
            e.printStackTrace();
        }

        return 0;
    }

    public int getTotalOnLeaveStaffCount() {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role = 'admin' AND status = 'leave'";

        try (Connection connection = DBConnection.getConnection()){
            var statement = connection.createStatement();
            var resultSet = statement.executeQuery(sql);

            if (resultSet.next()) {
                return resultSet.getInt("total");
            }
        } catch (SQLException e){
            e.printStackTrace();
        }

        return 0;
    }

    public boolean checkIfEmailExists(String email) {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE email = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            var resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("total") > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean addStaff(User user) {
        // List the columns explicitly so the auto-increment "id" is skipped.
        String sql = "INSERT INTO users (name, email, passwordHash, role, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPasswordHash());
            statement.setString(4, user.getRole());
            statement.setString(5, user.getStatus());
            return statement.executeUpdate() > 0;   // run it; true if a row was inserted
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStaff(User user) {
        String sql = "UPDATE users SET name = ?, email = ?, passwordHash = ?, role = ?, status = ? WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPasswordHash());
            statement.setString(4, user.getRole());
            statement.setString(5, user.getStatus());
            statement.setInt(6, user.getId());
            return statement.executeUpdate() > 0;   // run it; true if a row was updated
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a staff member. The role='admin' guard means this endpoint can only
    // ever delete staff, never a customer, even if someone passes a customer's id.
    public boolean deleteStaff(int id) {
        String sql = "DELETE FROM users WHERE id = ? AND role = 'admin'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;   // true if a row was deleted
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getStaffById(int id) {
        String sql = "SELECT * FROM users WHERE id = ? AND role = 'admin'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            var resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return new User(
                    resultSet.getInt("id"),
                    resultSet.getString("name"),
                    resultSet.getString("email"),
                    resultSet.getString("passwordHash"),
                    resultSet.getString("role"),
                    resultSet.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}