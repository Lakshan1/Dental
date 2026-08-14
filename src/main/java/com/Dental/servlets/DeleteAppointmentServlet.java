package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;

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
        new AppointmentDao().deleteAppointment(id);
        response.sendRedirect(request.getContextPath() + "/appointments");
    }
}
