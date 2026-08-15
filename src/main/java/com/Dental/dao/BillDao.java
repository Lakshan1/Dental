package com.Dental.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;

import com.Dental.db.DBConnection;
import com.Dental.model.Bill;

public class BillDao {

    private static final DateTimeFormatter DISPLAY_FORMAT =
            DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");

    // A bill only exists once an appointment has one (unique per appointment).
    public Bill getByAppointmentId(int appointmentId) {
        String sql = "SELECT * FROM bills WHERE appointment_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create a new bill; returns the new bill id, or -1 on failure.
    public int addBill(Bill b) {
        String sql = "INSERT INTO bills (appointment_id, consultation_fee, treatment_amount, "
                   + "additional_fees, additional_notes, total_amount) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, b.getAppointmentId());
            ps.setDouble(2, b.getConsultationFee());
            ps.setDouble(3, b.getTreatmentAmount());
            ps.setDouble(4, b.getAdditionalFees());
            ps.setString(5, b.getAdditionalNotes());
            ps.setDouble(6, b.getTotalAmount());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Update an existing bill (e.g. the amounts were corrected).
    public boolean updateBill(Bill b) {
        String sql = "UPDATE bills SET consultation_fee = ?, treatment_amount = ?, additional_fees = ?, "
                   + "additional_notes = ?, total_amount = ? WHERE id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setDouble(1, b.getConsultationFee());
            ps.setDouble(2, b.getTreatmentAmount());
            ps.setDouble(3, b.getAdditionalFees());
            ps.setString(4, b.getAdditionalNotes());
            ps.setDouble(5, b.getTotalAmount());
            ps.setInt(6, b.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Sum of all bills generated this calendar month (for the dashboard revenue card).
    public double getMonthlyRevenue() {
        String sql = "SELECT COALESCE(SUM(total_amount), 0) AS total FROM bills "
                   + "WHERE MONTH(generated_at) = MONTH(CURDATE()) AND YEAR(generated_at) = YEAR(CURDATE())";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getDouble("total");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Bill mapRow(ResultSet rs) throws SQLException {
        Bill b = new Bill();
        b.setId(rs.getInt("id"));
        b.setAppointmentId(rs.getInt("appointment_id"));
        b.setConsultationFee(rs.getDouble("consultation_fee"));
        b.setTreatmentAmount(rs.getDouble("treatment_amount"));
        b.setAdditionalFees(rs.getDouble("additional_fees"));
        b.setAdditionalNotes(rs.getString("additional_notes"));
        b.setTotalAmount(rs.getDouble("total_amount"));
        Timestamp ts = rs.getTimestamp("generated_at");
        b.setGeneratedAt(ts != null ? ts.toLocalDateTime().format(DISPLAY_FORMAT) : "");
        return b;
    }
}
