package controller;

import model.User;
import service.UserService;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.regex.Pattern;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        String error = validateRegistrationInput(name, email, phone, password, confirmPassword);
        
        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/view/authen/register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if (userService.isEmailExists(email)) {
            request.setAttribute("error", "Email đã được sử dụng. Vui lòng chọn email khác.");
            request.getRequestDispatcher("/view/authen/register.jsp").forward(request, response);
            return;
        }

        // Create new user
        User newUser = new User();
        newUser.setUserName(name.trim());
        newUser.setEmail(email.trim().toLowerCase());
        newUser.setPhoneNumber(phone.trim());
        newUser.setPassword(password); // In production, this should be hashed
        newUser.setStatus("active");
        newUser.setCreatedAt(new Timestamp(System.currentTimeMillis()));

        try {
            userService.register(newUser);
            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/view/authen/login.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra khi đăng ký. Vui lòng thử lại.");
            request.getRequestDispatcher("/view/authen/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Redirect to register page if accessed via GET
        response.sendRedirect(request.getContextPath() + "/view/authen/register.jsp");
    }

    private String validateRegistrationInput(String name, String email, String phone, String password, String confirmPassword) {
        // Check for null or empty values
        if (name == null || name.trim().isEmpty()) {
            return "Tên không được để trống";
        }
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống";
        }
        if (phone == null || phone.trim().isEmpty()) {
            return "Số điện thoại không được để trống";
        }
        if (password == null || password.isEmpty()) {
            return "Mật khẩu không được để trống";
        }
        if (confirmPassword == null || confirmPassword.isEmpty()) {
            return "Xác nhận mật khẩu không được để trống";
        }

        // Validate name length
        if (name.trim().length() < 2 || name.trim().length() > 50) {
            return "Tên phải có từ 2 đến 50 ký tự";
        }

        // Validate email format
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (!Pattern.matches(emailRegex, email.trim())) {
            return "Email không đúng định dạng";
        }

        // Validate phone format (Vietnamese phone numbers)
        String phoneRegex = "^(0|84)(3[2-9]|5[689]|7[06-9]|8[1-689]|9[0-46-9])[0-9]{7}$";
        if (!Pattern.matches(phoneRegex, phone.trim())) {
            return "Số điện thoại không đúng định dạng";
        }

        // Validate password strength
        if (password.length() < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
        }

        // Check password confirmation
        if (!password.equals(confirmPassword)) {
            return "Mật khẩu xác nhận không khớp";
        }

        return null; // No errors
    }
} 