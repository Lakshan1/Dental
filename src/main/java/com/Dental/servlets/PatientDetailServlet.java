package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;
import com.Dental.dao.PatientDao;
import com.Dental.model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/patients/view")
public class PatientDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }

        Patient patient = new PatientDao().getPatientById(id);
        if (patient == null) {
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }

        request.setAttribute("patient", patient);
        // the patient's appointment history
        request.setAttribute("appointments", new AppointmentDao().getAppointmentsByPatient(id));
        request.getRequestDispatcher("/WEB-INF/views/patient-detail.jsp").forward(request, response);
    }
}
