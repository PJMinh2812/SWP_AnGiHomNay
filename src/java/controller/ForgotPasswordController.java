package controller;

import service.UserService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        // Validate email
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email không được để trống");
            request.getRequestDispatcher("/view/authen/forgot.jsp").forward(request, response);
            return;
        }
        
        // Validate email format
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (!Pattern.matches(emailRegex, email.trim())) {
            request.setAttribute("error", "Email không đúng định dạng");
            request.getRequestDispatcher("/view/authen/forgot.jsp").forward(request, response);
            return;
        }
        
        // Check if email exists
        if (!userService.isEmailExists(email.trim())) {
            request.setAttribute("error", "Email không tồn tại trong hệ thống");
            request.getRequestDispatcher("/view/authen/forgot.jsp").forward(request, response);
            return;
        }
        
        // Generate temporary password (in production, this should be more secure)
        String tempPassword = generateTemporaryPassword();
        
        // Update password in database
        boolean success = userService.updatePassword(email.trim(), tempPassword);
        
        if (success) {
            // In a real application, you would send an email here
            // For now, we'll just show a success message
            request.setAttribute("success", "Mật khẩu tạm thời đã được gửi đến email của bạn. Vui lòng kiểm tra hộp thư.");
            request.setAttribute("tempPassword", tempPassword); // Remove this in production
        } else {
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại sau.");
        }
        
        request.getRequestDispatcher("/view/authen/forgot.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Redirect to forgot password page if accessed via GET
        response.sendRedirect(request.getContextPath() + "/view/authen/forgot.jsp");
    }
    
    private String generateTemporaryPassword() {
        // Generate a random 8-character password
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            int index = (int) (Math.random() * chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }
} 