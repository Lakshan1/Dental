package com.Dental.util;

import java.util.Set;
import java.util.regex.Pattern;

/**
 * Plain, servlet-free validation for staff input.
 *
 * Every method is static and takes/returns simple values, so it can be unit
 * tested directly (no request/response mocking): input -> expected message.
 * Returns null when the input is valid, otherwise a human-readable message.
 */
public class StaffValidator {

    private static final Pattern EMAIL = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    private static final Set<String> ALLOWED_ROLES = Set.of("staff");
    private static final Set<String> ALLOWED_STATUSES = Set.of("active", "leave", "restricted");

    /**
     * Validate a staff record.
     *
     * @param requirePassword true for "add" (password mandatory); false for
     *                        "edit" (password optional - blank means keep old).
     * @return null if valid, else the first error message found.
     */
    public static String validate(String name, String email, String password,
                                  String role, String status, boolean requirePassword) {
        if (isBlank(name))  return "Name is required.";
        if (isBlank(email)) return "Email is required.";
        if (!isValidEmail(email)) return "Please enter a valid email address.";

        // Password: always checked on add; on edit only when one was typed.
        if (requirePassword || !isBlank(password)) {
            String passwordError = validatePassword(password);
            if (passwordError != null) return passwordError;
        }

        if (isBlank(role) || !ALLOWED_ROLES.contains(role))     return "Invalid role.";
        if (isBlank(status) || !ALLOWED_STATUSES.contains(status)) return "Invalid status.";

        return null; // all good
    }

    /** At least 6 chars, containing at least one letter and one digit. */
    public static String validatePassword(String password) {
        if (password == null || password.length() < 6) {
            return "Password must be at least 6 characters.";
        }
        boolean hasLetter = password.matches(".*[A-Za-z].*");
        boolean hasDigit  = password.matches(".*\\d.*");
        if (!hasLetter || !hasDigit) {
            return "Password must include both letters and numbers.";
        }
        return null;
    }

    public static boolean isValidEmail(String email) {
        return email != null && EMAIL.matcher(email.trim()).matches();
    }

    public static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
