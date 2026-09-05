package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;
import com.Dental.model.Appointment;
import com.Dental.notify.SmsService;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/appointments/delete")
public class DeleteAppointmentServlet extends HttpServlet {

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

        AppointmentDao appointmentDao = new AppointmentDao();
        // Fetched before the delete - the joined patient/dentist details
        // needed for the SMS won't exist once the row is gone.
        Appointment appointment = appointmentDao.getAppointmentById(id);

        if (appointmentDao.deleteAppointment(id) && appointment != null) {
            SmsService.send(appointment.getPatientContact(),
                    "Hi " + appointment.getPatientName() + ", your appointment with Dr. "
                    + appointment.getDentistName() + " on " + appointment.getAppointmentDate() + " at "
                    + appointment.getAppointmentTime() + " has been cancelled. - Sunrise Dental Clinic");
        }
        response.sendRedirect(request.getContextPath() + "/appointments");
    }
}
