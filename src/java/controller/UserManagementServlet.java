package controller;


import dao.UserDAO;
import model.Users;
import dao.DBconnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

public class UserManagementServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        UserDAO dao = new UserDAO(DBconnection.getConnection());
        try {
            if ("export".equals(action)) {
                List<Users> users = dao.getAllUsers();
                resp.setContentType("text/csv");
                resp.setHeader("Content-Disposition", "attachment;filename=users.csv");
                PrintWriter out = resp.getWriter();
                out.println("UserID,Email,FullName,Status");
                for (Users u : users) {
                    out.println(u.getUserID() + "," + u.getEmail() + "," + u.getFullName() + "," + u.getStatus());
                }
                out.flush();
                return;
            }
            List<Users> users = dao.getAllUsers();
            req.setAttribute("users", users);
            req.getRequestDispatcher("/view/user_list.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        int userId = Integer.parseInt(req.getParameter("userId"));
        UserDAO dao = new UserDAO(DBconnection.getConnection());
        try {
            if ("ban".equals(action)) {
                dao.updateUserStatus(userId, "banned");
            } else if ("unban".equals(action)) {
                dao.updateUserStatus(userId, "active");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
        resp.sendRedirect("UserManagementServlet");
    }
}