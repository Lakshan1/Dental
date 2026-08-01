package com.Dental.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.Dental.dao.StaffDao;
import com.Dental.model.User;
import com.Dental.util.StaffValidator;

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
        StaffDao staffDao = new StaffDao();

        // BUG FIX 1: guard the id parse (was an unguarded parseInt -> 500 on bad id).
        int staffId;
        try {
            staffId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid staff ID.");
            request.getRequestDispatcher("/WEB-INF/views/edit-staff.jsp").forward(request, response);
            return;
        }

        // BUG FIX 2: null-check the existing staff (was NPE on user.getPasswordHash()).
        User existing = staffDao.getStaffById(staffId);
        if (existing == null) {
            request.setAttribute("error", "Staff member not found.");
            request.getRequestDispatcher("/WEB-INF/views/edit-staff.jsp").forward(request, response);
            return;
        }

        // Read + trim inputs.
        String name     = trim(request.getParameter("name"));
        String email    = trim(request.getParameter("email"));
        String role     = trim(request.getParameter("role"));
        String status   = trim(request.getParameter("status"));
        String password = request.getParameter("password");   // blank = keep current

        // Server-side validation (password optional on edit).
        String error = StaffValidator.validate(name, email, password, role, status, false);
        if (error == null
                // Unique email, but allow keeping the SAME email (exclude self).
                && !existing.getEmail().equalsIgnoreCase(email)
                && staffDao.checkIfEmailExists(email)) {
            error = "Another staff member already uses that email.";
        }
        if (error != null) {
            // Re-show the form with what they typed (form needs ${staff}).
            request.setAttribute("staff", new User(staffId, name, email, "", role, status));
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/edit-staff.jsp").forward(request, response);
            return;
        }

        // Keep the old hash if no new password was entered, else hash the new one.
        String passwordHash = StaffValidator.isBlank(password)
                ? existing.getPasswordHash()
                : BCrypt.hashpw(password, BCrypt.gensalt());

        User updatedStaff = new User(staffId, name, email, passwordHash, role, status);

        // BUG FIX 3: check the update result instead of ignoring it.
        if (staffDao.updateStaff(updatedStaff)) {
            response.sendRedirect(request.getContextPath() + "/staffs");
        } else {
            request.setAttribute("staff", existing);
            request.setAttribute("error", "Could not update staff. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/edit-staff.jsp").forward(request, response);
        }
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
