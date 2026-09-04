package com.Dental.util;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

public class BillValidatorTest {

    // both amounts are proper positive numbers, should pass
    @Test
    public void validate_bothAmountsValid_returnsNull() {
        assertNull(BillValidator.validate("1500", "200"));
    }

    // treatment amount isn't a number, should fail
    @Test
    public void validate_treatmentAmountNotANumber_returnsError() {
        assertEquals("Treatment amount must be a number (0 or more).", BillValidator.validate("free", "200"));
    }

    // treatment amount is negative, should fail
    @Test
    public void validate_treatmentAmountNegative_returnsError() {
        assertEquals("Treatment amount must be a number (0 or more).", BillValidator.validate("-50", "200"));
    }

    // treatment amount of exactly 0 is allowed, should pass
    @Test
    public void validate_treatmentAmountZero_isAllowed() {
        assertNull(BillValidator.validate("0", "200"));
    }

    // additional fees isn't a number, should fail
    @Test
    public void validate_additionalFeesNotANumber_returnsError() {
        assertEquals("Additional fees must be a number (0 or more).", BillValidator.validate("1500", "lots"));
    }

    // additional fees is negative, should fail
    @Test
    public void validate_additionalFeesNegative_returnsError() {
        assertEquals("Additional fees must be a number (0 or more).", BillValidator.validate("1500", "-10"));
    }

    // additional fees of exactly 0 is allowed, should pass
    @Test
    public void validate_additionalFeesZero_isAllowed() {
        assertNull(BillValidator.validate("1500", "0"));
    }
}
