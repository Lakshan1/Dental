package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;
import com.Dental.dao.DentistDao;
import com.Dental.model.Appointment;
import com.Dental.notify.SmsService;
import com.Dental.util.AppointmentValidator;
import com.Dental.util.DentistValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/appointments/edit")
public class EditAppointmentServlet extends HttpServlet {

    private final AppointmentDao appointmentDao = new AppointmentDao();
    private final DentistDao dentistDao = new DentistDao();

    // GET -> load the appointment and show the edit form (patient is fixed).
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/appointments");
            return;
        }

        Appointment appointment = appointmentDao.getAppointmentById(id);
        if (appointment == null) {
            response.sendRedirect(request.getContextPath() + "/appointments");
            return;
        }

        request.setAttribute("appointment", appointment);
        request.setAttribute("dentists", dentistDao.getAllDentists());
        request.getRequestDispatcher("/WEB-INF/views/edit-appointment.jsp").forward(request, response);
    }

    // POST -> validate + update
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/appointments");
            return;
        }

        Appointment existing = appointmentDao.getAppointmentById(id);
        if (existing == null) {
            response.sendRedirect(request.getContextPath() + "/appointments");
            return;
        }

        String dentistId     = request.getParameter("dentistId");
        String treatmentType = trim(request.getParameter("treatmentType"));
        String date          = request.getParameter("appointmentDate");
        String time          = request.getParameter("appointmentTime");
        String status        = trim(request.getParameter("status"));

        // the patient stays the same on edit, so validate against the existing patient id
        // enforceFuture = false: editing shouldn't be blocked just because the
        // appointment (or its status update) is for a date/time that's already passed.
        String error = AppointmentValidator.validate(String.valueOf(existing.getPatientId()), null, null,
                dentistId, treatmentType, date, time, status, false);
        // double-booking, ignoring THIS appointment's own slot
        if (error == null && appointmentDao.isSlotTaken(DentistValidator.toInt(dentistId), date, time, id)) {
            error = "That time slot is already booked. Please pick another.";
        }
        // same-patient guard: this patient can't have another appointment at
        // the new date+time either (with a different dentist), ignoring itself.
        if (error == null && appointmentDao.isPatientBusy(existing.getPatientId(), date, time, id)) {
            error = "This patient already has another appointment at that time.";
        }
        if (error != null) {
            request.setAttribute("appointment", appointmentDao.getAppointmentById(id));
            request.setAttribute("dentists", dentistDao.getAllDentists());
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/edit-appointment.jsp").forward(request, response);
            return;
        }

        // Captured before existing is mutated below, so this compares old vs new.
        // Only a genuine reschedule (date, time or dentist) gets a "rescheduled"
        // SMS - editing something else (e.g. marking completed) shouldn't say
        // the appointment moved when it didn't.
        boolean scheduleChanged = !existing.getAppointmentDate().equals(date)
                || !existing.getAppointmentTime().equals(time)
                || existing.getDentistId() != DentistValidator.toInt(dentistId);

        existing.setDentistId(DentistValidator.toInt(dentistId));
        existing.setTreatmentType(treatmentType);
        existing.setAppointmentDate(date);
        existing.setAppointmentTime(time);
        existing.setStatus(status);

        if (appointmentDao.updateAppointment(existing)) {
            if (scheduleChanged) {
                // Re-fetch for the joined details - picks up the NEW dentist's
                // name if the dentist itself was changed.
                Appointment updated = appointmentDao.getAppointmentById(id);
                if (updated != null) {
                    SmsService.send(updated.getPatientContact(),
                            "Hi " + updated.getPatientName() + ", your appointment with Dr. "
                            + updated.getDentistName() + " has been rescheduled to " + date + " at " + time
                            + ". - Sunrise Dental Clinic");
                }
            }
            response.sendRedirect(request.getContextPath() + "/appointments/view?id=" + id);
        } else {
            request.setAttribute("appointment", appointmentDao.getAppointmentById(id));
            request.setAttribute("dentists", dentistDao.getAllDentists());
            request.setAttribute("error", "Could not update the appointment. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/edit-appointment.jsp").forward(request, response);
        }
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
