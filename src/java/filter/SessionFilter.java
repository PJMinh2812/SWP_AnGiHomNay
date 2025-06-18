/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import repository.UserDAO;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;

/**
 *
 * @author Admin
 */
@WebFilter(filterName = "SessionFilter", urlPatterns = {"/profile", "/view/*"})
public class SessionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Skip filter for login/logout pages and static resources
        String requestURI = httpRequest.getRequestURI();
        if (requestURI.contains("/login") || requestURI.contains("/logout")
                || requestURI.contains("/register") || requestURI.contains(".css")
                || requestURI.contains(".js") || requestURI.contains(".jpg")
                || requestURI.contains(".png")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        Users user = null;

        if (session != null) {
            user = (Users) session.getAttribute("user");
        }

        // If no user in session, try to restore from cookies
        if (user == null) {
            user = restoreUserFromCookies(httpRequest, httpResponse);
        }

        // Continue with the request
        chain.doFilter(request, response);
    }

    private Users restoreUserFromCookies(HttpServletRequest request, HttpServletResponse response) {
        String userEmail = null;
        String userIdStr = null;
        boolean rememberMe = false;

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                switch (cookie.getName()) {
                    case "userEmail":
                        userEmail = cookie.getValue();
                        break;
                    case "userID":
                        userIdStr = cookie.getValue();
                        break;
                    case "rememberMe":
                        rememberMe = "true".equals(cookie.getValue());
                        break;
                }
            }
        }

        if (rememberMe && userEmail != null && userIdStr != null) {
            try {
                int userId = Integer.parseInt(userIdStr);
                UserDAO userDAO = new UserDAO();
                Users user = userDAO.getUserWithRole(userId);

                if (user != null && user.getEmail().equals(userEmail)) {
                    // Recreate session
                    HttpSession newSession = request.getSession(true);
                    newSession.setAttribute("user", user);
                    newSession.setAttribute("userID", user.getUserID());
                    newSession.setAttribute("userEmail", user.getEmail());
                    newSession.setMaxInactiveInterval(24 * 60 * 60);
                    return user;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return null;
    }

}
