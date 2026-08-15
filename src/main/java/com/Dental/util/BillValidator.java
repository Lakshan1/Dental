package com.Dental.util;

// Plain, testable validation for the bill amounts entered when completing an appointment.
public class BillValidator {

    public static String validate(String treatmentAmountText, String additionalFeesText) {
        Double treatmentAmount = DentistValidator.toDouble(treatmentAmountText);
        if (treatmentAmount == null || treatmentAmount < 0) {
            return "Treatment amount must be a number (0 or more).";
        }

        Double additionalFees = DentistValidator.toDouble(additionalFeesText);
        if (additionalFees == null || additionalFees < 0) {
            return "Additional fees must be a number (0 or more).";
        }

        return null;
    }
}
