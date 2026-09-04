package com.Dental.util;

import java.time.LocalDate;
import java.time.LocalTime;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

public class AppointmentValidatorTest {

    // computed instead of hardcoded so these tests don't go stale/flaky as real time passes
    private static final String FUTURE_DATE = LocalDate.now().plusYears(1).toString();
    private static final String PAST_DATE = LocalDate.now().minusYears(1).toString();

    // ---- resolving the patient: existing (by id) vs new (NIC + name) ----

    // booking for an existing patient found by their id, everything else is fine, should pass
    @Test
    public void validate_existingPatientId_allElseValid_returnsNull() {
        assertNull(AppointmentValidator.validate("7", null, null, "1", "Checkup", FUTURE_DATE, "10:00", "scheduled", true));
    }

    // patient id given isn't actually a number, should fail
    @Test
    public void validate_existingPatientId_notANumber_returnsError() {
        assertEquals("Please enter a valid NIC to find or create a patient.",
                AppointmentValidator.validate("abc", null, null, "1", "Checkup", FUTURE_DATE, "10:00", "scheduled", true));
    }

    // patient id is 0 or below, not a real id, should fail
    @Test
    public void validate_existingPatientId_zeroOrNegative_returnsError() {
        assertNotNull(AppointmentValidator.validate("0", null, null, "1", "Checkup", FUTURE_DATE, "10:00", "scheduled", true));
    }

    // no existing patient id, but nic and name given for a new patient, should pass
    @Test
    public void validate_newPatient_nicAndNameProvided_returnsNull() {
        assertNull(AppointmentValidator.validate("", "New Patient", "200023403237", "1", "Checkup", FUTURE_DATE, "10:00", "scheduled", true));
    }

    // new patient but nic wasn't given, should fail
    @Test
    public void validate_newPatient_missingNic_returnsError() {
        assertEquals("Patient NIC is required.",
                AppointmentValidator.validate("", "New Patient", "", "1", "Checkup", FUTURE_DATE, "10:00", "scheduled", true));
    }

    // new patient but name wasn't given, should fail
    @Test
    public void validate_newPatient_missingName_returnsError() {
        assertEquals("Patient name is required.",
                AppointmentValidator.validate("", "", "200023403237", "1", "Checkup", FUTURE_DATE, "10:00", "scheduled", true));
    }

    // ---- dentist / treatment / date / time / status ----

    // no dentist picked at all, should fail
    @Test
    public void validate_missingDentist_returnsError() {
        assertEquals("Please select a dentist.",
                AppointmentValidator.validate("7", null, null, "", "Checkup", FUTURE_DATE, "10:00", "scheduled", true));
    }

    // dentist id is 0, not a real dentist, should fail
    @Test
    public void validate_dentistIdZero_returnsError() {
        assertEquals("Please select a dentist.",
                AppointmentValidator.validate("7", null, null, "0", "Checkup", FUTURE_DATE, "10:00", "scheduled", true));
    }

    // no treatment type picked, should fail
    @Test
    public void validate_missingTreatmentType_returnsError() {
        assertEquals("Please select a treatment type.",
                AppointmentValidator.validate("7", null, null, "1", "", FUTURE_DATE, "10:00", "scheduled", true));
    }

    // no appointment date given, should fail
    @Test
    public void validate_missingDate_returnsError() {
        assertEquals("Appointment date is required.",
                AppointmentValidator.validate("7", null, null, "1", "Checkup", "", "10:00", "scheduled", true));
    }

    // no appointment time given, should fail
    @Test
    public void validate_missingTime_returnsError() {
        assertEquals("Appointment time is required.",
                AppointmentValidator.validate("7", null, null, "1", "Checkup", FUTURE_DATE, "", "scheduled", true));
    }

    // status isn't scheduled/completed/cancelled, should fail
    @Test
    public void validate_invalidStatus_returnsError() {
        assertEquals("Invalid status.",
                AppointmentValidator.validate("7", null, null, "1", "Checkup", FUTURE_DATE, "10:00", "pending", true));
    }

    // ---- enforceFuture: the double-booking-adjacent "no past bookings" guard ----

    // trying to book a date that's already in the past, should fail
    @Test
    public void validate_enforceFuture_dateInThePast_returnsError() {
        assertEquals("Appointment date cannot be in the past.",
                AppointmentValidator.validate("7", null, null, "1", "Checkup", PAST_DATE, "10:00", "scheduled", true));
    }

    // booking is for today but the chosen time already passed a minute ago, should fail
    @Test
    public void validate_enforceFuture_todayButTimeAlreadyPassed_returnsError() {
        String today = LocalDate.now().toString();
        String aMinuteAgo = LocalTime.now().minusMinutes(1).toString();
        assertEquals("Appointment time cannot be in the past.",
                AppointmentValidator.validate("7", null, null, "1", "Checkup", today, aMinuteAgo, "scheduled", true));
    }

    // date text is just garbage, can't even be parsed as a date, should fail
    @Test
    public void validate_enforceFuture_unparseableDate_returnsError() {
        assertEquals("Invalid date or time.",
                AppointmentValidator.validate("7", null, null, "1", "Checkup", "not-a-date", "10:00", "scheduled", true));
    }

    // proper future date and time, should pass
    @Test
    public void validate_enforceFuture_futureDate_returnsNull() {
        assertNull(AppointmentValidator.validate("7", null, null, "1", "Checkup", FUTURE_DATE, "10:00", "scheduled", true));
    }

    // editing an appointment that's already in the past is fine, since we're not enforcing future here
    @Test
    public void validate_editMode_pastDateAllowed_whenNotEnforcingFuture() {
        assertNull(AppointmentValidator.validate("7", null, null, "1", "Checkup", PAST_DATE, "10:00", "scheduled", false));
    }
}
