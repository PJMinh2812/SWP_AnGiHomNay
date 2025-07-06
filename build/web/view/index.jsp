<%-- 
    Document   : index
    Created on : Jun 16, 2025, 4:31:01 AM
    Author     : Admin
--%>
<%@page import="DAO.DBconnection"%>
<%@page import="DAO.UserDAO"%>
<%@page import="jakarta.servlet.http.Cookie"%>
<%@page import="jakarta.servlet.http.HttpSession"%>
<%@page import="model.User"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    

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
        <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const avatar = document.getElementById('avatarIcon');
                    const dropdown = document.getElementById('userDropdown');

                    if (avatar) {
                        avatar.addEventListener('click', function () {
                            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
                        });

                        // Ẩn dropdown khi click ngoài
                        document.addEventListener('click', function (e) {
                            if (!avatar.contains(e.target) && !dropdown.contains(e.target)) {
                                dropdown.style.display = 'none';
                            }
                        });
                    }
                });
        </script>
    </head>


    <body>
       
            <jsp:include page="common/header.jsp"></jsp:include>
        <!-- Main Content -->
        <main>
            <!-- Hero Section -->
            <section class="hero">
                <div class="hero-background">
                    <div class="hero-overlay"></div>
                    <div class="floating-food food-1">
                        <img src="<%= request.getContextPath()%>/img/hero/pho.jpg" alt="Phở">
                    </div>
                    <div class="floating-food food-2">
                        <img src="<%= request.getContextPath()%>/img/hero/banh-mi.jpg" alt="Bánh mì">
                    </div>
                    <div class="floating-food food-3">
                        <img src="<%= request.getContextPath()%>/img/hero/pizza.jpg" alt="Pizza">
                    </div>
                </div>

                <div class="hero-content">
                    <h2>Hôm nay ăn gì?</h2>
                    <p>Để AnGiHomNay gợi ý món ăn phù hợp với bạn</p>
                    <div class="hero-buttons">
                        <button class="btn-primary">Nhận gợi ý ngay</button>
                        <button class="btn-secondary">Khám phá món hot</button>
                    </div>
                </div>
            </section>

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

            <!-- Context Based Recommendations -->
            <section class="recommendations">
                <h3>Gợi ý cho bạn</h3>
                <div class="context-filters">
                    <button class="filter-btn active">Thời tiết</button>
                    <button class="filter-btn">Tâm trạng</button>
                    <button class="filter-btn">Sức khỏe</button>
                    <button class="filter-btn">Thói quen</button>
                </div>
                <div class="food-grid">
                    <!-- Food Cards -->
                    <div class="food-card">
                        <div class="food-image">
                            <img src="<%= request.getContextPath()%>/img/foods/pho-bo.jpg" alt="Phở bò">
                        </div>
                        <div class="food-info">
                            <h4>Phở bò</h4>
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span>(4.5)</span>
                            </div>
                            <p class="food-tags">
                                <span>Ấm nóng</span>
                                <span>Bổ dưỡng</span>
                            </p>
                        </div>
                    </div>

                    <div class="food-card">
                        <div class="food-image">
                            <img src="<%= request.getContextPath()%>/img/foods/banh-mi.jpg" alt="Bánh mì">
                        </div>
                        <div class="food-info">
                            <h4>Bánh mì thịt</h4>
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <span>(4.8)</span>
                            </div>
                            <p class="food-tags">
                                <span>Ăn nhanh</span>
                                <span>Đường phố</span>
                            </p>
                        </div>
                    </div>

                    <div class="food-card">
                        <div class="food-image">
                            <img src="<%= request.getContextPath()%>/img/foods/bun-cha.jpg" alt="Bún chả">
                        </div>
                        <div class="food-info">
                            <h4>Bún chả Hà Nội</h4>
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <span>(4.9)</span>
                            </div>
                            <p class="food-tags">
                                <span>Truyền thống</span>
                                <span>Đặc sản</span>
                            </p>
                        </div>
                    </div>

                    <div class="food-card">
                        <div class="food-image">
                            <img src="<%= request.getContextPath()%>/img/foods/com-tam.jpg" alt="Cơm tấm">
                        </div>
                        <div class="food-info">
                            <h4>Cơm tấm sườn bì</h4>
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="far fa-star"></i>
                                <span>(4.0)</span>
                            </div>
                            <p class="food-tags">
                                <span>Cơm trưa</span>
                                <span>Đậm đà</span>
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Trending Section -->
            <section class="trending">
                <h3>Món ăn đang hot</h3>
                <div class="trending-grid">
                    <div class="food-card">
                        <div class="food-image">
                            <img src="<%= request.getContextPath()%>/img/foods/tra-sua.jpg" alt="Trà sữa trân châu">
                        </div>
                        <div class="food-info">
                            <h4>Trà sữa trân châu</h4>
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <span>(4.7)</span>
                            </div>
                            <p class="food-tags">
                                <span>Giải khát</span>
                                <span>Hot trend</span>
                            </p>
                        </div>
                    </div>

                    <div class="food-card">
                        <div class="food-image">
                            <img src="<%= request.getContextPath()%>/img/foods/banh-trang-tron.jpg" alt="Bánh tráng trộn">
                        </div>
                        <div class="food-info">
                            <h4>Bánh tráng trộn</h4>
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span>(4.6)</span>
                            </div>
                            <p class="food-tags">
                                <span>Ăn vặt</span>
                                <span>Cay cay</span>
                            </p>
                        </div>
                    </div>

                    <div class="food-card">
                        <div class="food-image">
                            <img src="<%= request.getContextPath()%>/img/foods/matcha.jpg" alt="Matcha đá xay">
                        </div>
                        <div class="food-info">
                            <h4>Matcha đá xay</h4>
                            <div class="rating">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="far fa-star"></i>
                                <span>(4.2)</span>
                            </div>
                            <p class="food-tags">
                                <span>Healthy</span>
                                <span>Refreshing</span>
                            </p>
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
    </body>
</html> 