package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        // Invalidate session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        // Clear remember me cookies
        Cookie userEmailCookie = new Cookie("userEmail", "");
        Cookie userIDCookie = new Cookie("userID", "");
        Cookie rememberMeCookie = new Cookie("rememberMe", "");
        
        userEmailCookie.setMaxAge(0);
        userIDCookie.setMaxAge(0);
        rememberMeCookie.setMaxAge(0);
        
        userEmailCookie.setPath(request.getContextPath());
        userIDCookie.setPath(request.getContextPath());
        rememberMeCookie.setPath(request.getContextPath());
        
        response.addCookie(userEmailCookie);
        response.addCookie(userIDCookie);
        response.addCookie(rememberMeCookie);
        
        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/view/authen/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        doGet(request, response);
    }
} 