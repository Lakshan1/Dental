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

@WebServlet("/staffs/edit")
public class EditStaddServlet extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int staffId = 0;
        try {
            staffId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            // Handle the case where the id parameter is not a valid integer
            request.setAttribute("error", "Invalid staff ID.");
            request.getRequestDispatcher("/WEB-INF/views/edit-staff.jsp").forward(request, response);
            return;
        }

        User staff = new StaffDao().getStaffById(staffId);

        if (staff == null) {
            // Handle the case where no staff member is found with the given ID
            request.setAttribute("error", "Staff member not found.");
            request.getRequestDispatcher("/WEB-INF/views/edit-staff.jsp").forward(request, response);
            return;
        }
        request.setAttribute("staff", staff);
        request.getRequestDispatcher("/WEB-INF/views/edit-staff.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle form submission for editing staff details
        int staffId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");
        String status = request.getParameter("status");
        String password = request.getParameter("password");

        User user = new StaffDao().getStaffById(staffId);

        // Validate the input fields (you can add more validation as needed)
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty() ||
            role == null || role.trim().isEmpty() || status == null || status.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/edit-staff.jsp").forward(request, response);
            return;
        }

        if (password != null && !password.trim().isEmpty()) {
            // If a new password is provided, hash it before saving
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());;
            // Create a User object with the updated details
            User updatedStaff = new User(staffId, name, email, hashedPassword, role, status); 

            new StaffDao().updateStaff(updatedStaff);
        } else {
            // If no new password is provided, update without changing the password
            User updatedStaff = new User(staffId, name, email, user.getPasswordHash(), role, status); // Pass null for password
            new StaffDao().updateStaff(updatedStaff);
        }

        response.sendRedirect(request.getContextPath() + "/staffs");
    }
}
