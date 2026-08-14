package com.Dental.util;

import java.util.Set;

// Plain, testable validation for booking an appointment.
// Returns null if valid, else a message.
public class AppointmentValidator {

    private static final Set<String> ALLOWED_STATUSES = Set.of("scheduled", "completed", "cancelled");

    public static String validate(boolean isNewPatient, String patientId, String newPatientName,
                                  String dentistId, String treatmentType,
                                  String date, String time, String status) {

        // patient: either a new one (needs a name) or an existing one (needs a valid id)
        if (isNewPatient) {
            if (StaffValidator.isBlank(newPatientName)) return "New patient name is required.";
        } else {
            Integer pid = DentistValidator.toInt(patientId);
            if (pid == null || pid <= 0) return "Please select a patient.";
        }

        Integer did = DentistValidator.toInt(dentistId);
        if (did == null || did <= 0) return "Please select a dentist.";

        if (StaffValidator.isBlank(treatmentType)) return "Please select a treatment type.";
        if (StaffValidator.isBlank(date)) return "Appointment date is required.";
        if (StaffValidator.isBlank(time)) return "Appointment time is required.";
        if (StaffValidator.isBlank(status) || !ALLOWED_STATUSES.contains(status)) return "Invalid status.";

        return null;
    }
}
