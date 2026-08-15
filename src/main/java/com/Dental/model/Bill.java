package com.Dental.model;

// A bill for one appointment. consultationFee is copied from the dentist at
// the time the bill is made (so it stays correct even if the fee changes later).
// total = consultationFee + treatmentAmount + additionalFees.
public class Bill {
    private int id;
    private int appointmentId;
    private double consultationFee;
    private double treatmentAmount;
    private double additionalFees;
    private String additionalNotes;
    private double totalAmount;
    private String generatedAt;   // formatted display string, e.g. "15 Sep 2026, 10:30 AM"

    public Bill() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getAppointmentId() { return appointmentId; }
    public void setAppointmentId(int appointmentId) { this.appointmentId = appointmentId; }

    public double getConsultationFee() { return consultationFee; }
    public void setConsultationFee(double consultationFee) { this.consultationFee = consultationFee; }

    public double getTreatmentAmount() { return treatmentAmount; }
    public void setTreatmentAmount(double treatmentAmount) { this.treatmentAmount = treatmentAmount; }

    public double getAdditionalFees() { return additionalFees; }
    public void setAdditionalFees(double additionalFees) { this.additionalFees = additionalFees; }

    public String getAdditionalNotes() { return additionalNotes; }
    public void setAdditionalNotes(String additionalNotes) { this.additionalNotes = additionalNotes; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getGeneratedAt() { return generatedAt; }
    public void setGeneratedAt(String generatedAt) { this.generatedAt = generatedAt; }
}
