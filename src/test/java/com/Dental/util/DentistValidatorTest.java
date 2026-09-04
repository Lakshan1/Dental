package com.Dental.util;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

public class DentistValidatorTest {

    // ---- validate() ----

    // all fields filled in properly, should pass with no error
    @Test
    public void validate_allFieldsValid_returnsNull() {
        assertNull(DentistValidator.validate("Dr. Denis", "denis@sunrisedental.com", "active", "2000", "30"));
    }

    // name is empty, should fail
    @Test
    public void validate_blankName_returnsError() {
        assertEquals("Name is required.", DentistValidator.validate("", "denis@sunrisedental.com", "active", "2000", "30"));
    }

    // email is just spaces, should fail
    @Test
    public void validate_blankEmail_returnsError() {
        assertEquals("Email is required.", DentistValidator.validate("Dr. Denis", " ", "active", "2000", "30"));
    }

    // email format is wrong, should fail
    @Test
    public void validate_malformedEmail_returnsError() {
        assertEquals("Please enter a valid email address.", DentistValidator.validate("Dr. Denis", "not-an-email", "active", "2000", "30"));
    }

    // status isn't one of active/leave/restricted, should fail
    @Test
    public void validate_invalidStatus_returnsError() {
        assertEquals("Invalid status.", DentistValidator.validate("Dr. Denis", "denis@sunrisedental.com", "on-holiday", "2000", "30"));
    }

    // consultation fee isn't a number, should fail
    @Test
    public void validate_feeNotANumber_returnsError() {
        assertEquals("Consultation fee must be a number (0 or more).",
                DentistValidator.validate("Dr. Denis", "denis@sunrisedental.com", "active", "free", "30"));
    }

    // consultation fee is negative, should fail
    @Test
    public void validate_negativeFee_returnsError() {
        assertEquals("Consultation fee must be a number (0 or more).",
                DentistValidator.validate("Dr. Denis", "denis@sunrisedental.com", "active", "-5", "30"));
    }

    // consultation fee of exactly 0 is allowed, should pass
    @Test
    public void validate_zeroFee_isAllowed() {
        assertNull(DentistValidator.validate("Dr. Denis", "denis@sunrisedental.com", "active", "0", "30"));
    }

    // slot length isn't a number, should fail
    @Test
    public void validate_slotNotANumber_returnsError() {
        assertEquals("Slot length must be a whole number of minutes.",
                DentistValidator.validate("Dr. Denis", "denis@sunrisedental.com", "active", "2000", "half-hour"));
    }

    // slot length is 0, needs to be more than 0, should fail
    @Test
    public void validate_zeroSlot_returnsError() {
        assertEquals("Slot length must be a whole number of minutes.",
                DentistValidator.validate("Dr. Denis", "denis@sunrisedental.com", "active", "2000", "0"));
    }

    // slot length is negative, should fail
    @Test
    public void validate_negativeSlot_returnsError() {
        assertNotNull(DentistValidator.validate("Dr. Denis", "denis@sunrisedental.com", "active", "2000", "-15"));
    }

    // ---- validateDayRange() ----

    // no start time and no end time means the dentist is off that day, should pass
    @Test
    public void validateDayRange_bothEmpty_isDayOff_valid() {
        assertNull(DentistValidator.validateDayRange("Mon", "", ""));
    }

    // same as above but passing null instead of empty string, should still pass
    @Test
    public void validateDayRange_bothNull_isDayOff_valid() {
        assertNull(DentistValidator.validateDayRange("Mon", null, null));
    }

    // only start time is set, no end time, should fail
    @Test
    public void validateDayRange_onlyStartSet_returnsError() {
        assertEquals("Mon: set both start and end time (or leave both empty).",
                DentistValidator.validateDayRange("Mon", "09:00", ""));
    }

    // only end time is set, no start time, should fail
    @Test
    public void validateDayRange_onlyEndSet_returnsError() {
        assertEquals("Mon: set both start and end time (or leave both empty).",
                DentistValidator.validateDayRange("Mon", "", "17:00"));
    }

    // normal working hours where start comes before end, should pass
    @Test
    public void validateDayRange_startBeforeEnd_isValid() {
        assertNull(DentistValidator.validateDayRange("Mon", "09:00", "17:00"));
    }

    // start and end time are exactly the same, should fail
    @Test
    public void validateDayRange_startEqualsEnd_returnsError() {
        assertEquals("Mon: start time must be before end time.",
                DentistValidator.validateDayRange("Mon", "09:00", "09:00"));
    }

    // start time is later than end time, should fail
    @Test
    public void validateDayRange_startAfterEnd_returnsError() {
        assertEquals("Mon: start time must be before end time.",
                DentistValidator.validateDayRange("Mon", "17:00", "09:00"));
    }

    // ---- toDouble() / toInt() ----

    // normal decimal number as text, should parse fine
    @Test
    public void toDouble_validNumber_parses() {
        assertEquals(Double.valueOf(2000.5), DentistValidator.toDouble("2000.5"));
    }

    // text that isn't a number, should come back null instead of throwing
    @Test
    public void toDouble_invalidText_returnsNull() {
        assertNull(DentistValidator.toDouble("abc"));
    }

    // normal whole number as text, should parse fine
    @Test
    public void toInt_validNumber_parses() {
        assertEquals(Integer.valueOf(30), DentistValidator.toInt("30"));
    }

    // text that isn't a whole number, should come back null instead of throwing
    @Test
    public void toInt_invalidText_returnsNull() {
        assertNull(DentistValidator.toInt("thirty"));
    }
}
