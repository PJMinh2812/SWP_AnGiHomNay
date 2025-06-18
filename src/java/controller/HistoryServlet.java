package controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "HistoryServlet", urlPatterns = { "/history" })
public class HistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/view/authen/login.jsp");
            return;
        }
        List<Map<String, Object>> history = (List<Map<String, Object>>) session
                .getAttribute("history_" + user.getUserID());
        if (history == null)
            history = new ArrayList<>();
        request.setAttribute("history", history);
        request.getRequestDispatcher("/view/history.jsp").forward(request, response);
    }
}