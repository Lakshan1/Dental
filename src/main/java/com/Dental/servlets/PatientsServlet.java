package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.PatientDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/patients")
public class PatientsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PatientDao patientDao = new PatientDao();
        request.setAttribute("patients", patientDao.getAllPatients());
        request.getRequestDispatcher("/WEB-INF/views/patients.jsp").forward(request, response);
    }
}
