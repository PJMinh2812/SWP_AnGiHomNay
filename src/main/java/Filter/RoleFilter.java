package Filter;

import Model.Constant.Role;
import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/*
 * FLOW: Role-Based Access Control (RBAC)
 * 1. Khi người dùng truy cập các đường dẫn /admin/*, /customer/*, /restaurant/*, filter này sẽ được kích hoạt.
 * 2. Lấy thông tin user từ session.
 * 3. Kiểm tra role của user có phù hợp với đường dẫn không (ADMIN, CUSTOMER, RESTAURANT).
 * 4. Nếu không đúng role, chuyển hướng về trang login và báo lỗi.
 * 5. Nếu hợp lệ, cho phép request đi tiếp vào controller.
 *
 * File chính: RoleFilter.java
 */
// Bộ lọc kiểm tra quyền truy cập dựa trên vai trò người dùng (RBAC)
// Chỉ cho phép truy cập các đường dẫn /admin/*, /customer/*, /restaurant/* nếu user có role phù hợp
// Nếu không đúng role, chuyển hướng về trang login và báo lỗi
@WebFilter(urlPatterns = { "/admin/*", "/customer/*", "/restaurant/*" })
public class RoleFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
            throws IOException, ServletException {
        // Ép kiểu request/response về HTTP
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        // Lấy session hiện tại (nếu có)
        HttpSession session = req.getSession(false);

        // Lấy thông tin user từ session
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // Nếu chưa đăng nhập, chuyển hướng về trang login (AuthFilter sẽ xử lý chính)
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy đường dẫn và vai trò user
        String uri = req.getRequestURI();
        Role role = user.getRole();

        // Kiểm tra quyền truy cập: nếu không đúng role với đường dẫn thì báo lỗi và
        // chuyển hướng
        if (uri.startsWith(req.getContextPath() + "/admin") && role != Role.ADMIN
                || uri.startsWith(req.getContextPath() + "/customer") && role != Role.CUSTOMER
                || uri.startsWith(req.getContextPath() + "/restaurant") && role != Role.RESTAURANT) {
            req.getSession().setAttribute("flash_error", "Bạn không có quyền truy cập tài nguyên này.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Nếu hợp lệ, cho phép request đi tiếp
        filterChain.doFilter(request, response);
    }
}
