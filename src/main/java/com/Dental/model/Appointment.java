package com.Dental.model;

// One appointment. Stores the ids (patient + dentist) plus the visit details.
// patientName / dentistName are filled from a JOIN just for display in tables.
public class Appointment {
    private int id;                 // this id is the appointment number (shown as APT-id)
    private int patientId;
    private int dentistId;
    private String treatmentType;
    private String appointmentDate;  // "yyyy-MM-dd"
    private String appointmentTime;  // "HH:mm"
    private String status;           // scheduled / completed / cancelled

    // display-only (from the join)
    private String patientName;
    private String dentistName;
    // extra detail fields (filled only by getAppointmentById, for the detail page)
    private String patientAddress;
    private String patientContact;
    private String dentistSpecialization;
    private double consultationFee;

    public Appointment() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPatientId() { return patientId; }
    public void setPatientId(int patientId) { this.patientId = patientId; }

    public int getDentistId() { return dentistId; }
    public void setDentistId(int dentistId) { this.dentistId = dentistId; }

    public String getTreatmentType() { return treatmentType; }
    public void setTreatmentType(String treatmentType) { this.treatmentType = treatmentType; }

    public String getAppointmentDate() { return appointmentDate; }
    public void setAppointmentDate(String appointmentDate) { this.appointmentDate = appointmentDate; }

    public String getAppointmentTime() { return appointmentTime; }
    public void setAppointmentTime(String appointmentTime) { this.appointmentTime = appointmentTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getDentistName() { return dentistName; }
    public void setDentistName(String dentistName) { this.dentistName = dentistName; }

    public String getPatientAddress() { return patientAddress; }
    public void setPatientAddress(String patientAddress) { this.patientAddress = patientAddress; }

    public String getPatientContact() { return patientContact; }
    public void setPatientContact(String patientContact) { this.patientContact = patientContact; }

    public String getDentistSpecialization() { return dentistSpecialization; }
    public void setDentistSpecialization(String dentistSpecialization) { this.dentistSpecialization = dentistSpecialization; }

    public double getConsultationFee() { return consultationFee; }
    public void setConsultationFee(double consultationFee) { this.consultationFee = consultationFee; }
}
