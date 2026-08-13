package com.Dental.servlets;

import java.io.IOException;

import com.Dental.dao.DentistDao;
import com.Dental.model.Dentist;
import com.Dental.util.DentistValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dentists/add")
public class AddDentistServlet extends HttpServlet {

    // the 7 day keys + labels, used for the working-hours inputs and validation
    static final String[] DAYS = {"mon", "tue", "wed", "thu", "fri", "sat", "sun"};
    static final String[] DAY_LABELS = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};

    // GET -> show the empty form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("formAction", request.getContextPath() + "/dentists/add");
        request.setAttribute("mode", "Add");
        request.getRequestDispatcher("/WEB-INF/views/dentist-form.jsp").forward(request, response);
    }

    // POST -> validate + insert
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name     = trim(request.getParameter("name"));
        String email    = trim(request.getParameter("email"));
        String feeText  = request.getParameter("consultationFee");
        String slotText = request.getParameter("slotMinutes");
        String status   = trim(request.getParameter("status"));

        DentistDao dentistDao = new DentistDao();

        // validate the fields (dentists have no password)
        String error = DentistValidator.validate(name, email, status, feeText, slotText);
        // validate each day's time range
        if (error == null) error = validateDays(request);
        if (error == null && dentistDao.checkIfEmailExists(email)) {
            error = "A user with that email already exists.";
        }
        if (error != null) {
            keepInput(request, "Add", request.getContextPath() + "/dentists/add");
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/views/dentist-form.jsp").forward(request, response);
            return;
        }

        // build the dentist and insert. No password (dentists can't log in),
        // so passwordHash is stored empty.
        Dentist dentist = buildFromRequest(request, 0);
        dentist.setPasswordHash("");

        if (dentistDao.addDentist(dentist)) {
            response.sendRedirect(request.getContextPath() + "/dentists");
        } else {
            keepInput(request, "Add", request.getContextPath() + "/dentists/add");
            request.setAttribute("error", "Could not add dentist. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/dentist-form.jsp").forward(request, response);
        }
    }

    // ---- shared helpers (also used by the edit servlet via the same day names) ----

    // Check every day's start/end pair.
    static String validateDays(HttpServletRequest request) {
        for (int i = 0; i < DAYS.length; i++) {
            String start = request.getParameter(DAYS[i] + "_start");
            String end = request.getParameter(DAYS[i] + "_end");
            String dayError = DentistValidator.validateDayRange(DAY_LABELS[i], start, end);
            if (dayError != null) return dayError;
        }
        return null;
    }

    // Turn the submitted form into a Dentist (id = the user id, 0 for a new one).
    static Dentist buildFromRequest(HttpServletRequest request, int id) {
        Dentist d = new Dentist();
        d.setId(id);
        d.setName(trim(request.getParameter("name")));
        d.setEmail(trim(request.getParameter("email")));
        d.setPhone(trim(request.getParameter("phone")));
        d.setSpecialization(trim(request.getParameter("specialization")));
        // toDouble/toInt return null if the text wasn't a number; default to 0 to avoid unboxing NPE.
        Double fee = DentistValidator.toDouble(request.getParameter("consultationFee"));
        d.setConsultationFee(fee == null ? 0 : fee);
        Integer slot = DentistValidator.toInt(request.getParameter("slotMinutes"));
        d.setSlotMinutes(slot == null ? 0 : slot);
        d.setStatus(trim(request.getParameter("status")));
        for (String day : DAYS) {
            d.getStartTimes().put(day, request.getParameter(day + "_start"));
            d.getEndTimes().put(day, request.getParameter(day + "_end"));
        }
        return d;
    }

    // On a validation error, re-show the form with what the user typed.
    static void keepInput(HttpServletRequest request, String mode, String action) {
        request.setAttribute("mode", mode);
        request.setAttribute("formAction", action);
        request.setAttribute("dentist", buildFromRequest(request,
                request.getParameter("id") == null ? 0
                        : DentistValidator.toInt(request.getParameter("id")) == null ? 0
                        : DentistValidator.toInt(request.getParameter("id"))));
    }

    static String trim(String s) {
        return s == null ? null : s.trim();
    }
}
