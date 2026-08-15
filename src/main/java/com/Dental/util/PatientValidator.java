package com.Dental.util;

// Plain, testable validation for patient details.
public class PatientValidator {

    public static String validate(String name, String contact) {
        if (StaffValidator.isBlank(name)) return "Patient name is required.";
        if (StaffValidator.isBlank(contact)) return "Contact number is required.";
        return null;
    }
}
