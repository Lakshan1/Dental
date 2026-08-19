package com.Dental.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import com.Dental.dao.PatientDao;
import com.Dental.model.Patient;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Small JSON endpoint the appointment-booking form calls (via fetch) as the
// staff member types a contact number. Tells the form whether a patient with
// that number already exists, so it can show them instead of a blank form.
@WebServlet("/patients/lookup")
public class PatientLookupServlet extends HttpServlet {

    private final PatientDao patientDao = new PatientDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String contact = request.getParameter("contact");
        if (contact == null || contact.trim().isEmpty()) {
            out.print("{\"found\":false}");
            return;
        }

        Patient patient = patientDao.findByContact(contact.trim());
        if (patient == null) {
            out.print("{\"found\":false}");
            return;
        }

        out.print("{\"found\":true,\"id\":" + patient.getId()
                + ",\"name\":\"" + escape(patient.getName()) + "\""
                + ",\"address\":\"" + escape(patient.getAddress()) + "\"}");
    }

    // Minimal JSON string escaping (quotes/backslashes) - names/addresses are free text.
    private String escape(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
