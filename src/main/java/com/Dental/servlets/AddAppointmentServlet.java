package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;
import com.Dental.dao.DentistDao;
import com.Dental.dao.PatientDao;
import com.Dental.model.Appointment;
import com.Dental.model.Patient;
import com.Dental.util.AppointmentValidator;
import com.Dental.util.DentistValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/appointments/add")
public class AddAppointmentServlet extends HttpServlet {

    private final PatientDao patientDao = new PatientDao();
    private final DentistDao dentistDao = new DentistDao();
    private final AppointmentDao appointmentDao = new AppointmentDao();

    // GET -> show the booking form (with dropdowns of patients + dentists)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadFormData(request);
        request.getRequestDispatcher("/WEB-INF/views/appointment-form.jsp").forward(request, response);
    }

    // POST -> create the patient (if new), then create the appointment
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // "new" = create a new patient; anything else = an existing patient was picked
        boolean isNewPatient = "new".equals(request.getParameter("patientMode"));

        String patientId     = request.getParameter("patientId");
        String newName       = trim(request.getParameter("newPatientName"));
        String newAddress    = trim(request.getParameter("newPatientAddress"));
        String newContact    = trim(request.getParameter("newPatientContact"));

        String dentistId     = request.getParameter("dentistId");
        String treatmentType = trim(request.getParameter("treatmentType"));
        String date          = request.getParameter("appointmentDate");
        String time          = request.getParameter("appointmentTime");
        String status        = trim(request.getParameter("status"));

        // validate
        String error = AppointmentValidator.validate(isNewPatient, patientId, newName,
                dentistId, treatmentType, date, time, status);
        if (error != null) {
            loadFormData(request);
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/appointment-form.jsp").forward(request, response);
            return;
        }

        // double-booking guard: reject if this dentist+date+time is already taken.
        if (appointmentDao.isSlotTaken(DentistValidator.toInt(dentistId), date, time)) {
            loadFormData(request);
            request.setAttribute("error", "That time slot is already booked. Please pick another.");
            request.getRequestDispatcher("/WEB-INF/views/appointment-form.jsp").forward(request, response);
            return;
        }

        // resolve the patient id: create a new patient, or use the selected one
        int resolvedPatientId;
        if (isNewPatient) {
            resolvedPatientId = patientDao.addPatient(new Patient(0, newName, newAddress, newContact));
        } else {
            resolvedPatientId = DentistValidator.toInt(patientId);
        }
        if (resolvedPatientId <= 0) {
            loadFormData(request);
            request.setAttribute("error", "Could not save the patient. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/appointment-form.jsp").forward(request, response);
            return;
        }

        // build + save the appointment
        Appointment appt = new Appointment();
        appt.setPatientId(resolvedPatientId);
        appt.setDentistId(DentistValidator.toInt(dentistId));
        appt.setTreatmentType(treatmentType);
        appt.setAppointmentDate(date);
        appt.setAppointmentTime(time);
        appt.setStatus(status);

        if (appointmentDao.addAppointment(appt) > 0) {
            response.sendRedirect(request.getContextPath() + "/appointments");
        } else {
            loadFormData(request);
            request.setAttribute("error", "Could not book the appointment. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/appointment-form.jsp").forward(request, response);
        }
    }

    // Load the dropdown data the form needs (patients + dentists).
    private void loadFormData(HttpServletRequest request) {
        request.setAttribute("patients", patientDao.getAllPatients());
        request.setAttribute("dentists", dentistDao.getAllDentists());
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
