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

    private static final Pattern SPECIAL_CHAR = Pattern.compile("[^A-Za-z0-9]");

    /**
     * At least 8 chars, with an uppercase letter, a lowercase letter, a digit,
     * and a special character - a login guarding real patient records needs
     * more than "6 chars + a digit" to resist basic guessing/brute force.
     */
    public static String validatePassword(String password) {
        if (password == null || password.length() < 8) {
            return "Password must be at least 8 characters.";
        }
        boolean hasUpper   = password.matches(".*[A-Z].*");
        boolean hasLower   = password.matches(".*[a-z].*");
        boolean hasDigit   = password.matches(".*\\d.*");
        boolean hasSpecial = SPECIAL_CHAR.matcher(password).find();
        if (!hasUpper || !hasLower || !hasDigit || !hasSpecial) {
            return "Password must include an uppercase letter, a lowercase letter, a number, and a special character.";
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
