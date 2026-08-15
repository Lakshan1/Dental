package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.PatientDao;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/patients/delete")
public class DeletePatientServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/patients");
            return;
        }

        PatientDao patientDao = new PatientDao();

        // Don't delete a patient who still has appointments (keeps history intact).
        if (patientDao.hasAppointments(id)) {
            response.sendRedirect(request.getContextPath() + "/patients/view?id=" + id + "&err=appointments");
            return;
        }

        patientDao.deletePatient(id);
        response.sendRedirect(request.getContextPath() + "/patients");
    }
}
