/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authen;

import repository.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            UserDAO dao = new UserDAO();
            Users user = dao.login(email, password);

            if (user != null) {
                // Create session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userID", user.getUserID());
                session.setAttribute("userEmail", user.getEmail());
                session.setMaxInactiveInterval(24 * 60 * 60); // 24 hours

                // Handle "Ghi nhớ đăng nhập" checkbox
                String rememberMe = request.getParameter("remember");
                if ("on".equals(rememberMe) || "true".equals(rememberMe)) {
                    // Create remember me cookies
                    Cookie emailCookie = new Cookie("userEmail", user.getEmail());
                    Cookie userIdCookie = new Cookie("userID", String.valueOf(user.getUserID()));
                    Cookie rememberCookie = new Cookie("rememberMe", "true");

                    // Set cookie expiration (30 days)
                    int cookieAge = 30 * 24 * 60 * 60;
                    emailCookie.setMaxAge(cookieAge);
                    userIdCookie.setMaxAge(cookieAge);
                    rememberCookie.setMaxAge(cookieAge);

                    // Set cookie path for proper scope
                    String contextPath = request.getContextPath();
                    emailCookie.setPath(contextPath.isEmpty() ? "/" : contextPath);
                    userIdCookie.setPath(contextPath.isEmpty() ? "/" : contextPath);
                    rememberCookie.setPath(contextPath.isEmpty() ? "/" : contextPath);

                    // Add cookies to response
                    response.addCookie(emailCookie);
                    response.addCookie(userIdCookie);
                    response.addCookie(rememberCookie);

                    System.out.println("Remember me cookies created for user: " + user.getEmail());
                }

                response.sendRedirect(request.getContextPath() + "/view/index.jsp");
            } else {
                request.setAttribute("error", "Email hoặc mật khẩu không chính xác.");
                request.getRequestDispatcher("/view/authen/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi, vui lòng thử lại.");
            request.getRequestDispatcher("/view/authen/login.jsp").forward(request, response);
        }
    }
}
