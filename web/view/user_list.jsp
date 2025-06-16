<%-- 
    Document   : user_list
    Created on : Jun 15, 2025, 3:19:40 PM
    Author     : Admin
--%> 
<%@ page import="java.util.List,model.User" %> 
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<% 
    List<Users> users = (List<Users>) request.getAttribute("users");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quản lý người dùng - AnGiHomNay</title>
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/main.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/header.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/home.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/search.css"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
            />
        <style>
            .user-section {
                margin-top: 2rem;
            }
            .user-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 1.5rem;
            }
            .user-header h2 {
                color: var(--primary-color);
                font-size: 2rem;
                font-weight: 700;
            }
            .user-table-container {
                background: var(--white);
                border-radius: var(--border-radius);
                box-shadow: var(--shadow-sm);
                padding: 2rem 1rem;
                overflow-x: auto;
            }
            .user-table {
                width: 100%;
                border-collapse: collapse;
                min-width: 700px;
            }
            .user-table th,
            .user-table td {
                padding: 0.75rem 1rem;
                text-align: left;
                border-bottom: 1px solid var(--gray-200);
            }
            .user-table th {
                background: var(--gray-100);
                color: var(--primary-color);
                font-weight: 600;
            }
            .user-table tr:last-child td {
                border-bottom: none;
            }
            .user-table tr:hover {
                background: var(--gray-100);
            }
            .action-btn {
                padding: 0.4rem 1rem;
                border-radius: var(--border-radius);
                border: none;
                font-weight: 600;
                cursor: pointer;
                margin-right: 0.5rem;
                transition: background 0.2s, color 0.2s;
            }
            .ban {
                background: var(--primary-color);
                color: var(--white);
            }
            .ban:hover {
                background: #d94c4c;
            }
            .unban {
                background: var(--secondary-color);
                color: var(--white);
            }
            .unban:hover {
                background: #3bb6a4;
            }
            .export-btn {
                margin-top: 1.5rem;
                padding: 0.6rem 1.5rem;
                background: var(--accent-color);
                color: var(--text-color);
                border: none;
                border-radius: var(--border-radius);
                font-weight: 600;
                cursor: pointer;
                box-shadow: var(--shadow-sm);
                transition: background 0.2s;
            }
            .export-btn:hover {
                background: #ffe066;
            }
            @media (max-width: 900px) {
                .user-table-container {
                    padding: 1rem 0.2rem;
                }
                .user-header h2 {
                    font-size: 1.3rem;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="header">
            <div class="header-container">
                <div class="logo">
                    <h1>AnGiHomNay</h1>
                </div>
                <nav class="main-nav">
                    <ul>
                        <li><a href="../index.html">Trang chủ</a></li>
                        <li><a href="#" class="active">Quản lý người dùng</a></li>
                    </ul>
                </nav>
                <div class="user-actions">
                    <a href="../login.html" class="btn-login">Đăng nhập</a>
                    <a href="../register.html" class="btn-register">Đăng ký</a>
                </div>
            </div>
        </header>
        <main>
            <section class="user-section container fade-in">
                <div class="user-header">
                    <h2>Quản lý tài khoản người dùng</h2>
                    <form method="get" action="UserManagementServlet">
                        <button class="export-btn" name="action" value="export">
                            <i class="fas fa-file-export"></i> Xuất file
                        </button>
                    </form>
                </div>
                <div class="user-table-container">
                    <table class="user-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>Họ tên</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Users u : users) {%>
                            <tr>
                                <td><%= u.getUserID()%></td>
                                <td><%= u.getEmail()%></td>
                                <td><%= u.getFullName()%></td>
                                <td>
                                    <% if ("banned".equals(u.getStatus())) { %>
                                    <span
                                        style="color: var(--primary-color); font-weight: 600"
                                        >Banned</span
                                    >
                                    <% } else { %>
                                    <span
                                        style="color: var(--secondary-color); font-weight: 600"
                                        >Active</span
                                    >
                                    <% }%>
                                </td>
                                <td>
                                    <form
                                        method="post"
                                        action="UserManagementServlet"
                                        style="display: inline"
                                        >
                                        <input
                                            type="hidden"
                                            name="userId"
                                            value="<%= u.getUserID()%>"
                                            />
                                        <% if ("banned".equals(u.getStatus())) { %>
                                        <button
                                            class="action-btn unban"
                                            name="action"
                                            value="unban"
                                            >
                                            <i class="fas fa-unlock"></i> Unban
                                        </button>
                                        <% } else { %>
                                        <button
                                            class="action-btn ban"
                                            name="action"
                                            value="ban"
                                            >
                                            <i class="fas fa-ban"></i> Ban
                                        </button>
                                        <% } %>
                                    </form>
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
        <footer class="footer">
            <div class="footer-content">
                <div class="footer-section">
                    <h4>Về AnGiHomNay</h4>
                    <ul>
                        <li><a href="#">Giới thiệu</a></li>
                        <li><a href="#">Điều khoản sử dụng</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Liên hệ</h4>
                    <ul>
                        <li><a href="#">Hỗ trợ</a></li>
                        <li><a href="#">Góp ý</a></li>
                        <li><a href="#">FAQ</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Theo dõi chúng tôi</h4>
                    <div class="social-links">
                        <a href="#"><i class="fab fa-facebook"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 AnGiHomNay. All rights reserved.</p>
            </div>
        </footer>
    </body>
</html>
