package com.Dental.servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // Handle GET requests to display the login page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // Handle POST requests to process login form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws  IOException, ServletException {

        // Retrieve form parameters from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        request.setAttribute("error", email + " does not exists in the system.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
