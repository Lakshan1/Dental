package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.AppointmentDao;
import com.Dental.dao.BillDao;
import com.Dental.dao.DentistDao;
import com.Dental.dao.PatientDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/index")
public class IndexServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Real dashboard numbers, gathered from each area's DAO.
        request.setAttribute("todaysAppointments", new AppointmentDao().getTodaysAppointments());
        request.setAttribute("totalPatientCount", new PatientDao().getTotalPatientCount());
        request.setAttribute("activeDentistCount", new DentistDao().getActiveDentistCount());
        request.setAttribute("monthlyRevenue", new BillDao().getMonthlyRevenue());

        // Forward the request to the index.jsp page
        request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
    }
}
