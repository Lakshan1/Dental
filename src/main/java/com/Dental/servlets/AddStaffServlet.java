package com.Dental.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.Dental.dao.StaffDao;
import com.Dental.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/staffs/add")
public class AddStaffServlet  extends HttpServlet{
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/add-staff.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle form submission for adding a new staff member
        // You can retrieve form data using request.getParameter("parameterName")
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        StaffDao staffDao = new StaffDao();

        // basic server-side validation (don't rely on the browser's "required")
        if (isBlank(name) || isBlank(email) || isBlank(password)) {
            request.setAttribute("error", "Name, email and password are required.");
            request.getRequestDispatcher("/WEB-INF/views/add-staff.jsp").forward(request, response);
            return;
        }

        // check if the email already exists
        if (staffDao.checkIfEmailExists(email)) {
            request.setAttribute("error", "A staff member with that email already exists.");
            request.getRequestDispatcher("/WEB-INF/views/add-staff.jsp").forward(request, response);
            return;
        }

        // encrypt password
        String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());

        // create local user model (id = 0; the DB auto-generates the real id)
        User user = new User(0, name, email, passwordHash, role, status);

        // insert; only redirect on success, otherwise show an error
        if (staffDao.addStaff(user)) {
            response.sendRedirect(request.getContextPath() + "/staffs");
        } else {
            request.setAttribute("error", "Could not add staff. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/add-staff.jsp").forward(request, response);
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
