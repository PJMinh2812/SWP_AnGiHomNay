<%-- 
    Document   : forgot
    Created on : Jun 16, 2025, 6:58:46 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quên mật khẩu - AnGiHomNay</title>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/header.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/auth.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .success-message {
                display: none;
                text-align: center;
                color: #2ecc71;
                margin-top: 1rem;
                padding: 1rem;
                background-color: #f0fff4;
                border-radius: 5px;
            }

            .success-message i {
                font-size: 2rem;
                margin-bottom: 1rem;
                display: block;
            }

            .back-to-login {
                text-align: center;
                margin-top: 1.5rem;
            }

            .back-to-login a {
                color: #ff7979;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .back-to-login a:hover {
                text-decoration: underline;
            }
        </style>
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
                <h2>Quên mật khẩu</h2>
                <p style="text-align: center; color: #666; margin-bottom: 2rem;">
                    Nhập email của bạn để nhận hướng dẫn đặt lại mật khẩu
                </p>
                <form id="forgotPasswordForm" class="auth-form">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <div class="input-group">
                            <i class="fas fa-envelope"></i>
                            <input type="email" id="email" name="email" required placeholder="Nhập email của bạn">
                        </div>
                    </div>
                    <button type="submit" class="btn-primary btn-login-submit">Gửi yêu cầu</button>
                </form>

                <div class="success-message" id="successMessage">
                    <i class="fas fa-check-circle"></i>
                    <p>Chúng tôi đã gửi email hướng dẫn đặt lại mật khẩu đến địa chỉ email của bạn.</p>
                    <p>Vui lòng kiểm tra hộp thư và làm theo hướng dẫn.</p>
                </div>

                <div class="back-to-login">
                    <a href="login.html">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại đăng nhập
                    </a>
                </div>
            </div>
        </main>

        <script>
            document.getElementById('forgotPasswordForm').addEventListener('submit', function (e) {
                e.preventDefault();
                // Ẩn form
                this.style.display = 'none';
                // Hiển thị thông báo thành công
                document.getElementById('successMessage').style.display = 'block';
            });
        </script>
    </body>
</html> 