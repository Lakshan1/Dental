package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.PatientDao;
import com.Dental.model.Patient;
import com.Dental.util.PatientValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/patients/edit")
public class EditPatientServlet extends HttpServlet {

    private final PatientDao patientDao = new PatientDao();

    // GET -> show the edit form pre-filled
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
        Patient patient = patientDao.getPatientById(id);
        if (patient == null) {
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }
        request.setAttribute("patient", patient);
        request.getRequestDispatcher("/WEB-INF/views/edit-patient.jsp").forward(request, response);
    }

    // POST -> validate + update
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }

        Patient existing = patientDao.getPatientById(id);
        if (existing == null) {
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }

        String name    = trim(request.getParameter("name"));
        String address = trim(request.getParameter("address"));
        String contact = trim(request.getParameter("contact"));

        // NIC isn't editable - always keep the patient's existing NIC, no
        // matter what (if anything) came through in the request.
        String nic = existing.getNic();

        String error = PatientValidator.validate(name, contact);
        if (error != null) {
            request.setAttribute("patient", new Patient(id, nic, name, address, contact));
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/edit-patient.jsp").forward(request, response);
            return;
        }

        Patient patient = new Patient(id, nic, name, address, contact);
        if (patientDao.updatePatient(patient)) {
            response.sendRedirect(request.getContextPath() + "/patients/view?id=" + id);
        } else {
            request.setAttribute("patient", patient);
            request.setAttribute("error", "Could not update the patient. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/edit-patient.jsp").forward(request, response);
        }
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
