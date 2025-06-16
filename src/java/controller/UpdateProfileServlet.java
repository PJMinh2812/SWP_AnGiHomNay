/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DBconnection;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/updateProfile"})
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullname");
        String phoneNumber = request.getParameter("phone");

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("view/authen/login.jsp");
            return;
        }

        try {
            // Cập nhật thông tin trong cơ sở dữ liệu
            UserDAO userDAO = new UserDAO(DBconnection.getConnection());
            user.setFullName(fullName);
            user.setPhoneNumber(phoneNumber);

            boolean isUpdated = userDAO.updateUser(user);

            if (isUpdated) {
                session.setAttribute("user", user);
                response.sendRedirect("user-profile.jsp"); 
            } else {
                request.setAttribute("error", "Cập nhật thông tin thất bại.");
                request.getRequestDispatcher("user-profile.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi cập nhật thông tin.");
            request.getRequestDispatcher("user-profile.jsp").forward(request, response);
        }
    }
}
