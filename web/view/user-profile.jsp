<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Hồ sơ người dùng của hệ thống AnGiHomNay.">
        <title>Hồ Sơ Người Dùng</title>
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/main.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/header.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/profile.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="icon" href="<%= request.getContextPath()%>/images/favicon.ico">
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="common/header.jsp"></jsp:include>
            <main>
                <div class="profile-container">
                    <div class="profile-card">
                        <!-- Profile Header with Favorite Icon -->
                        <div class="profile-header">

                            <div class="profile-actions">
                                <button type="button" class="favorite-btn" onclick="goToFavorites()" title="Danh sách yêu thích">
                                    <i class="fas fa-heart"></i>
                                    <span>Yêu thích</span>
                                </button>
                            </div>
                            <div class="avatar">
                                <img src="https://via.placeholder.com/120x120/FF6B6B/ffffff?text=${user.fullName.substring(0,1)}" 
                                 alt="Avatar">
                        </div>
                        <h2 class="username">${user.fullName}</h2>
                        <p class="user-role">
                            <i class="fas fa-user-tag"></i>
                            ${not empty user.roleName ? user.roleName : 'Người dùng'}
                        </p>

                    </div>

                    <!-- Profile Display Mode -->
                    <div id="profileDisplay" class="profile-details">
                        <div class="form-group">
                            <label><i class="fas fa-envelope"></i> Email:</label>
                            <input type="text" value="${user.email}" readonly>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-phone"></i> Số điện thoại:</label>
                            <input type="text" value="${not empty user.phoneNumber ? user.phoneNumber : 'Chưa cập nhật'}" readonly>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-info-circle"></i> Trạng thái:</label>
                            <input type="text" value="${user.status}" readonly>
                        </div>

                        <div class="form-group">
                            <label><i class="fas fa-calendar-alt"></i> Ngày tham gia:</label>
                            <input type="text" value="<fmt:formatDate value='${user.createdAt}' pattern='dd/MM/yyyy' />" readonly>
                        </div>

                        <!-- Action Buttons -->
                        <div class="profile-buttons">
                            <button type="button" class="btn-primary" onclick="toggleEditMode()">
                                <i class="fas fa-edit"></i> Chỉnh sửa thông tin
                            </button>

                            <button type="button" class="btn-secondary" onclick="togglePasswordMode()">
                                <i class="fas fa-key"></i> Đổi mật khẩu
                            </button>
                        </div>
                    </div>

                    <!-- Profile Edit Mode -->
                    <div id="profileEdit" class="profile-details" style="display: none;">
                        <form action="<%= request.getContextPath()%>/profile" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="userID" value="${user.userID}">

                            <div class="form-group">
                                <label for="fullName"><i class="fas fa-user"></i> Họ và tên *</label>
                                <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
                            </div>

                            <div class="form-group">
                                <label><i class="fas fa-envelope"></i> Email</label>
                                <input type="email" value="${user.email}" readonly>
                            </div>

                            <div class="form-group">
                                <label for="phoneNumber"><i class="fas fa-phone"></i> Số điện thoại</label>
                                <input type="tel" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}">
                            </div>

                            <div class="profile-buttons">
                                <button type="submit" class="btn-primary">
                                    <i class="fas fa-save"></i> Lưu thay đổi
                                </button>

                                <button type="button" class="btn-secondary" onclick="cancelEdit()">
                                    <i class="fas fa-times"></i> Hủy bỏ
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Change Password Mode -->
                    <div id="passwordChange" class="profile-details" style="display: none;">
                        <form action="<%= request.getContextPath()%>/changePassword" method="post" id="changePasswordForm">
                            <input type="hidden" name="userID" value="${user.userID}">

                            <div class="form-group">
                                <label for="currentPassword"><i class="fas fa-lock"></i> Mật khẩu hiện tại *</label>
                                <div class="password-input">
                                    <input type="password" id="currentPassword" name="currentPassword" required>
                                    <button type="button" class="toggle-password" onclick="togglePasswordVisibility('currentPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="newPassword"><i class="fas fa-key"></i> Mật khẩu mới *</label>
                                <div class="password-input">
                                    <input type="password" id="newPassword" name="newPassword" required minlength="6">
                                    <button type="button" class="toggle-password" onclick="togglePasswordVisibility('newPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <small class="form-text">Mật khẩu phải có ít nhất 6 ký tự</small>
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword"><i class="fas fa-shield-alt"></i> Xác nhận mật khẩu mới *</label>
                                <div class="password-input">
                                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                                    <button type="button" class="toggle-password" onclick="togglePasswordVisibility('confirmPassword')">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="profile-buttons">
                                <button type="submit" class="btn-primary">
                                    <i class="fas fa-save"></i> Đổi mật khẩu
                                </button>

                                <button type="button" class="btn-secondary" onclick="cancelPasswordChange()">
                                    <i class="fas fa-times"></i> Hủy bỏ
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Messages -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle"></i> ${message}
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            <i class="fas fa-exclamation-circle"></i> ${error}
                        </div>
                    </c:if>
                </div>
            </div>
        </main>

        <script>
            // Toggle between display and edit modes
            function toggleEditMode() {
                document.getElementById('profileDisplay').style.display = 'none';
                document.getElementById('profileEdit').style.display = 'block';
                document.getElementById('passwordChange').style.display = 'none';
            }

            function cancelEdit() {
                document.getElementById('profileEdit').style.display = 'none';
                document.getElementById('profileDisplay').style.display = 'block';
                document.getElementById('passwordChange').style.display = 'none';
            }

            // Toggle password change mode
            function togglePasswordMode() {
                document.getElementById('profileDisplay').style.display = 'none';
                document.getElementById('profileEdit').style.display = 'none';
                document.getElementById('passwordChange').style.display = 'block';
            }

            function cancelPasswordChange() {
                document.getElementById('passwordChange').style.display = 'none';
                document.getElementById('profileDisplay').style.display = 'block';
                document.getElementById('profileEdit').style.display = 'none';

                // Clear password fields
                document.getElementById('currentPassword').value = '';
                document.getElementById('newPassword').value = '';
                document.getElementById('confirmPassword').value = '';
            }

            // Toggle password visibility
            function togglePasswordVisibility(fieldId) {
                const field = document.getElementById(fieldId);
                const button = field.nextElementSibling;
                const icon = button.querySelector('i');

                if (field.type === 'password') {
                    field.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    field.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            }

            // Navigate to favorites page
            function goToFavorites() {
                window.location.href = '<%= request.getContextPath()%>/favorites?userID=${user.userID}';
                    }

                    // Form validation for password change
                    document.getElementById('changePasswordForm').addEventListener('submit', function (e) {
                        const currentPassword = document.getElementById('currentPassword').value;
                        const newPassword = document.getElementById('newPassword').value;
                        const confirmPassword = document.getElementById('confirmPassword').value;

                        if (currentPassword.length < 1) {
                            e.preventDefault();
                            alert('Vui lòng nhập mật khẩu hiện tại.');
                            return false;
                        }

                        if (newPassword.length < 6) {
                            e.preventDefault();
                            alert('Mật khẩu mới phải có ít nhất 6 ký tự.');
                            return false;
                        }

                        if (newPassword !== confirmPassword) {
                            e.preventDefault();
                            alert('Mật khẩu xác nhận không khớp.');
                            return false;
                        }

                        if (currentPassword === newPassword) {
                            e.preventDefault();
                            alert('Mật khẩu mới phải khác mật khẩu hiện tại.');
                            return false;
                        }
                    });
        </script>
    </body>
</html>