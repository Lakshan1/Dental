package com.Dental.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.Dental.db.DBConnection;
import com.Dental.model.Dentist;

// Handles dentists. A dentist lives in TWO tables:
//   users     -> identity (name, email, passwordHash, role='doctor', status)
//   dentists  -> professional fields (phone, specialization, fee, slot, weekly hours)
// So reads JOIN the two tables, and add/update write to both (in one transaction).
public class DentistDao {

    // The 7 days, in order. Used to build the 14 time columns.
    private static final String[] DAYS = {"mon", "tue", "wed", "thu", "fri", "sat", "sun"};

    // ---- READ: all dentists ----
    public List<Dentist> getAllDentists() {
        String sql = "SELECT u.id, u.name, u.email, u.passwordHash, u.status, d.* "
                   + "FROM users u JOIN dentists d ON u.id = d.user_id "
                   + "WHERE u.role = 'doctor' ORDER BY u.name";

        List<Dentist> list = new ArrayList<>();
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ---- READ: one dentist by id ----
    public Dentist getDentistById(int id) {
        String sql = "SELECT u.id, u.name, u.email, u.passwordHash, u.status, d.* "
                   + "FROM users u JOIN dentists d ON u.id = d.user_id "
                   + "WHERE u.role = 'doctor' AND u.id = ?";

        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ---- CREATE: insert user row + dentist row together ----
    public boolean addDentist(Dentist d) {
        String userSql = "INSERT INTO users (name, email, passwordHash, role, status) VALUES (?, ?, ?, 'doctor', ?)";
        String dentSql = "INSERT INTO dentists (user_id, phone, specialization, consultation_fee, slot_minutes, "
                       + "mon_start, mon_end, tue_start, tue_end, wed_start, wed_end, thu_start, thu_end, "
                       + "fri_start, fri_end, sat_start, sat_end, sun_start, sun_end) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        Connection c = null;
        try {
            c = DBConnection.getConnection();
            c.setAutoCommit(false);   // do both inserts as one unit (all-or-nothing)

            int userId;
            try (PreparedStatement us = c.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS)) {
                us.setString(1, d.getName());
                us.setString(2, d.getEmail());
                us.setString(3, d.getPasswordHash());
                us.setString(4, d.getStatus());
                us.executeUpdate();
                try (ResultSet keys = us.getGeneratedKeys()) {
                    keys.next();
                    userId = keys.getInt(1);   // the new users.id
                }
            }

            try (PreparedStatement ds = c.prepareStatement(dentSql)) {
                ds.setInt(1, userId);
                ds.setString(2, d.getPhone());
                ds.setString(3, d.getSpecialization());
                ds.setDouble(4, d.getConsultationFee());
                ds.setInt(5, d.getSlotMinutes());
                setDayTimes(ds, 6, d);         // fills the 14 time params
                ds.executeUpdate();
            }

            c.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            rollback(c);
            return false;
        } finally {
            close(c);
        }
    }

    // ---- UPDATE: update both rows ----
    public boolean updateDentist(Dentist d) {
        String userSql = "UPDATE users SET name = ?, email = ?, passwordHash = ?, status = ? WHERE id = ?";
        String dentSql = "UPDATE dentists SET phone = ?, specialization = ?, consultation_fee = ?, slot_minutes = ?, "
                       + "mon_start = ?, mon_end = ?, tue_start = ?, tue_end = ?, wed_start = ?, wed_end = ?, "
                       + "thu_start = ?, thu_end = ?, fri_start = ?, fri_end = ?, sat_start = ?, sat_end = ?, "
                       + "sun_start = ?, sun_end = ? WHERE user_id = ?";

        Connection c = null;
        try {
            c = DBConnection.getConnection();
            c.setAutoCommit(false);

            try (PreparedStatement us = c.prepareStatement(userSql)) {
                us.setString(1, d.getName());
                us.setString(2, d.getEmail());
                us.setString(3, d.getPasswordHash());
                us.setString(4, d.getStatus());
                us.setInt(5, d.getId());
                us.executeUpdate();
            }

            try (PreparedStatement ds = c.prepareStatement(dentSql)) {
                ds.setString(1, d.getPhone());
                ds.setString(2, d.getSpecialization());
                ds.setDouble(3, d.getConsultationFee());
                ds.setInt(4, d.getSlotMinutes());
                int next = setDayTimes(ds, 5, d);   // 14 time params, returns next index
                ds.setInt(next, d.getId());         // WHERE user_id = ?
                ds.executeUpdate();
            }

            c.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            rollback(c);
            return false;
        } finally {
            close(c);
        }
    }

    // ---- DELETE: remove the user; the dentists row is removed by ON DELETE CASCADE ----
    public boolean deleteDentist(int id) {
        String sql = "DELETE FROM users WHERE id = ? AND role = 'doctor'";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---- email uniqueness (checks the whole users table) ----
    public boolean checkIfEmailExists(String email) {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            return ps.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getTotalDentistCount() {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role = 'doctor'";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt("total");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getActiveDentistCount() {
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role = 'doctor' AND status = 'active'";
        try (Connection c = DBConnection.getConnection();
             Statement st = c.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt("total");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ================= small helpers =================

    // Turn one ResultSet row into a Dentist object.
    private Dentist mapRow(ResultSet rs) throws SQLException {
        Dentist d = new Dentist();
        d.setId(rs.getInt("id"));
        d.setName(rs.getString("name"));
        d.setEmail(rs.getString("email"));
        d.setPasswordHash(rs.getString("passwordHash"));
        d.setStatus(rs.getString("status"));
        d.setPhone(rs.getString("phone"));
        d.setSpecialization(rs.getString("specialization"));
        d.setConsultationFee(rs.getDouble("consultation_fee"));
        d.setSlotMinutes(rs.getInt("slot_minutes"));
        for (String day : DAYS) {
            d.getStartTimes().put(day, shortTime(rs.getString(day + "_start")));
            d.getEndTimes().put(day, shortTime(rs.getString(day + "_end")));
        }
        return d;
    }

    // Fill the 14 day-time params starting at paramIndex; returns the next free index.
    private int setDayTimes(PreparedStatement ps, int paramIndex, Dentist d) throws SQLException {
        int i = paramIndex;
        for (String day : DAYS) {
            ps.setString(i++, emptyToNull(d.getStartTimes().get(day)));
            ps.setString(i++, emptyToNull(d.getEndTimes().get(day)));
        }
        return i;
    }

    private String emptyToNull(String s) {
        return (s == null || s.trim().isEmpty()) ? null : s.trim();
    }

    // TIME columns read back as "09:00:00"; trim to "09:00" for the <input type="time">.
    private String shortTime(String t) {
        if (t == null) return "";
        return t.length() >= 5 ? t.substring(0, 5) : t;
    }

    private void rollback(Connection c) {
        if (c != null) try { c.rollback(); } catch (SQLException ignored) {}
    }

    private void close(Connection c) {
        if (c != null) try { c.setAutoCommit(true); c.close(); } catch (SQLException ignored) {}
    }
}
