<%-- 
    Document   : user-profile
    Created on : Jun 16, 2025, 3:30:12 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <style>
            /* Modal styles */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }
            .modal-content {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                max-width: 400px;
                width: 100%;
                position: relative;
            }
            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .modal-header h3 {
                margin: 0;
            }
            .modal-close {
                cursor: pointer;
                font-size: 1.5rem;
                color: #333;
            }
            .btn-primary {
                background-color: #007bff;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .user-role {
                font-weight: bold;
                color: #ff4d4d;
                margin-top: 5px;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="header">
            <div class="header-container">
                <div class="logo">
                    <a href="index.jsp"><h1>AnGiHomNay</h1></a>
                </div>
            </div>
        </header>

        <main class="profile-container">
            <c:choose>
                <c:when test="${not empty user}">
                    <div class="profile-card">
                        <div class="profile-header">
                            <div class="avatar">
                                <img src="<%= request.getContextPath()%>/images/user-avatar.png" alt="User Avatar">
                            </div>
                            <h2 class="username">${user.fullName}</h2>
                            <p class="user-role">
                            <c:choose>
                                <c:when test="${user.roleName != null}">
                                    ${user.roleName}
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-user-slash"></i> Vai trò chưa xác định
                                </c:otherwise>
                            </c:choose>
                            </p>
                        </div>
                        <div class="profile-details">
                            <form action="${pageContext.request.contextPath}/profile" method="get">
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" id="email" name="email" value="${user.email}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="fullname">Họ và Tên</label>
                                    <input type="text" id="fullname" name="fullname" value="${user.fullName}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="phone">Số Điện Thoại</label>
                                    <input type="tel" id="phone" name="phone" value="${user.phoneNumber}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="status">Trạng Thái</label>
                                    <input type="text" id="status" name="status" value="${user.status}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="createdAt">Ngày Tạo</label>
                                    <input type="text" id="createdAt" name="createdAt" value="${user.createdAt}" readonly>
                                </div>
                                <button id="editProfileBtn" type="button" class="btn-primary">Cập Nhật</button>
                            </form>
                            <button class="btn-secondary favorite-btn" onclick="window.location.href = 'favorites.jsp'">
                                <i class="fas fa-heart"></i> Xem Yêu Thích
                            </button>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="error-message">
                        <p>Không tìm thấy thông tin người dùng.</p>
                        <a href="index.jsp" class="btn-secondary">Quay lại trang chính</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <!-- Pop-up Modal -->
        <div class="modal" id="editProfileModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Chỉnh sửa thông tin</h3>
                    <span class="modal-close" id="closeModal">&times;</span>
                </div>
                <form action="${pageContext.request.contextPath}/updateProfile" method="post">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="${user.email}" readonly>
                    </div>
                    <div class="form-group">
                        <label for="fullname">Họ và Tên</label>
                        <input type="text" id="fullname" name="fullname" value="${user.fullName}" placeholder="Nhập họ và tên đầy đủ" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Số Điện Thoại</label>
                        <input type="tel" id="phone" name="phone" value="${user.phoneNumber}" placeholder="Nhập số điện thoại" required>
                    </div>
                    <button type="submit" class="btn-primary">Lưu Thay Đổi</button>
                </form>
            </div>
        </div>

        <script>
            const editProfileBtn = document.getElementById('editProfileBtn');
            const editProfileModal = document.getElementById('editProfileModal');
            const closeModal = document.getElementById('closeModal');

            editProfileBtn.addEventListener('click', () => {
                editProfileModal.style.display = 'flex';
            });

            closeModal.addEventListener('click', () => {
                editProfileModal.style.display = 'none';
            });

            window.addEventListener('click', (e) => {
                if (e.target === editProfileModal) {
                    editProfileModal.style.display = 'none';
                }
            });

            const form = document.querySelector("#editProfileModal form");
            form.addEventListener("submit", (event) => {
                const fullname = form.fullname.value.trim();
                const phone = form.phone.value.trim();

                if (fullname === "" || phone === "") {
                    event.preventDefault();
                    alert("Họ và tên hoặc số điện thoại không được để trống.");
                    return;
                }

                if (!/^\d{10,11}$/.test(phone)) {
                    event.preventDefault();
                    alert("Số điện thoại phải có 10-11 chữ số.");
                    return;
                }
            });
        </script>
    </body>
</html>