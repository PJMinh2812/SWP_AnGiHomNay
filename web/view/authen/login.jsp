<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập - AnGiHomNay</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/header.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/auth.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <!-- Header -->
        <header class="header">
            <div class="header-container">
                <div class="logo">
                    <a href="<%= request.getContextPath() %>/view/index.jsp"><h1>AnGiHomNay</h1></a>
                </div>
            </div>
        </header>

        <main class="auth-container">
            <div class="auth-box">
                <h2>Đăng nhập</h2>
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) {%>  
                <div class="error-message"><%= error%></div>
                <% }%>

                <form action="${pageContext.request.contextPath}/login" method="post" id="loginform" class="auth-form">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <div class="input-group">
                            <i class="fas fa-envelope"></i>
                            <input type="email" id="email" name="email" required placeholder="Nhập email của bạn">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu">
                            <button type="button" class="toggle-password">
                                <i class="fas fa-eye"></i>
                            </button>
                        </div>
                    </div>
                    <div class="form-options">
                        <label class="remember-me">
                            <input type="checkbox" name="remember" >
                            <span>Ghi nhớ đăng nhập</span>
                        </label>
                        <a href="forgot-password.html" class="forgot-password">Quên mật khẩu?</a>
                    </div>
                    <button type="submit" class="btn-primary btn-login-submit">Đăng nhập</button>
                </form>

                <div class="auth-separator"><span>hoặc</span></div>

                <div class="social-login">
                    <button class="btn-social btn-google">
                        <i class="fab fa-google"></i>
                        <span>Đăng nhập với Google</span>
                    </button>
                </div>

                <p class="auth-switch">
                    Chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a>
                </p>
            </div>
        </main>

        <script src="<%= request.getContextPath() %>/js/auth.js"></script>
    </body>
</html>