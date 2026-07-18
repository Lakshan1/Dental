package com.Dental.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {"/index",})
public class AuthFilter implements Filter {
    // This filter can be used to implement authentication and authorization logic
    // FilterChain allows the request to proceed to the next filter or servlet in the chain
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request; // Cast the ServletRequest to HttpServletRequest to access HTTP-specific methods
        HttpServletResponse httpResponse = (HttpServletResponse) response; // Cast the ServletResponse to HttpServletResponse to access HTTP-specific methods

        HttpSession session = httpRequest.getSession(false); // Get the current session without creating a new one if it doesn't exist

        boolean isLoggedIn = session != null && session.getAttribute("user") != null; // Check if the user is logged in by verifying the session and user attribute

        if (isLoggedIn) {
            chain.doFilter(request, response);
        }else{
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login"); // Redirect to the login page if the user is not logged in
        }
    }
    
}
