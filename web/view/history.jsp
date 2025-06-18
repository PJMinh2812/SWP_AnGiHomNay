<%-- 
    Document   : history
    Created on : Jun 18, 2025, 11:12:56 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử nấu ăn - AnGiHomNay</title>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/main.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/header.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/home.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/search.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/history.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="common/header.jsp"></jsp:include>

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

        <!-- History Section -->
        <section class="history-section">
            <div class="history-header">
                <h2>Lịch sử nấu ăn của bạn</h2>
                <div class="history-filters">
                    <button class="filter-btn active">Tất cả</button>
                    <button class="filter-btn">Tuần này</button>
                    <button class="filter-btn">Tháng này</button>
                    <button class="filter-btn">Năm nay</button>
                </div>
            </div>

            <div class="history-timeline">
                <!-- History Item -->
                <div class="history-item">
                    <div class="history-date">
                        <span class="day">15</span>
                        <span class="month">Th3</span>
                    </div>
                    <div class="history-content">
                        <div class="history-food">
                            <img src="<%= request.getContextPath()%>/img/foods/pho-bo.jpg" alt="Phở bò">
                            <div class="history-info">
                                <h4>Phở bò</h4>
                                <p class="history-meta">
                                    <span><i class="fas fa-clock"></i> 30 phút</span>
                                    <span><i class="fas fa-fire"></i> 450 calo</span>
                                </p>
                                <div class="history-tags">
                                    <span>Món Việt</span>
                                    <span>Bữa sáng</span>
                                </div>
                            </div>
                        </div>
                        <div class="history-actions">
                            <button class="btn-action"><i class="fas fa-redo"></i> Nấu lại</button>
                            <button class="btn-action"><i class="fas fa-share"></i> Chia sẻ</button>
                        </div>
                    </div>
                </div>

                <!-- History Item -->
                <div class="history-item">
                    <div class="history-date">
                        <span class="day">14</span>
                        <span class="month">Th3</span>
                    </div>
                    <div class="history-content">
                        <div class="history-food">
                            <img src="<%= request.getContextPath()%>/img/foods/banh-mi.jpg" alt="Bánh mì">
                            <div class="history-info">
                                <h4>Bánh mì thịt</h4>
                                <p class="history-meta">
                                    <span><i class="fas fa-clock"></i> 15 phút</span>
                                    <span><i class="fas fa-fire"></i> 350 calo</span>
                                </p>
                                <div class="history-tags">
                                    <span>Món Việt</span>
                                    <span>Ăn nhanh</span>
                                </div>
                            </div>
                        </div>
                        <div class="history-actions">
                            <button class="btn-action"><i class="fas fa-redo"></i> Nấu lại</button>
                            <button class="btn-action"><i class="fas fa-share"></i> Chia sẻ</button>
                        </div>
                    </div>
                </div>

                <!-- History Item -->
                <div class="history-item">
                    <div class="history-date">
                        <span class="day">13</span>
                        <span class="month">Th3</span>
                    </div>
                    <div class="history-content">
                        <div class="history-food">
                            <img src="<%= request.getContextPath()%>/img/foods/bun-cha.jpg" alt="Bún chả">
                            <div class="history-info">
                                <h4>Bún chả Hà Nội</h4>
                                <p class="history-meta">
                                    <span><i class="fas fa-clock"></i> 45 phút</span>
                                    <span><i class="fas fa-fire"></i> 550 calo</span>
                                </p>
                                <div class="history-tags">
                                    <span>Món Việt</span>
                                    <span>Bữa trưa</span>
                                </div>
                            </div>
                        </div>
                        <div class="history-actions">
                            <button class="btn-action"><i class="fas fa-redo"></i> Nấu lại</button>
                            <button class="btn-action"><i class="fas fa-share"></i> Chia sẻ</button>
                        </div>
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