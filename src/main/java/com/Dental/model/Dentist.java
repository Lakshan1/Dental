package com.Dental.model;

import java.util.HashMap;
import java.util.Map;

// A dentist = the login/identity fields (same idea as a staff User) PLUS the
// professional fields (phone, specialization, fee, and weekly working hours).
// The weekly hours are kept in two maps keyed by day: "mon","tue",...,"sun".
// An empty/missing time for a day means the dentist is off that day.
public class Dentist {

    // --- identity (comes from the users table) ---
    private int id;                 // this is the users.id
    private String name;
    private String email;
    private String passwordHash;
    private String status;          // active / leave / restricted

    // --- professional (comes from the dentists table) ---
    private String phone;
    private String specialization;
    private double consultationFee;
    private int slotMinutes;        // length of one appointment slot, e.g. 30

    // weekly hours. startTimes.get("mon") + endTimes.get("mon") = Monday's range.
    private Map<String, String> startTimes = new HashMap<>();
    private Map<String, String> endTimes = new HashMap<>();

    public Dentist() {
        // empty - we fill fields with setters (there are a lot of them)
    }

    // getters / setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public double getConsultationFee() { return consultationFee; }
    public void setConsultationFee(double consultationFee) { this.consultationFee = consultationFee; }

    public int getSlotMinutes() { return slotMinutes; }
    public void setSlotMinutes(int slotMinutes) { this.slotMinutes = slotMinutes; }

    public Map<String, String> getStartTimes() { return startTimes; }
    public void setStartTimes(Map<String, String> startTimes) { this.startTimes = startTimes; }

    public Map<String, String> getEndTimes() { return endTimes; }
    public void setEndTimes(Map<String, String> endTimes) { this.endTimes = endTimes; }
}
