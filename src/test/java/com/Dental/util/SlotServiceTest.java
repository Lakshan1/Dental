package com.Dental.util;

import java.util.List;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class SlotServiceTest {

    // ---- isBookableSlot(): the guard that stops a booking landing outside
    // ---- the dentist's working hours for that day ----

    // 09:00 is the first slot of a 09:00-17:00 day, should be accepted
    @Test
    public void isBookableSlot_firstSlotOfTheDay_isAccepted() {
        assertTrue(SlotService.isBookableSlot("09:00", "09:00", "17:00", 30));
    }

    // 16:30 is the last 30-minute slot that still finishes by 17:00, should be accepted
    @Test
    public void isBookableSlot_lastSlotThatFitsBeforeClosing_isAccepted() {
        assertTrue(SlotService.isBookableSlot("16:30", "09:00", "17:00", 30));
    }

    // 08:30 is before the dentist starts, should be rejected
    @Test
    public void isBookableSlot_beforeOpeningTime_isRejected() {
        assertFalse(SlotService.isBookableSlot("08:30", "09:00", "17:00", 30));
    }

    // 17:00 is closing time, a 30-minute appointment wouldn't finish in time, should be rejected
    @Test
    public void isBookableSlot_atClosingTime_isRejected() {
        assertFalse(SlotService.isBookableSlot("17:00", "09:00", "17:00", 30));
    }

    // 18:00 is well after closing, should be rejected
    @Test
    public void isBookableSlot_afterClosingTime_isRejected() {
        assertFalse(SlotService.isBookableSlot("18:00", "09:00", "17:00", 30));
    }

    // 09:15 falls between two 30-minute slots, so it isn't a real slot, should be rejected
    @Test
    public void isBookableSlot_timeBetweenSlots_isRejected() {
        assertFalse(SlotService.isBookableSlot("09:15", "09:00", "17:00", 30));
    }

    // the dentist doesn't work that day (no hours set), nothing is bookable
    @Test
    public void isBookableSlot_dayOff_isRejected() {
        assertFalse(SlotService.isBookableSlot("10:00", "", "", 30));
    }

    // null hours behave the same as a day off
    @Test
    public void isBookableSlot_nullHours_isRejected() {
        assertFalse(SlotService.isBookableSlot("10:00", null, null, 30));
    }

    // no time given at all, should be rejected rather than throwing
    @Test
    public void isBookableSlot_blankTime_isRejected() {
        assertFalse(SlotService.isBookableSlot("", "09:00", "17:00", 30));
    }

    // garbage in the time field, should be rejected rather than throwing
    @Test
    public void isBookableSlot_unparseableTime_isRejected() {
        assertFalse(SlotService.isBookableSlot("not-a-time", "09:00", "17:00", 30));
    }

    // a 60-minute slot length shifts which times are valid, 09:30 is no longer a slot
    @Test
    public void isBookableSlot_respectsSlotLength() {
        assertTrue(SlotService.isBookableSlot("10:00", "09:00", "17:00", 60));
        assertFalse(SlotService.isBookableSlot("09:30", "09:00", "17:00", 60));
    }

    // ---- existing behaviour these tests also lock down ----

    // a normal 09:00-17:00 day at 30 minutes gives 16 slots, first 09:00 and last 16:30
    @Test
    public void generateSlots_normalWorkingDay_buildsExpectedSlots() {
        List<String> slots = SlotService.generateSlots("09:00", "17:00", 30);
        assertEquals(16, slots.size());
        assertEquals("09:00", slots.get(0));
        assertEquals("16:30", slots.get(slots.size() - 1));
    }

    // no hours set means the dentist is off, so there are no slots at all
    @Test
    public void generateSlots_dayOff_returnsNothing() {
        assertTrue(SlotService.generateSlots("", "", 30).isEmpty());
    }

    // "2026-09-07" is a Monday, so the day key used to look up hours should be "mon"
    @Test
    public void dayKey_mondayDate_returnsMon() {
        assertEquals("mon", SlotService.dayKey("2026-09-07"));
    }

    // a date that can't be parsed has no day key
    @Test
    public void dayKey_invalidDate_returnsNull() {
        assertEquals(null, SlotService.dayKey("nonsense"));
    }
}
