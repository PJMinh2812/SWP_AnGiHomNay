/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authen;

import dao.UserDAO;
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
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(30 * 60);
                // LoginServlet xử lý đăng nhập
                boolean rememberMe = "on".equals(request.getParameter("remember"));
                if (rememberMe) {
                    Cookie emailCookie = new Cookie("email", user.getEmail());
                    emailCookie.setMaxAge(7 * 24 * 60 * 60);
                    response.addCookie(emailCookie);
                }

                response.sendRedirect(request.getContextPath() + "/view/index.jsp");
            } else {
                request.setAttribute("error", "Email hoặc mật khẩu không chính xác.");
                request.getRequestDispatcher("/view/authen/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace(); // Ghi log lỗi
            request.setAttribute("error", "Đã xảy ra lỗi, vui lòng thử lại.");
            request.getRequestDispatcher("/view/authen/login.jsp").forward(request, response);
        }
    }
}
