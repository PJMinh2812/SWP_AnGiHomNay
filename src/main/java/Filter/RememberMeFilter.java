package Filter;

import Dao.RememberMeTokenDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import Model.RememberMeToken;

import java.io.IOException;

// Bộ lọc "Remember Me" - tự động đăng nhập nếu có cookie hợp lệ
// Nếu đã có user trong session thì cho đi tiếp
// Nếu chưa có user, kiểm tra cookie "remember_token" và tự động đăng nhập nếu token hợp lệ
public class RememberMeFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        // Nếu đã có user trong session thì cho đi tiếp
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            chain.doFilter(request, response);
            return;
        }

        // Nếu chưa có user, kiểm tra cookie "remember_token"
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("remember_token".equals(c.getName())) {
                    String token = c.getValue();
                    RememberMeTokenDao tokenDao = new RememberMeTokenDao();
                    RememberMeToken rememberToken = tokenDao.findValidToken(token);
                    // Nếu token hợp lệ, tự động đăng nhập
                    if (rememberToken != null) {
                        req.getSession(true).setAttribute("user", rememberToken.getUser());
                        break;
                    }
                }
            }
        }

        // Cho phép request đi tiếp
        chain.doFilter(request, response);
    }
}
