package Filter;

import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// Bộ lọc xác thực người dùng đã đăng nhập (session management)
// Nếu chưa đăng nhập, chuyển hướng về trang login
// Nếu đã đăng nhập, cho phép request đi tiếp
@WebFilter(urlPatterns = {
        "/admin/*", "/customer/*", "/restaurant/*", "/update-avatar", "/change-password", "/user/profile"
})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Nếu chưa đăng nhập, chuyển hướng về trang login
        if (user == null) {
            req.getSession().setAttribute("flash_eror", "Vui lòng đăng nhập.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        // Nếu đã đăng nhập, cho phép request đi tiếp
        filterChain.doFilter(servletRequest, servletResponse);
    }
}
