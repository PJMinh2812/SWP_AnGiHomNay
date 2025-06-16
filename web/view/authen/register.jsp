<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng ký - AnGiHomNay</title>
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
                <h2>Đăng ký</h2>
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) {%>  
                <div class="error-message"><%= error%></div>
                <% }%>

                <form id="registerForm" class="auth-form" method="post" action="${pageContext.request.contextPath}/register">
                    <!-- Full Name -->
                    <div class="form-group">
                        <label for="name">Tên</label>
                        <div class="input-group">
                            <i class="fas fa-user"></i>
                            <input type="text" id="name" name="name" required placeholder="Nhập tên của bạn">
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="email">Email</label>
                        <div class="input-group">
                            <i class="fas fa-envelope"></i>
                            <input type="email" id="email" name="email" required placeholder="Nhập email của bạn">
                        </div>
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label for="phone">Số điện thoại</label>
                        <div class="input-group">
                            <i class="fas fa-phone"></i>
                            <input type="text" id="phone" name="phone" required placeholder="Nhập số điện thoại">
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu">
                            <button type="button" class="toggle-password"><i class="fas fa-eye"></i></button>
                        </div>
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group">
                        <label for="confirmPassword">Xác nhận mật khẩu</label>
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Xác nhận mật khẩu">
                            <button type="button" class="toggle-password"><i class="fas fa-eye"></i></button>
                        </div>
                    </div>

                    <button type="submit" class="btn-primary btn-register-submit">Đăng ký</button>
                </form>

                <p class="auth-switch">
                    Đã có tài khoản? <a href="<%= request.getContextPath() %>/view/authen/login.jsp">Đăng nhập</a>
                </p>
            </div>
        </main>

        <script src="<%= request.getContextPath() %>/js/auth.js"></script>
    </body>
</html>