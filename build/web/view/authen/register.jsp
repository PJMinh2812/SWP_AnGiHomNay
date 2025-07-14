<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - AnGiHomNay</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/logo.jpg">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animations.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body>
<div class="auth-container">
    <div class="auth-card fade-in">
        <!-- Logo -->
        <div class="auth-logo">
            <img src="${pageContext.request.contextPath}/img/logo.jpg" alt="AnGiHomNay">
        </div>

        <!-- Header -->
        <div class="auth-header">
            <h2>Đăng ký tài khoản</h2>
            <p>Tạo tài khoản để khám phá thế giới ẩm thực cùng AnGiHomNay</p>
        </div>

        <!-- Error/Success Messages -->
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div class="error-message shake">
            <i class="fas fa-exclamation-circle"></i>
            <%= error %>
        </div>
        <% } %>

        <% String success = (String) request.getAttribute("success"); %>
        <% if (success != null) { %>
        <div class="success-message scale-in">
            <i class="fas fa-check-circle"></i>
            <%= success %>
        </div>
        <% } %>

        <!-- Registration Form -->
        <form class="auth-form" action="${pageContext.request.contextPath}/register" method="POST" id="registerForm">

            <!-- Name Field - SỬA TỪ username THÀNH name -->
            <div class="form-group">
                <label for="name">
                    <i class="fas fa-user"></i> Họ và tên
                </label>
                <input type="text"
                       id="name"
                       name="name"
                       class="input-focus-animation"
                       placeholder="Nhập họ và tên"
                       value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>"
                       required>
                <div class="field-error" id="nameError"></div>
            </div>

            <!-- Email -->
            <div class="form-group">
                <label for="email">
                    <i class="fas fa-envelope"></i> Email
                </label>
                <input type="email"
                       id="email"
                       name="email"
                       class="input-focus-animation"
                       placeholder="Nhập email của bạn"
                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"
                       required>
                <div class="field-error" id="emailError"></div>
            </div>

            <!-- Phone -->
            <div class="form-group">
                <label for="phone">
                    <i class="fas fa-phone"></i> Số điện thoại
                </label>
                <input type="tel"
                       id="phone"
                       name="phone"
                       class="input-focus-animation"
                       placeholder="Nhập số điện thoại"
                       value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>"
                       required>
                <div class="field-error" id="phoneError"></div>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label for="password">
                    <i class="fas fa-lock"></i> Mật khẩu
                </label>
                <div class="password-group">
                    <input type="password"
                           id="password"
                           name="password"
                           class="input-focus-animation"
                           placeholder="Nhập mật khẩu"
                           required>
                    <button type="button" class="password-toggle" onclick="togglePassword('password')">
                        <i class="fas fa-eye" id="passwordIcon"></i>
                    </button>
                </div>
                <div class="field-error" id="passwordError"></div>
                <small class="form-text">Mật khẩu phải có ít nhất 6 ký tự</small>
            </div>

            <!-- Confirm Password -->
            <div class="form-group">
                <label for="confirmPassword">
                    <i class="fas fa-lock"></i> Xác nhận mật khẩu
                </label>
                <div class="password-group">
                    <input type="password"
                           id="confirmPassword"
                           name="confirmPassword"
                           class="input-focus-animation"
                           placeholder="Nhập lại mật khẩu"
                           required>
                    <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                        <i class="fas fa-eye" id="confirmPasswordIcon"></i>
                    </button>
                </div>
                <div class="field-error" id="confirmPasswordError"></div>
            </div>

            <!-- Terms and Conditions -->
            <div class="checkbox-group">
                <input type="checkbox" id="terms" name="terms" required>
                <label for="terms">
                    Tôi đồng ý với <a href="#" style="color: var(--primary-color);">Điều khoản sử dụng</a>
                    và <a href="#" style="color: var(--primary-color);">Chính sách bảo mật</a>
                </label>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="auth-btn btn-hover-effect" id="registerBtn">
                <i class="fas fa-user-plus"></i>
                Đăng ký
            </button>
        </form>

        <!-- Login Link -->
        <div class="auth-links">
            <p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/view/authen/login.jsp">Đăng nhập ngay</a></p>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    // Toggle Password Visibility
    function togglePassword(inputId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById(inputId + 'Icon');

        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }

    // Form Validation - SỬA LẠI ĐỂ KHỚP VỚI FIELDS MỚI
    document.getElementById('registerForm').addEventListener('submit', function (e) {
        e.preventDefault();

        const name = document.getElementById('name').value.trim();
        const email = document.getElementById('email').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const terms = document.getElementById('terms').checked;

        let isValid = true;

        // Clear previous errors
        clearErrors();

        // Validate name
        if (name.length < 2) {
            showError('nameError', 'Họ tên phải có ít nhất 2 ký tự');
            isValid = false;
        }

        // Validate email
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            showError('emailError', 'Email không hợp lệ');
            isValid = false;
        }

        // Validate phone
        const phoneRegex = /^(0|84)(3[2-9]|5[689]|7[06-9]|8[1-689]|9[0-46-9])[0-9]{7}$/;
        if (!phoneRegex.test(phone)) {
            showError('phoneError', 'Số điện thoại không đúng định dạng');
            isValid = false;
        }

        // Validate password
        if (password.length < 6) {
            showError('passwordError', 'Mật khẩu phải có ít nhất 6 ký tự');
            isValid = false;
        }

        // Validate confirm password
        if (password !== confirmPassword) {
            showError('confirmPasswordError', 'Mật khẩu xác nhận không khớp');
            isValid = false;
        }

        // Validate terms
        if (!terms) {
            alert('Vui lòng đồng ý với điều khoản sử dụng');
            isValid = false;
        }

        if (isValid) {
            // Show loading state
            const btn = document.getElementById('registerBtn');
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
            btn.disabled = true;

            // Submit form
            this.submit();
        }
    });

    function showError(elementId, message) {
        const errorElement = document.getElementById(elementId);
        errorElement.textContent = message;
        errorElement.parentElement.classList.add('error');
    }

    function clearErrors() {
        const errorElements = document.querySelectorAll('.field-error');
        errorElements.forEach(element => {
            element.textContent = '';
            element.parentElement.classList.remove('error');
        });
    }

    // Real-time validation
    document.getElementById('confirmPassword').addEventListener('input', function () {
        const password = document.getElementById('password').value;
        const confirmPassword = this.value;

        if (confirmPassword && password !== confirmPassword) {
            showError('confirmPasswordError', 'Mật khẩu xác nhận không khớp');
        } else {
            document.getElementById('confirmPasswordError').textContent = '';
            this.parentElement.parentElement.classList.remove('error');
        }
    });
</script>
</body>
</html>