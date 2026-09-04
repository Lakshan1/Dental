package com.Dental.util;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

public class PatientValidatorTest {

    // name and contact number both given, should pass
    @Test
    public void validate_nameAndContactProvided_returnsNull() {
        assertNull(PatientValidator.validate("John Silva", "0772459636"));
    }

    // name is just spaces, should fail
    @Test
    public void validate_blankName_returnsError() {
        assertEquals("Patient name is required.", PatientValidator.validate(" ", "0772459636"));
    }

    // contact number is empty, should fail
    @Test
    public void validate_blankContact_returnsError() {
        assertEquals("Contact number is required.", PatientValidator.validate("John Silva", ""));
    }

    // both name and contact are missing - name gets checked first so that's the error we should see
    @Test
    public void validate_bothBlank_reportsNameErrorFirst() {
        assertEquals("Patient name is required.", PatientValidator.validate(null, null));
    }
}
