<%-- 
    Document   : nutrition
    Created on : Jun 14, 2025, 3:28:38 PM
    Author     : Admin
--%>
<%@ page import= "model.Users"%> 
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<%
    List<Users> users = (List<Users>) request.getAttribute("users"); 
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thực đơn & Dinh dưỡng - AnGiHomNay</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/header.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/search.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/nutrition.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                    <li><a href="index.html">Trang chủ</a></li>
                    <li><a href="random.html">Quay món</a></li>
                    <li><a href="trending.html">Món hot</a></li>
                    <li><a href="nutrition.html">Thực đơn & Dinh dưỡng</a></li>
                    <li><a href="packages.html">Gói đăng ký</a></li>
                    <li><a href="history.html">Lịch sử nấu ăn</a></li>
                </ul>
            </nav>
            <div class="user-actions">
                <a href="login.html" class="btn-login">Đăng nhập</a>
                <a href="register.html" class="btn-register">Đăng ký</a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main>
        <!-- Search Bar -->
        <div class="search-bar">
            <div class="search-wrapper">
                <div class="search-input">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Tìm kiếm món ăn, nhà hàng...">
                </div>
                <div class="search-filters">
                    <select class="filter-select">
                        <option value="">Loại món</option>
                        <option value="vietnamese">Món Việt</option>
                        <option value="international">Món Quốc tế</option>
                        <option value="dessert">Tráng miệng</option>
                        <option value="drinks">Đồ uống</option>
                    </select>
                    <select class="filter-select">
                        <option value="">Khu vực</option>
                        <option value="hanoi">Hà Nội</option>
                        <option value="hcm">TP. Hồ Chí Minh</option>
                        <option value="danang">Đà Nẵng</option>
                    </select>
                </div>
                <button class="search-btn">Tìm kiếm</button>
            </div>
        </div>

        <!-- Nutrition Section -->
        <section class="nutrition-section">
            <div class="nutrition-header">
                <h2>Thực đơn & Dinh dưỡng</h2>
                <div class="tab-navigation">
                    <button class="tab-btn active" data-tab="calories">
                        <i class="fas fa-fire"></i>
                        Calories
                    </button>
                    <button class="tab-btn" data-tab="ingredients">
                        <i class="fas fa-list"></i>
                        Nguyên liệu
                    </button>
                </div>
            </div>

            <!-- Calories Tab -->
            <div class="tab-content active" id="calories-tab">
                <div class="search-form">
                    <div class="form-group">
                        <label for="food-name">Tên món ăn</label>
                        <input type="text" id="food-name" placeholder="Nhập tên món ăn...">
                    </div>
                    <button class="btn-primary" id="search-calories">Tìm kiếm</button>
                </div>

                <div class="nutrition-table-container">
                    <table class="nutrition-table">
                        <thead>
                            <tr>
                                <th>Tên món</th>
                                <th>Khẩu phần</th>
                                <th>Calories</th>
                                <th>Chất béo</th>
                                <th>Chất béo bão hòa</th>
                                <th>Cholesterol</th>
                                <th>Natri</th>
                                <th>Carbohydrates</th>
                                <th>Chất xơ</th>
                                <th>Đường</th>
                                <th>Protein</th>
                            </tr>
                        </thead>
                        <tbody id="calories-results">
                            <!-- Results will be populated here -->
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Ingredients Tab -->
            <div class="tab-content" id="ingredients-tab">
                <div class="search-form">
                    <div class="form-group">
                        <label for="recipe-name">Tên món ăn</label>
                        <input type="text" id="recipe-name" placeholder="Nhập tên món ăn...">
                    </div>
                    <div class="form-group">
                        <label for="servings">Số người ăn</label>
                        <input type="number" id="servings" min="1" value="1">
                    </div>
                    <button class="btn-primary" id="search-ingredients">Tìm kiếm</button>
                </div>

                <div class="ingredients-container">
                    <div class="ingredients-list" id="ingredients-results">
                        <!-- Results will be populated here -->
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
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

    <script src="<%= request.getContextPath() %>/js/nutrition.js"></script>
</body>
</html>