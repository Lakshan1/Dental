package com.Dental.util;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

public class StaffValidatorTest {

    // ---- validate(): add mode (requirePassword = true) ----

    // good name, email, password, role and status - should pass with no error
    @Test
    public void validate_allFieldsValid_returnsNull() {
        assertNull(StaffValidator.validate("Jane Doe", "jane@sunrisedental.com", "Str0ng!Pw", "staff", "active", true));
    }

    // name is just spaces, should fail
    @Test
    public void validate_blankName_returnsError() {
        assertEquals("Name is required.", StaffValidator.validate(" ", "jane@sunrisedental.com", "Str0ng!Pw", "staff", "active", true));
    }

    // email is empty, should fail
    @Test
    public void validate_blankEmail_returnsError() {
        assertEquals("Email is required.", StaffValidator.validate("Jane Doe", "", "Str0ng!Pw", "staff", "active", true));
    }

    // email doesn't look like a real email (no @, no domain), should fail
    @Test
    public void validate_malformedEmail_returnsError() {
        assertEquals("Please enter a valid email address.", StaffValidator.validate("Jane Doe", "not-an-email", "Str0ng!Pw", "staff", "active", true));
    }

    // adding a brand new staff member needs a password, empty one should fail
    @Test
    public void validate_addMode_blankPassword_returnsError() {
        assertNotNull(StaffValidator.validate("Jane Doe", "jane@sunrisedental.com", "", "staff", "active", true));
    }

    // password given but it's too weak, should fail
    @Test
    public void validate_addMode_weakPassword_returnsError() {
        assertNotNull(StaffValidator.validate("Jane Doe", "jane@sunrisedental.com", "weak", "staff", "active", true));
    }

    // role isn't "staff" (the only allowed value here), should fail
    @Test
    public void validate_invalidRole_returnsError() {
        assertEquals("Invalid role.", StaffValidator.validate("Jane Doe", "jane@sunrisedental.com", "Str0ng!Pw", "admin", "active", true));
    }

    // status isn't one of active/leave/restricted, should fail
    @Test
    public void validate_invalidStatus_returnsError() {
        assertEquals("Invalid status.", StaffValidator.validate("Jane Doe", "jane@sunrisedental.com", "Str0ng!Pw", "staff", "on-holiday", true));
    }

    // ---- validate(): edit mode (requirePassword = false) ----

    // editing an existing staff member and leaving password blank just keeps the old one, should pass
    @Test
    public void validate_editMode_blankPassword_isAllowed_keepsExisting() {
        assertNull(StaffValidator.validate("Jane Doe", "jane@sunrisedental.com", "", "staff", "active", false));
    }

    // editing staff but typed in a new password that's too weak, should still fail even though password is optional
    @Test
    public void validate_editMode_weakPasswordTyped_stillValidated() {
        assertNotNull(StaffValidator.validate("Jane Doe", "jane@sunrisedental.com", "weak", "staff", "active", false));
    }

    // editing staff with a proper strong new password, should pass
    @Test
    public void validate_editMode_strongPasswordTyped_returnsNull() {
        assertNull(StaffValidator.validate("Jane Doe", "jane@sunrisedental.com", "Str0ng!Pw", "staff", "active", false));
    }

    // ---- validatePassword(): the strengthened policy ----

    // no password given at all, should fail
    @Test
    public void validatePassword_null_returnsError() {
        assertNotNull(StaffValidator.validatePassword(null));
    }

    // password is under 8 characters, should fail
    @Test
    public void validatePassword_shorterThanEightChars_returnsError() {
        assertEquals("Password must be at least 8 characters.", StaffValidator.validatePassword("Ab1!xyz"));
    }

    // exactly 8 characters but has upper, lower, a number and a symbol, should pass
    @Test
    public void validatePassword_exactlyEightChars_meetingAllRules_isValid() {
        assertNull(StaffValidator.validatePassword("Ab1!xyzz"));
    }

    // no uppercase letter anywhere in it, should fail
    @Test
    public void validatePassword_missingUppercase_returnsError() {
        assertEquals("Password must include an uppercase letter, a lowercase letter, a number, and a special character.",
                StaffValidator.validatePassword("ab1!xyzz"));
    }

    // no lowercase letter anywhere in it, should fail
    @Test
    public void validatePassword_missingLowercase_returnsError() {
        assertNotNull(StaffValidator.validatePassword("AB1!XYZZ"));
    }

    // no digit anywhere in it, should fail
    @Test
    public void validatePassword_missingDigit_returnsError() {
        assertNotNull(StaffValidator.validatePassword("Abcd!xyz"));
    }

    // no special character anywhere in it, should fail
    @Test
    public void validatePassword_missingSpecialChar_returnsError() {
        assertNotNull(StaffValidator.validatePassword("Abcd1xyz"));
    }

    // hits all four rules at once (upper, lower, digit, symbol), should pass
    @Test
    public void validatePassword_allFourRulesMet_isValid() {
        assertNull(StaffValidator.validatePassword("C0rrect!Horse"));
    }

    // ---- isValidEmail() ----

    // normal looking email address, should come back true
    @Test
    public void isValidEmail_properAddress_isTrue() {
        assertTrue(StaffValidator.isValidEmail("someone@example.com"));
    }

    // missing the @ sign, should come back false
    @Test
    public void isValidEmail_missingAtSign_isFalse() {
        assertFalse(StaffValidator.isValidEmail("someone.example.com"));
    }

    // domain part has no dot in it, should come back false
    @Test
    public void isValidEmail_missingDomainDot_isFalse() {
        assertFalse(StaffValidator.isValidEmail("someone@examplecom"));
    }

    // null passed in, should come back false not throw an error
    @Test
    public void isValidEmail_null_isFalse() {
        assertFalse(StaffValidator.isValidEmail(null));
    }

    // ---- isBlank() ----

    // null counts as blank
    @Test
    public void isBlank_null_isTrue() {
        assertTrue(StaffValidator.isBlank(null));
    }

    // empty string counts as blank
    @Test
    public void isBlank_emptyString_isTrue() {
        assertTrue(StaffValidator.isBlank(""));
    }

    // just spaces with nothing else also counts as blank
    @Test
    public void isBlank_onlyWhitespace_isTrue() {
        assertTrue(StaffValidator.isBlank("   "));
    }

    // has actual text in it, so it's not blank
    @Test
    public void isBlank_nonBlankText_isFalse() {
        assertFalse(StaffValidator.isBlank("Jane"));
    }
}
