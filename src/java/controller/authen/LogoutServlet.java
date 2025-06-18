/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authen;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalidate session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Clear all remember me cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userEmail".equals(cookie.getName())
                        || "userID".equals(cookie.getName())
                        || "rememberMe".equals(cookie.getName())) {

                    Cookie clearCookie = new Cookie(cookie.getName(), "");
                    clearCookie.setMaxAge(0); // Delete cookie
                    String contextPath = request.getContextPath();
                    clearCookie.setPath(contextPath.isEmpty() ? "/" : contextPath);
                    response.addCookie(clearCookie);

                    System.out.println("Cleared cookie: " + cookie.getName());
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/view/authen/login.jsp");
    }
}
