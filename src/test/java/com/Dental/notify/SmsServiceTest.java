package com.Dental.notify;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

public class SmsServiceTest {

    // a local number starting with 0 should get the leading 0 swapped for the 94 country code
    @Test
    public void normalize_localFormatWithLeadingZero_convertsToCountryCode() {
        assertEquals("94772459636", SmsService.normalize("0772459636"));
    }

    // spaces and dashes in the number should just be stripped out
    @Test
    public void normalize_withSpacesAndDashes_stripsAndConverts() {
        assertEquals("94772459636", SmsService.normalize("077 245 9636"));
        assertEquals("94772459636", SmsService.normalize("077-245-9636"));
    }

    // a +94 international number should just lose the plus sign
    @Test
    public void normalize_internationalWithPlus_stripsThePlus() {
        assertEquals("94772459636", SmsService.normalize("+94772459636"));
    }

    // already in 94-prefixed format with no plus, should pass through as-is
    @Test
    public void normalize_alreadyCountryCodeFormat_isUnchanged() {
        assertEquals("94772459636", SmsService.normalize("94772459636"));
    }

    // a bare 9-digit number with no leading 0 and no country code should still get 94 prepended
    @Test
    public void normalize_nineDigitsNoLeadingZero_prependsCountryCode() {
        assertEquals("94772459636", SmsService.normalize("772459636"));
    }

    // null input should come back null instead of throwing
    @Test
    public void normalize_null_returnsNull() {
        assertNull(SmsService.normalize(null));
    }

    // too short to be a real number, should come back null rather than guessing
    @Test
    public void normalize_tooShort_returnsNull() {
        assertNull(SmsService.normalize("12345"));
    }

    // too long to be a real number, should come back null rather than guessing
    @Test
    public void normalize_tooLong_returnsNull() {
        assertNull(SmsService.normalize("9477245963612345"));
    }
}
