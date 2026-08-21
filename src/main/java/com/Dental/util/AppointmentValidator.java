package com.Dental.util;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Set;

// Plain, testable validation for booking an appointment.
// Returns null if valid, else a message.
public class AppointmentValidator {

    private static final Set<String> ALLOWED_STATUSES = Set.of("scheduled", "completed", "cancelled");

    // patientId is the hidden field set by the NIC lookup: present and valid =
    // an existing patient was found and will be reused; blank = no match was
    // found, so a new patient (NIC + name) is being created. NIC identifies the
    // patient - not the phone number, which several patients can share.
    //
    // enforceFuture: true for a brand-new booking (date/time can't be in the
    // past). false for editing an existing appointment, so correcting details
    // on an appointment that's already happened isn't blocked.
    public static String validate(String patientId, String newPatientName, String newPatientNic,
                                  String dentistId, String treatmentType,
                                  String date, String time, String status, boolean enforceFuture) {

        if (!StaffValidator.isBlank(patientId)) {
            Integer pid = DentistValidator.toInt(patientId);
            if (pid == null || pid <= 0) return "Please enter a valid NIC to find or create a patient.";
        } else {
            if (StaffValidator.isBlank(newPatientNic)) return "Patient NIC is required.";
            if (StaffValidator.isBlank(newPatientName)) return "Patient name is required.";
        }

        Integer did = DentistValidator.toInt(dentistId);
        if (did == null || did <= 0) return "Please select a dentist.";

        if (StaffValidator.isBlank(treatmentType)) return "Please select a treatment type.";
        if (StaffValidator.isBlank(date)) return "Appointment date is required.";
        if (StaffValidator.isBlank(time)) return "Appointment time is required.";
        if (StaffValidator.isBlank(status) || !ALLOWED_STATUSES.contains(status)) return "Invalid status.";

        if (enforceFuture) {
            try {
                LocalDate apptDate = LocalDate.parse(date);
                if (apptDate.isBefore(LocalDate.now())) return "Appointment date cannot be in the past.";
                if (apptDate.isEqual(LocalDate.now()) && LocalTime.parse(time).isBefore(LocalTime.now())) {
                    return "Appointment time cannot be in the past.";
                }
            } catch (Exception e) {
                return "Invalid date or time.";
            }
        }

        return null;
    }
}
