package com.Dental.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.Dental.dao.UserDao;
import com.Dental.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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

        // Check email is empty or not
        if (email.isEmpty()) {
            request.setAttribute("error", "Email address can't be empty.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        
        // check password is empty or not
        if (password.isEmpty()) {
            request.setAttribute("error", "Password can't be empty.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

        
        UserDao userDao = new UserDao(); // Create an instance of UserDao to interact with the database
        User user = userDao.getUserByEmail(email); // Retrieve the user from the database based on the provided email

        if (user != null) {

            if (!BCrypt.checkpw(password, user.getPasswordHash())) {
                request.setAttribute("error", "Invalid password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            HttpSession session = request.getSession(); // Create a new session for the user
            session.setAttribute("user", user); // Store the user object in the session

            if ("on".equals(remember)) {
                session.setMaxInactiveInterval(7 * 24 * 60 * 60);
            }else {
                session.setMaxInactiveInterval(5 * 60);
            }
            response.sendRedirect("index"); // Redirect the user to the index page after successful login

        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
