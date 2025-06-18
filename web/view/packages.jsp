<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gói đăng ký - AnGiHomNay</title>
        <link rel="stylesheet" href="styles/main.css">
        <link rel="stylesheet" href="styles/header.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .packages-section {
                padding: 4rem 2rem;
                background-color: #f8f9fa;
            }

            .packages-container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .packages-header {
                text-align: center;
                margin-top: 3rem;
                margin-bottom: 3rem;
            }

            .packages-header h2 {
                font-size: 2.5rem;
                color: #333;
                margin-bottom: 1rem;
            }

            .packages-header p {
                font-size: 1.1rem;
                color: #666;
                max-width: 600px;
                margin: 0 auto;
            }

            .packages-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 2rem;
                margin-top: 2rem;
            }

            .package-card {
                background: white;
                border-radius: 15px;
                padding: 2rem;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .package-card:hover {
                transform: translateY(-10px);
            }

            .package-card.popular::before {
                content: "Phổ biến nhất";
                position: absolute;
                top: 20px;
                right: -35px;
                background: #ff6b6b;
                color: white;
                padding: 5px 40px;
                transform: rotate(45deg);
                font-size: 0.8rem;
            }

            .package-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .package-header h3 {
                font-size: 1.8rem;
                color: #333;
                margin-bottom: 1rem;
            }

            .package-price {
                font-size: 2.5rem;
                color: #ff7979;
                font-weight: bold;
                margin-bottom: 0.5rem;
            }

            .package-price span {
                font-size: 1rem;
                color: #666;
            }

            .package-features {
                list-style: none;
                padding: 0;
                margin: 2rem 0;
            }

            .package-features li {
                padding: 0.8rem 0;
                border-bottom: 1px solid #eee;
                color: #666;
            }

            .package-features li i {
                color: #ff7979;
                margin-right: 10px;
            }

            .package-button {
                display: block;
                width: 100%;
                padding: 1rem;
                background: #ff7979;
                color: white;
                text-align: center;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
                transition: background 0.3s ease;
            }

            .package-button:hover {
                background: #ff5f5f;
            }

            .package-card.premium {
                background: linear-gradient(135deg, #ff7979 0%, #ff5f5f 100%);
                color: white;
            }

            .package-card.premium .package-header h3,
            .package-card.premium .package-price,
            .package-card.premium .package-features li {
                color: white;
            }

            .package-card.premium .package-features li i {
                color: white;
            }

            .package-card.premium .package-button {
                background: white;
                color: #ff7979;
            }

            .package-card.premium .package-button:hover {
                background: #f8f9fa;
            }

            /* Footer Styles */
            .footer {
                background-color: var(--gray-900);
                color: var(--white);
                padding: 4rem 1rem 2rem;
                margin-top: 4rem;
            }

            .footer-content {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 3rem;
            }

            .footer-section h4 {
                color: var(--white);
                margin-bottom: 1.5rem;
            }

            .footer-section ul {
                list-style: none;
            }

            .footer-section ul li {
                margin-bottom: 0.75rem;
            }

            .footer-section a {
                color: var(--gray-400);
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .footer-section a:hover {
                color: var(--white);
            }

            .social-links {
                display: flex;
                gap: 1rem;
            }

            .social-links a {
                color: var(--white);
                font-size: 1.5rem;
            }

            .footer-bottom {
                max-width: 1200px;
                margin: 2rem auto 0;
                padding-top: 2rem;
                border-top: 1px solid var(--gray-700);
                text-align: center;
                color: var(--gray-500);
            }
        </style>
    </head>

    <body>
        <!-- Header -->
        <jsp:include page="common/header.jsp"></jsp:include>
        <!-- Packages Section -->
        <section class="packages-section">
            <div class="packages-container">
                <div class="packages-header">
                    <h2>Chọn Gói Phù Hợp Với Bạn</h2>
                    <p>Nâng cấp trải nghiệm ẩm thực của bạn với các gói đăng ký đặc quyền</p>
                </div>

                <div class="packages-grid">
                    <!-- Gói Thường -->
                    <div class="package-card">
                        <div class="package-header">
                            <h3>Gói Thường</h3>
                            <div class="package-price">0đ<span>/tháng</span></div>
                        </div>
                        <ul class="package-features">
                            <li><i class="fas fa-check"></i> Xem gợi ý món ăn cơ bản</li>
                            <li><i class="fas fa-check"></i> Đánh giá món ăn</li>
                            <li><i class="fas fa-check"></i> Xem thông tin nhà hàng</li>
                            <li><i class="fas fa-check"></i> Tìm kiếm món ăn</li>
                            <li><i class="fas fa-check"></i> Quay món ngẫu nhiên</li>
                        </ul>
                        <a href="register.html" class="package-button">Đăng ký ngay</a>
                    </div>

                    <!-- Gói Premium -->
                    <div class="package-card premium popular">
                        <div class="package-header">
                            <i class="fas fa-crown" style="color: #FFD700; font-size: 2rem; margin-bottom: 1rem;"></i>
                            <h3>Gói Premium</h3>
                            <div class="package-price">99.000đ<span>/tháng</span></div>
                        </div>
                        <ul class="package-features">
                            <li><i class="fas fa-check"></i> Tất cả tính năng của gói thường</li>
                            <li><i class="fas fa-check"></i> Gợi ý món ăn cá nhân hóa</li>
                            <li><i class="fas fa-check"></i> Ưu tiên hiển thị đánh giá</li>
                            <li><i class="fas fa-check"></i> Nhận thông báo món mới</li>
                            <li><i class="fas fa-check"></i> Không quảng cáo</li>
                            <li><i class="fas fa-check"></i> Hỗ trợ ưu tiên</li>
                            <li><i class="fas fa-check"></i> Xu hướng ẩm thực độc quyền</li>
                            <li><i class="fas fa-check"></i> Tính toán lượng calories</li>
                            <li><i class="fas fa-check"></i> Xem công thức nấu ăn chi tiết</li>
                            <li><i class="fas fa-check"></i> Đề xuất số lượng nguyên liệu theo số người</li>
                        </ul>
                        <a href="register.html" class="package-button">Nâng cấp ngay</a>
                    </div>
                </div>
            </div>
        </section>

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
