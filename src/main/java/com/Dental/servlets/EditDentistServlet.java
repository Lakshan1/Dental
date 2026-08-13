package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.DentistDao;
import com.Dental.model.Dentist;
import com.Dental.util.DentistValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dentists/edit")
public class EditDentistServlet extends HttpServlet {

    // GET -> load the dentist and show the pre-filled form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/dentists");
            return;
        }

        Dentist dentist = new DentistDao().getDentistById(id);
        if (dentist == null) {
            response.sendRedirect(request.getContextPath() + "/dentists");
            return;
        }

        request.setAttribute("dentist", dentist);
        request.setAttribute("mode", "Edit");
        request.setAttribute("formAction", request.getContextPath() + "/dentists/edit");
        request.getRequestDispatcher("/WEB-INF/views/dentist-form.jsp").forward(request, response);
    }

    // POST -> validate + update
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DentistDao dentistDao = new DentistDao();

        // guard the id parse
        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/dentists");
            return;
        }

        // make sure the dentist exists
        Dentist existing = dentistDao.getDentistById(id);
        if (existing == null) {
            response.sendRedirect(request.getContextPath() + "/dentists");
            return;
        }

        String name     = AddDentistServlet.trim(request.getParameter("name"));
        String email    = AddDentistServlet.trim(request.getParameter("email"));
        String status   = AddDentistServlet.trim(request.getParameter("status"));
        String feeText  = request.getParameter("consultationFee");
        String slotText = request.getParameter("slotMinutes");

        // validate (dentists have no password)
        String error = DentistValidator.validate(name, email, status, feeText, slotText);
        if (error == null) error = AddDentistServlet.validateDays(request);
        if (error == null
                && !existing.getEmail().equalsIgnoreCase(email)
                && dentistDao.checkIfEmailExists(email)) {
            error = "Another user already uses that email.";
        }
        if (error != null) {
            AddDentistServlet.keepInput(request, "Edit", request.getContextPath() + "/dentists/edit");
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/dentist-form.jsp").forward(request, response);
            return;
        }

        // build the updated dentist; keep the existing (empty) passwordHash - no login.
        Dentist dentist = AddDentistServlet.buildFromRequest(request, id);
        dentist.setPasswordHash(existing.getPasswordHash());

        if (dentistDao.updateDentist(dentist)) {
            response.sendRedirect(request.getContextPath() + "/dentists");
        } else {
            AddDentistServlet.keepInput(request, "Edit", request.getContextPath() + "/dentists/edit");
            request.setAttribute("error", "Could not update dentist. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/dentist-form.jsp").forward(request, response);
        }
    }
}
