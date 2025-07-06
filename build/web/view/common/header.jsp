<%-- 
    Document   : header
    Created on : Jun 18, 2025, 9:25:06 AM
    Author     : Admin
--%>
<%@page import="model.User"%>
<%@page import="DAO.UserDAO"%>
<%
    User user = (User) session.getAttribute("user");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AnGiHomNay - Nền tảng đánh giá và gợi ý ẩm thực</title>
        <link rel="icon" type="image/x-icon" href="<%= request.getContextPath()%>/img/logo.jpg">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/main.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/header.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/home.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/search.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .user-dropdown {
                position: relative;
                display: inline-block;
            }
            .avatar-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                cursor: pointer;
                border: 2px solid #eee;
                background: #fff;
                object-fit: cover;
                transition: box-shadow 0.2s;
            }
            .avatar-icon:hover {
                box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            }
            .dropdown-menu {
                display: none;
                position: absolute;
                right: 0;
                top: 110%;
                background: #fff;
                box-shadow: 0 2px 8px rgba(0,0,0,0.15);
                border-radius: 8px;
                min-width: 180px;
                z-index: 100;
                padding: 0.5rem 0;
                animation: fadeIn 0.2s;
            }
            .user-dropdown.open .dropdown-menu {
                display: block;
            }
            .dropdown-menu li {
                list-style: none;
            }
            .dropdown-menu a {
                display: block;
                padding: 0.75rem 1.5rem;
                color: #333;
                text-decoration: none;
                transition: background 0.2s;
            }
            .dropdown-menu a:hover {
                background: #f5f5f5;
            }
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }
        </style>
    </head>
    <header class="header">
        <div class="header-container">
            <div class="logo">
                <h1>AnGiHomNay</h1>
            </div>
            <nav class="main-nav">
                <ul>
                    <li><a href="<%= request.getContextPath()%>/view/index.jsp">Trang chủ</a></li>
                    <li><a href="<%= request.getContextPath()%>/view/random.jsp">Quay món</a></li>
                    <li><a href="<%= request.getContextPath()%>/view/trending.jsp">Món hot</a></li>
                    <li><a href="<%= request.getContextPath()%>/view/nutrition.jsp">Thực đơn & Dinh dưỡng</a></li>
                    <li><a href="<%= request.getContextPath()%>/view/packages.jsp">Gói đăng ký</a></li>
                    <li><a href="<%= request.getContextPath()%>/view/history.jsp">Lịch sử nấu ăn</a></li>
                </ul>
            </nav>
            <div class="user-actions">
                <% if (user == null) { %>
                    <a href="<%= request.getContextPath()%>/view/authen/login.jsp" class="btn-login">Đăng nhập</a>
                    <a href="<%= request.getContextPath()%>/view/authen/register.jsp" class="btn-register">Đăng ký</a>
                <% } else { %>
                    <div class="user-dropdown" id="userDropdownWrap">
                        <img src="<%= request.getContextPath()%>/img/avatar-default.png" alt="User" class="avatar-icon" id="avatarIcon">
                        <ul class="dropdown-menu" id="userDropdown">
                            <li><a href="<%= request.getContextPath()%>/view/user-profile.jsp"><i class="fas fa-user"></i> Trang cá nhân</a></li>
                            <li><a href="<%= request.getContextPath()%>/settings.jsp"><i class="fas fa-cog"></i> Cài đặt</a></li>
                            <li><a href="<%= request.getContextPath()%>/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                        </ul>
                    </div>
                <% } %>
            </div>
        </div>
    </header>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var avatar = document.getElementById('avatarIcon');
            var dropdownWrap = document.getElementById('userDropdownWrap');
            if (avatar && dropdownWrap) {
                avatar.addEventListener('click', function(e) {
                    e.stopPropagation();
                    dropdownWrap.classList.toggle('open');
                });
                document.addEventListener('click', function() {
                    dropdownWrap.classList.remove('open');
                });
            }
        });
    </script>
</html>
