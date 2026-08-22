package com.Dental.util;

// Plain, testable validation for patient details.
// NIC itself isn't validated here - it's set once (when the patient is first
// created via appointment booking) and isn't editable afterwards, so editing
// a patient only ever touches name/address/contact.
public class PatientValidator {

    public static String validate(String name, String contact) {
        if (StaffValidator.isBlank(name)) return "Patient name is required.";
        if (StaffValidator.isBlank(contact)) return "Contact number is required.";
        return null;
    }
}
