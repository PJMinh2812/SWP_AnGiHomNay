/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.authen;

import repository.DBconnection;
import repository.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/changePassword"})
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // Validate input
            if (currentPassword == null || currentPassword.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập mật khẩu hiện tại.");
                redirectToProfile(request, response, userID);
                return;
            }

            if (newPassword == null || newPassword.length() < 6) {
                request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự.");
                redirectToProfile(request, response, userID);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
                redirectToProfile(request, response, userID);
                return;
            }

            if (currentPassword.equals(newPassword)) {
                request.setAttribute("error", "Mật khẩu mới phải khác mật khẩu hiện tại.");
                redirectToProfile(request, response, userID);
                return;
            }

            // Verify current password and update
            UserDAO userDAO = new UserDAO(DBconnection.getConnection());
            boolean success = userDAO.changePassword(userID, currentPassword, newPassword);

            if (success) {
                request.setAttribute("message", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("error", "Mật khẩu hiện tại không chính xác.");
            }

            redirectToProfile(request, response, userID);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi đổi mật khẩu.");
            int userID = Integer.parseInt(request.getParameter("userID"));
            redirectToProfile(request, response, userID);
        }
    }

    private void redirectToProfile(HttpServletRequest request, HttpServletResponse response, int userID)
            throws IOException {
        response.sendRedirect(request.getContextPath() + "/profile?userID=" + userID);
    }
}
