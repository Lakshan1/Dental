package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.DentistDao;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dentists/delete")
public class DeleteDentistServlet extends HttpServlet {

    // POST only - deleting is a state change, so not a GET link.
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/dentists");
            return;
        }

        new DentistDao().deleteDentist(id);   // role='dentist' guard is in the DAO
        response.sendRedirect(request.getContextPath() + "/dentists");
    }
}
