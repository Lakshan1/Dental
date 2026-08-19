package com.Dental.util;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

// Works out appointment time slots from a dentist's working hours.
public class SlotService {

    // Which day key ("mon".."sun") does this date fall on? Used to look up the
    // dentist's hours for that weekday. Returns null if the date is invalid.
    public static String dayKey(String date) {
        try {
            DayOfWeek d = LocalDate.parse(date).getDayOfWeek();  // date is "yyyy-MM-dd"
            switch (d) {
                case MONDAY:    return "mon";
                case TUESDAY:   return "tue";
                case WEDNESDAY: return "wed";
                case THURSDAY:  return "thu";
                case FRIDAY:    return "fri";
                case SATURDAY:  return "sat";
                default:        return "sun";
            }
        } catch (Exception e) {
            return null;
        }
    }

    // Build slots from start to end, each slotMinutes long. A slot is included
    // only if it fully fits before the end time (e.g. 09:00-17:00, 30 min ->
    // 09:00, 09:30, ... 16:30). Empty list if the day is off or inputs are bad.
    public static List<String> generateSlots(String start, String end, int slotMinutes) {
        List<String> slots = new ArrayList<>();
        if (isBlank(start) || isBlank(end) || slotMinutes <= 0) return slots;
        try {
            LocalTime t = LocalTime.parse(start);
            LocalTime endTime = LocalTime.parse(end);
            while (!t.plusMinutes(slotMinutes).isAfter(endTime)) {
                slots.add(t.toString().substring(0, 5));   // "HH:mm"
                t = t.plusMinutes(slotMinutes);
            }
        } catch (Exception e) {
            // bad time format -> just return whatever we have
        }
        return slots;
    }

    // Remove slots that have already passed, but only if "date" is today - a
    // future date's slots are all still bookable no matter the time of day.
    public static List<String> removePastForToday(List<String> slots, String date) {
        try {
            if (!LocalDate.parse(date).isEqual(LocalDate.now())) return slots;   // not today, nothing to remove
            LocalTime now = LocalTime.now();
            List<String> future = new ArrayList<>();
            for (String s : slots) {
                if (!LocalTime.parse(s).isBefore(now)) future.add(s);
            }
            return future;
        } catch (Exception e) {
            return slots;
        }
    }

    private static boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
