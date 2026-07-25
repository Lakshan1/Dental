package com.Dental.servlets;

import java.io.IOException;
import java.util.List;

import com.Dental.dao.StaffDao;
import com.Dental.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/staffs")
public class StaffsServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int recordsPerPage = 3; // Number of records to display per page

        StaffDao staffDao = new StaffDao(); // Create an instance of StaffDao to interact with the database
        List<User> staffs = staffDao.getAllStaffs(page, recordsPerPage); // Retrieve staff members from the database with pagination
        request.setAttribute("staffs", staffs); // Set the staffs as a request attribute

        request.setAttribute("totalActiveStaffCount", staffDao.getTotalActiveStaffCount()); // Set the total active staff count as a request attribute
        request.setAttribute("totalStaffCount", staffDao.getTotalStaffCount()); // Set the total staff count as a request attribute
        request.setAttribute("totalOnLeaveStaffCount", staffDao.getTotalOnLeaveStaffCount()); // Set the total on-leave staff count as a request attribute
        request.setAttribute("page", page); // Set the current page number as a request attribute
        request.getRequestDispatcher("WEB-INF/views/staffs.jsp").forward(request, response);
    }
}
