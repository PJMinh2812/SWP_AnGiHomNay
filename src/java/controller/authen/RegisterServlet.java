/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
/**
 *
 * @author Admin
 */
package controller.authen;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu không khớp.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Users user = new Users();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhoneNumber(phone);

        try {
            UserDAO dao = new UserDAO();
            boolean success = dao.register(user);

            if (success) {

                Users loggedInUser = dao.login(email, password);
                if (loggedInUser != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", loggedInUser);
                    response.sendRedirect("/view/index.jsp"); 
                } else {
                    request.setAttribute("error", "Đăng ký thành công nhưng không thể tự động đăng nhập.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Đăng ký thất bại.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi đăng ký.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
