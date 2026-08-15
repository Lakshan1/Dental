package com.Dental.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.Dental.db.DBConnection;
import com.Dental.model.Patient;

public class PatientDao {

    // all patients (used to fill the "existing patient" dropdown)
    public List<Patient> getAllPatients() {
        String sql = "SELECT * FROM patients ORDER BY name";
        List<Patient> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Patient(rs.getInt("id"), rs.getString("name"),
                        rs.getString("address"), rs.getString("contact_number")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Patient getPatientById(int id) {
        String sql = "SELECT * FROM patients WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Patient(rs.getInt("id"), rs.getString("name"),
                            rs.getString("address"), rs.getString("contact_number"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updatePatient(Patient p) {
        String sql = "UPDATE patients SET name = ?, address = ?, contact_number = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getAddress());
            ps.setString(3, p.getContactNumber());
            ps.setInt(4, p.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePatient(int id) {
        String sql = "DELETE FROM patients WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // True if this patient has any appointment (so we can block deletion).
    public boolean hasAppointments(int patientId) {
        String sql = "SELECT 1 FROM appointments WHERE patient_id = ? LIMIT 1";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Insert a new patient and return the new id (or -1 on failure).
    public int addPatient(Patient p) {
        String sql = "INSERT INTO patients (name, address, contact_number) VALUES (?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getAddress());
            ps.setString(3, p.getContactNumber());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
