package com.Dental.util;

import java.util.Set;

// Plain, servlet-free validation for dentist input (easy to unit test).
// Returns null when valid, otherwise a human-readable message.
// Reuses StaffValidator for the email/password rules so we don't repeat them.
public class DentistValidator {

    private static final Set<String> ALLOWED_STATUSES = Set.of("active", "leave", "restricted");

    // Dentists have no password (they can't log in), so it isn't validated here.
    public static String validate(String name, String email,
                                  String status, String feeText, String slotText) {

        if (StaffValidator.isBlank(name))  return "Name is required.";
        if (StaffValidator.isBlank(email)) return "Email is required.";
        if (!StaffValidator.isValidEmail(email)) return "Please enter a valid email address.";

        if (StaffValidator.isBlank(status) || !ALLOWED_STATUSES.contains(status)) {
            return "Invalid status.";
        }

        // consultation fee must be a number that is 0 or more
        Double fee = toDouble(feeText);
        if (fee == null || fee < 0) return "Consultation fee must be a number (0 or more).";

        // slot length must be a whole number greater than 0
        Integer slot = toInt(slotText);
        if (slot == null || slot <= 0) return "Slot length must be a whole number of minutes.";

        return null; // all good
    }

    // Check one day's range: both empty = day off (ok); both set = start must be before end.
    // Returns null if fine, else a message.
    public static String validateDayRange(String dayLabel, String start, String end) {
        boolean hasStart = !StaffValidator.isBlank(start);
        boolean hasEnd = !StaffValidator.isBlank(end);

        if (!hasStart && !hasEnd) return null;                 // day off
        if (hasStart != hasEnd)   return dayLabel + ": set both start and end time (or leave both empty).";
        if (start.compareTo(end) >= 0) return dayLabel + ": start time must be before end time.";
        return null;
    }

    public static Double toDouble(String s) {
        try { return Double.parseDouble(s.trim()); } catch (Exception e) { return null; }
    }

    public static Integer toInt(String s) {
        try { return Integer.parseInt(s.trim()); } catch (Exception e) { return null; }
    }
}
