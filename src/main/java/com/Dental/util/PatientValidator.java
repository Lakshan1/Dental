package com.Dental.util;

// Plain, testable validation for patient details.
// NIC is the unique identifier (not the phone number - several patients can
// share one phone, e.g. family members), so it's required here.
public class PatientValidator {

    public static String validate(String nic, String name, String contact) {
        if (StaffValidator.isBlank(nic)) return "NIC is required.";
        if (StaffValidator.isBlank(name)) return "Patient name is required.";
        if (StaffValidator.isBlank(contact)) return "Contact number is required.";
        return null;
    }
}
