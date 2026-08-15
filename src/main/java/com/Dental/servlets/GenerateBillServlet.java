package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;
import com.Dental.dao.BillDao;
import com.Dental.model.Appointment;
import com.Dental.model.Bill;
import com.Dental.util.BillValidator;
import com.Dental.util.DentistValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Bill generation is only allowed once an appointment is marked "completed".
@WebServlet("/appointments/bill")
public class GenerateBillServlet extends HttpServlet {

    private final AppointmentDao appointmentDao = new AppointmentDao();
    private final BillDao billDao = new BillDao();

    // GET -> show the bill form (pre-filled if a bill already exists, so it can be corrected)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Appointment appointment = loadCompletedAppointment(request, response);
        if (appointment == null) return;   // already redirected

        request.setAttribute("appointment", appointment);
        request.setAttribute("bill", billDao.getByAppointmentId(appointment.getId()));
        request.getRequestDispatcher("/WEB-INF/views/bill-form.jsp").forward(request, response);
    }

    // POST -> validate, calculate the total, save (insert or update), then show the printable bill
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Appointment appointment = loadCompletedAppointment(request, response);
        if (appointment == null) return;

        String treatmentAmountText = request.getParameter("treatmentAmount");
        String additionalFeesText  = request.getParameter("additionalFees");
        String additionalNotes     = trim(request.getParameter("additionalNotes"));

        String error = BillValidator.validate(treatmentAmountText, additionalFeesText);
        if (error != null) {
            request.setAttribute("appointment", appointment);
            request.setAttribute("bill", billDao.getByAppointmentId(appointment.getId()));
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/bill-form.jsp").forward(request, response);
            return;
        }

        double treatmentAmount = DentistValidator.toDouble(treatmentAmountText);
        double additionalFees  = DentistValidator.toDouble(additionalFeesText);
        double consultationFee = appointment.getConsultationFee();   // from the dentist's profile

        Bill bill = new Bill();
        bill.setAppointmentId(appointment.getId());
        bill.setConsultationFee(consultationFee);
        bill.setTreatmentAmount(treatmentAmount);
        bill.setAdditionalFees(additionalFees);
        bill.setAdditionalNotes(additionalNotes);
        bill.setTotalAmount(consultationFee + treatmentAmount + additionalFees);

        // update if a bill already exists for this appointment, otherwise insert a new one
        Bill existing = billDao.getByAppointmentId(appointment.getId());
        boolean saved;
        if (existing != null) {
            bill.setId(existing.getId());
            saved = billDao.updateBill(bill);
        } else {
            saved = billDao.addBill(bill) > 0;
        }

        if (saved) {
            response.sendRedirect(request.getContextPath() + "/appointments/bill/view?id=" + appointment.getId());
        } else {
            request.setAttribute("appointment", appointment);
            request.setAttribute("bill", existing);
            request.setAttribute("error", "Could not save the bill. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/bill-form.jsp").forward(request, response);
        }
    }

    // Loads the appointment for ?id=, and enforces the "must be completed" rule.
    // Returns null (after redirecting) if the id is bad, missing, or not completed.
    private Appointment loadCompletedAppointment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/appointments");
            return null;
        }

        Appointment appointment = appointmentDao.getAppointmentById(id);
        if (appointment == null) {
            response.sendRedirect(request.getContextPath() + "/appointments");
            return null;
        }
        if (!"completed".equals(appointment.getStatus())) {
            response.sendRedirect(request.getContextPath() + "/appointments/view?id=" + id + "&err=notcompleted");
            return null;
        }
        return appointment;
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
