package com.Dental.servlets;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.Dental.dao.StaffDao;
import com.Dental.model.User;
import com.Dental.notify.EmailService;
import com.Dental.util.StaffValidator;

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
        // Read + trim inputs (trimming stops stray spaces being stored / breaking login).
        String name     = trim(request.getParameter("name"));
        String email    = trim(request.getParameter("email"));
        String password = request.getParameter("password");   // don't trim the password itself

        // Role and status aren't asked for on the Add Staff form - every staff
        // member created here is a "staff" role, starting out "active".
        String role   = "staff";
        String status = "active";

        StaffDao staffDao = new StaffDao();

        // Server-side validation (mirrors the form, but can't be bypassed).
        String error = StaffValidator.validate(name, email, password, role, status, true);
        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/add-staff.jsp").forward(request, response);
            return;
        }

        // Unique email.
        if (staffDao.checkIfEmailExists(email)) {
            request.setAttribute("error", "A staff member with that email already exists.");
            request.getRequestDispatcher("/WEB-INF/views/add-staff.jsp").forward(request, response);
            return;
        }

        // Hash and insert.
        String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());
        User user = new User(0, name, email, passwordHash, role, status);

        if (staffDao.addStaff(user)) {
            EmailService.send(email, name, "Welcome to Sunrise Dental Clinic",
                    "<p>Hi " + name + ",</p>"
                    + "<p>An account has been created for you on the Sunrise Dental Clinic staff system.</p>"
                    + "<p><b>Email:</b> " + email + "<br><b>Password:</b> " + password + "</p>"
                    + "<p>Please sign in and change your password when convenient.</p>");
            response.sendRedirect(request.getContextPath() + "/staffs");
        } else {
            request.setAttribute("error", "Could not add staff. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/add-staff.jsp").forward(request, response);
        }
    }

    private String trim(String s) {
        return s == null ? null : s.trim();
    }
}
