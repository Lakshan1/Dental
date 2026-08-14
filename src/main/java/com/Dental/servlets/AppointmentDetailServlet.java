package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;
import com.Dental.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/appointments/view")
public class AppointmentDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/appointments");
            return;
        }

        Appointment appointment = new AppointmentDao().getAppointmentById(id);
        if (appointment == null) {
            response.sendRedirect(request.getContextPath() + "/appointments");
            return;
        }

        request.setAttribute("appointment", appointment);
        request.getRequestDispatcher("/WEB-INF/views/appointment-detail.jsp").forward(request, response);
    }
}
