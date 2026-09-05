package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;
import com.Dental.dao.BillDao;
import com.Dental.model.Appointment;
import com.Dental.notify.SmsService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/appointments/delete")
public class DeleteAppointmentServlet extends HttpServlet {

    private final AppointmentDao appointmentDao = new AppointmentDao();
    private final BillDao billDao = new BillDao();

    // POST only - deleting is a state change.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/appointments");
            return;
        }

        // Guard: a bill references this appointment (fk_bill_appt), so the
        // database already refuses this delete at the SQL level - but doing it
        // silently would just no-op with no explanation to the user. Checking
        // up front lets us send them back to the appointment with a clear
        // reason instead.
        if (billDao.getByAppointmentId(id) != null) {
            response.sendRedirect(request.getContextPath() + "/appointments/view?id=" + id + "&err=hasbill");
            return;
        }

        // Fetched before the delete - the joined patient/dentist details
        // needed for the SMS won't exist once the row is gone.
        Appointment appointment = appointmentDao.getAppointmentById(id);
        if (appointment == null) {
            response.sendRedirect(request.getContextPath() + "/appointments");
            return;
        }

        if (appointmentDao.deleteAppointment(id)) {
            SmsService.send(appointment.getPatientContact(),
                    "Hi " + appointment.getPatientName() + ", your appointment with Dr. "
                    + appointment.getDentistName() + " on " + appointment.getAppointmentDate() + " at "
                    + appointment.getAppointmentTime() + " has been cancelled. - Sunrise Dental Clinic");
            response.sendRedirect(request.getContextPath() + "/appointments");
        } else {
            // Delete failed for a reason other than the bill guard above (a
            // DB error, a constraint we don't otherwise anticipate, etc). The
            // old behaviour here was to redirect to the list regardless,
            // which looked exactly like a successful delete even though
            // nothing happened - the only trace was a stack trace in the
            // server log. Send them back to the appointment with a visible
            // error instead of silently discarding the failure.
            response.sendRedirect(request.getContextPath() + "/appointments/view?id=" + id + "&err=deletefailed");
        }
    }
}
