package com.Dental.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.Dental.db.DBConnection;
import com.Dental.model.Appointment;

public class AppointmentDao {

    // All appointments, joined with patient + dentist names for the table.
    public List<Appointment> getAllAppointments() {
        String sql = "SELECT a.*, p.name AS patient_name, u.name AS dentist_name "
                   + "FROM appointments a "
                   + "JOIN patients p ON a.patient_id = p.id "
                   + "JOIN users u ON a.dentist_id = u.id "
                   + "ORDER BY a.appointment_date DESC, a.appointment_time";

        List<Appointment> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // One appointment with ALL the detail (patient address/contact, dentist fee).
    public Appointment getAppointmentById(int id) {
        String sql = "SELECT a.*, p.name AS patient_name, p.address AS patient_address, "
                   + "p.contact_number AS patient_contact, u.name AS dentist_name, "
                   + "d.specialization AS dentist_specialization, d.consultation_fee AS consultation_fee "
                   + "FROM appointments a "
                   + "JOIN patients p ON a.patient_id = p.id "
                   + "JOIN users u ON a.dentist_id = u.id "
                   + "JOIN dentists d ON a.dentist_id = d.user_id "
                   + "WHERE a.id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Appointment a = mapRow(rs);
                    a.setPatientAddress(rs.getString("patient_address"));
                    a.setPatientContact(rs.getString("patient_contact"));
                    a.setDentistSpecialization(rs.getString("dentist_specialization"));
                    a.setConsultationFee(rs.getDouble("consultation_fee"));
                    return a;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Insert an appointment; returns the new appointment number (id), or -1.
    public int addAppointment(Appointment a) {
        String sql = "INSERT INTO appointments (patient_id, dentist_id, treatment_type, "
                   + "appointment_date, appointment_time, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, a.getPatientId());
            ps.setInt(2, a.getDentistId());
            ps.setString(3, a.getTreatmentType());
            ps.setString(4, a.getAppointmentDate());
            ps.setString(5, a.getAppointmentTime());
            ps.setString(6, a.getStatus());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Times already booked for a dentist on a date (ignoring cancelled ones).
    public List<String> getBookedTimes(int dentistId, String date) {
        String sql = "SELECT appointment_time FROM appointments "
                   + "WHERE dentist_id = ? AND appointment_date = ? AND status <> 'cancelled'";
        List<String> booked = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, String.valueOf(dentistId));
            ps.setString(2, date);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String t = rs.getString("appointment_time");
                    booked.add(t != null && t.length() >= 5 ? t.substring(0, 5) : t);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return booked;
    }

    // Server-side double-booking guard used before inserting.
    public boolean isSlotTaken(int dentistId, String date, String time) {
        String sql = "SELECT 1 FROM appointments "
                   + "WHERE dentist_id = ? AND appointment_date = ? AND appointment_time = ? AND status <> 'cancelled'";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, dentistId);
            ps.setString(2, date);
            ps.setString(3, time);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getTotalAppointmentCount() {
        String sql = "SELECT COUNT(*) AS total FROM appointments";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt("total");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Appointment mapRow(ResultSet rs) throws SQLException {
        Appointment a = new Appointment();
        a.setId(rs.getInt("id"));
        a.setPatientId(rs.getInt("patient_id"));
        a.setDentistId(rs.getInt("dentist_id"));
        a.setTreatmentType(rs.getString("treatment_type"));
        a.setAppointmentDate(rs.getString("appointment_date"));
        String t = rs.getString("appointment_time");        // "09:00:00" -> "09:00"
        a.setAppointmentTime(t != null && t.length() >= 5 ? t.substring(0, 5) : t);
        a.setStatus(rs.getString("status"));
        a.setPatientName(rs.getString("patient_name"));
        a.setDentistName(rs.getString("dentist_name"));
        return a;
    }
}
