package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.StaffDao;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/staffs/delete")
public class DeleteStaffServlet extends HttpServlet {

    // POST only - deleting is a state change, so it should not be a GET link
    // (a browser prefetch or a crawler could otherwise trigger it).
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            // Bad id -> just go back to the list.
            response.sendRedirect(request.getContextPath() + "/staffs");
            return;
        }

        new StaffDao().deleteStaff(id);   // role='admin' guard is in the DAO
        response.sendRedirect(request.getContextPath() + "/staffs");
    }
}
