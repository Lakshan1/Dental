package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;
import com.Dental.dao.BillDao;
import com.Dental.model.Appointment;
import com.Dental.model.Bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/appointments/bill/view")
public class BillViewServlet extends HttpServlet {

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

        Bill bill = new BillDao().getByAppointmentId(id);
        if (bill == null) {
            // no bill yet -> send them to generate one first
            response.sendRedirect(request.getContextPath() + "/appointments/bill?id=" + id);
            return;
        }

        request.setAttribute("appointment", appointment);
        request.setAttribute("bill", bill);
        request.getRequestDispatcher("/WEB-INF/views/bill-print.jsp").forward(request, response);
    }
}
