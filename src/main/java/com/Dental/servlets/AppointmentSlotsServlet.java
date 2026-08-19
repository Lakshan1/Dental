package com.Dental.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.Dental.dao.AppointmentDao;
import com.Dental.dao.DentistDao;
import com.Dental.model.Dentist;
import com.Dental.util.SlotService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Small JSON endpoint the booking form calls (via fetch) when the dentist or
// date changes. Returns the free time slots as a JSON array, e.g. ["09:00","09:30"].
@WebServlet("/appointments/slots")
public class AppointmentSlotsServlet extends HttpServlet {

    private final DentistDao dentistDao = new DentistDao();
    private final AppointmentDao appointmentDao = new AppointmentDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        int dentistId;
        try {
            dentistId = Integer.parseInt(request.getParameter("dentistId"));
        } catch (NumberFormatException e) {
            out.print("[]");
            return;
        }
        String date = request.getParameter("date");

        Dentist dentist = dentistDao.getDentistById(dentistId);
        if (dentist == null || date == null || date.isEmpty()) {
            out.print("[]");
            return;
        }

        // dentist's hours for the weekday of this date
        String day = SlotService.dayKey(date);
        String start = dentist.getStartTimes().get(day);
        String end = dentist.getEndTimes().get(day);

        // all slots for the day, minus the ones already booked.
        // excludeId (optional) lets an appointment being edited keep its own slot.
        List<String> slots = SlotService.generateSlots(start, end, dentist.getSlotMinutes());
        int excludeId = 0;
        try { excludeId = Integer.parseInt(request.getParameter("excludeId")); } catch (Exception ignored) {}
        slots.removeAll(appointmentDao.getBookedTimes(dentistId, date, excludeId));

        // For a NEW booking (no excludeId), also hide any slot that has already
        // passed today. Skipped when editing so an existing today's-appointment
        // doesn't lose its own (now past) time slot from the dropdown.
        if (excludeId == 0) {
            slots = SlotService.removePastForToday(slots, date);
        }

        // write a simple JSON array of strings
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < slots.size(); i++) {
            if (i > 0) json.append(",");
            json.append("\"").append(slots.get(i)).append("\"");
        }
        json.append("]");
        out.print(json.toString());
    }
}
