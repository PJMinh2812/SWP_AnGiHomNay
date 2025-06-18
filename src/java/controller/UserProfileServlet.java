/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.UserDAO;
import dao.DBconnection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;
import model.Users;

/**
 *
 * @author Admin
 */

@WebServlet(name = "UserProfileServlet", urlPatterns = {"/profile"})
public class UserProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String userIdParam = request.getParameter("userID");
            if (userIdParam == null || userIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID is missing.");
                return;
            }

            int userID;
            try {
                userID = Integer.parseInt(userIdParam);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid User ID format.");
                return;
            }

            UserDAO userDAO = new UserDAO(DBconnection.getConnection());
            Users user = userDAO.getUserWithRole(userID);
            
            if (user == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found.");
                return;
            }

            request.setAttribute("user", user);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/view/user-profile.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred on the server.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            
            if ("update".equals(action)) {
                updateUserProfile(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi. Vui lòng thử lại.");
            doGet(request, response);
        }
    }

    private void updateUserProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userID = Integer.parseInt(request.getParameter("userID"));
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");

        if (fullName == null || fullName.trim().length() < 2) {
            request.setAttribute("error", "Họ và tên phải có ít nhất 2 ký tự.");
            doGet(request, response);
            return;
        }

        Users user = new Users();
        user.setUserID(userID);
        user.setFullName(fullName.trim());
        user.setPhoneNumber(phoneNumber != null ? phoneNumber.trim() : "");

        UserDAO userDAO = new UserDAO(DBconnection.getConnection());
        boolean success = userDAO.updateUser(user);

        if (success) {
            request.setAttribute("message", "Cập nhật thông tin thành công!");
        } else {
            request.setAttribute("error", "Không thể cập nhật thông tin. Vui lòng thử lại.");
        }

        // Fixed redirect path
        response.sendRedirect(request.getContextPath() + "/profile?userID=" + userID);
    }
}