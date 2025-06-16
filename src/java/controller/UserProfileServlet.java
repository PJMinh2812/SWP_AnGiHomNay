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
            // Lấy tham số userID từ request
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

            // Tạo DAO và lấy thông tin người dùng
            UserDAO userDAO = new UserDAO(DBconnection.getConnection());
            Users user = userDAO.getUserWithRole(userID);

            if (user == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found.");
                return;
            }

            // Đưa thông tin người dùng vào request scope
            request.setAttribute("user", user);

            // Chuyển tiếp đến file JSP để hiển thị
            RequestDispatcher dispatcher = request.getRequestDispatcher("/user-profile.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            // Ghi log lỗi và trả về mã lỗi 500
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred on the server.");
        }
    }
}
