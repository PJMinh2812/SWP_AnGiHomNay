package controller;

import model.User;
import service.UserService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.Cookie;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("remember");

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email và mật khẩu không được để trống");
            request.getRequestDispatcher("/view/authen/login.jsp").forward(request, response);
            return;
        }

        User user = userService.login(email.trim(), password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userID", user.getId());
            session.setAttribute("userEmail", user.getEmail());
            
            // Handle remember me
            if ("on".equals(rememberMe)) {
                Cookie userEmailCookie = new Cookie("userEmail", user.getEmail());
                Cookie userIDCookie = new Cookie("userID", String.valueOf(user.getId()));
                Cookie rememberMeCookie = new Cookie("rememberMe", "true");
                
                userEmailCookie.setMaxAge(24 * 60 * 60); // 24 hours
                userIDCookie.setMaxAge(24 * 60 * 60);
                rememberMeCookie.setMaxAge(24 * 60 * 60);
                
                userEmailCookie.setPath(request.getContextPath());
                userIDCookie.setPath(request.getContextPath());
                rememberMeCookie.setPath(request.getContextPath());
                
                response.addCookie(userEmailCookie);
                response.addCookie(userIDCookie);
                response.addCookie(rememberMeCookie);
            }
            
            response.sendRedirect(request.getContextPath() + "/view/index.jsp");
        } else {
            request.setAttribute("error", "Email hoặc mật khẩu không đúng");
            request.getRequestDispatcher("/view/authen/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Redirect to login page if accessed via GET
        response.sendRedirect(request.getContextPath() + "/view/authen/login.jsp");
    }
}
