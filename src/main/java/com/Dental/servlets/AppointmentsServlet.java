package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/appointments")
public class AppointmentsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AppointmentDao appointmentDao = new AppointmentDao();
        request.setAttribute("appointments", appointmentDao.getAllAppointments());
        request.setAttribute("totalAppointmentCount", appointmentDao.getTotalAppointmentCount());

        request.getRequestDispatcher("/WEB-INF/views/appointments.jsp").forward(request, response);
    }
}
