package com.Dental.servlets;

import java.io.IOException;
import java.util.List;

import com.Dental.dao.DentistDao;
import com.Dental.model.Dentist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dentists")
public class DentistsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DentistDao dentistDao = new DentistDao();

        // Load all dentists for the table.
        List<Dentist> dentists = dentistDao.getAllDentists();
        request.setAttribute("dentists", dentists);
        request.setAttribute("totalDentistCount", dentistDao.getTotalDentistCount());

        request.getRequestDispatcher("/WEB-INF/views/dentists.jsp").forward(request, response);
    }
}
