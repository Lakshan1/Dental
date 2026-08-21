package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;
import com.Dental.dao.DentistDao;
import com.Dental.dao.PatientDao;
import com.Dental.model.Appointment;
import com.Dental.model.Patient;
import com.Dental.util.AppointmentValidator;
import com.Dental.util.DentistValidator;
import com.Dental.util.StaffValidator;

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

    // GET -> show the booking form (dentist dropdown; patient is looked up by NIC)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadFormData(request);
        request.getRequestDispatcher("/WEB-INF/views/appointment-form.jsp").forward(request, response);
    }

    // POST -> reuse the matched patient, or create a new one, then create the appointment.
    // Which one happens is decided by whether "patientId" (a hidden field set by the
    // NIC lookup in the browser) came through filled in or blank.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String patientId  = request.getParameter("patientId");
        String nic         = trim(request.getParameter("nic"));
        String newName     = trim(request.getParameter("newPatientName"));
        String newAddress  = trim(request.getParameter("newPatientAddress"));
        String newContact  = trim(request.getParameter("newPatientContact"));

        String dentistId     = request.getParameter("dentistId");
        String treatmentType = trim(request.getParameter("treatmentType"));
        String date          = request.getParameter("appointmentDate");
        String time          = request.getParameter("appointmentTime");

        // Status isn't asked for on the New Appointment form - every new
        // booking starts out "scheduled".
        String status = "scheduled";

        // validate
        // enforceFuture = true: a new booking can't be dated/timed in the past.
        String error = AppointmentValidator.validate(patientId, newName, nic,
                dentistId, treatmentType, date, time, status, true);
        if (error == null && StaffValidator.isBlank(patientId) && patientDao.checkIfNicExists(nic)) {
            // Shouldn't normally happen (the lookup would have matched them), but
            // guards against a race or a bypassed lookup creating a duplicate NIC.
            error = "A patient with that NIC already exists.";
        }
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

        // resolve the patient id: reuse the matched patient, or create a new one
        boolean isExistingPatient = !StaffValidator.isBlank(patientId);

        // Same-patient guard: a brand-new patient can't already have a clashing
        // appointment, so this only matters when reusing an existing patient -
        // stops one patient being booked with two different dentists at once.
        if (isExistingPatient && appointmentDao.isPatientBusy(DentistValidator.toInt(patientId), date, time)) {
            loadFormData(request);
            request.setAttribute("error", "This patient already has an appointment at that time.");
            request.getRequestDispatcher("/WEB-INF/views/appointment-form.jsp").forward(request, response);
            return;
        }

        int resolvedPatientId;
        if (isExistingPatient) {
            resolvedPatientId = DentistValidator.toInt(patientId);
        } else {
            resolvedPatientId = patientDao.addPatient(new Patient(0, nic, newName, newAddress, newContact));
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

    // Load the dropdown data the form needs (dentists - patients are looked up live by NIC).
    private void loadFormData(HttpServletRequest request) {
        request.setAttribute("dentists", dentistDao.getAllDentists());
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
