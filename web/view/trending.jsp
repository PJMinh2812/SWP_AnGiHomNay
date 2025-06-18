<%-- 
    Document   : trending
    Created on : Jun 18, 2025, 10:00:43 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Món hot</title>
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/main.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/home.css"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
            />
    </head>
    <body>
        <main class="container mt-2 fade-in">
            <div class="card">
                <h2 class="text-center mb-2">Món ăn đang hot</h2>
                <div class="food-grid">
                    <%-- Danh sách món hot, có thể lấy từ backend, ở đây mock cứng --%>
                    <div class="food-card">
                        <a href="${pageContext.request.contextPath}/food-detail?foodID=5">
                            <div class="food-image">
                                <img
                                    src="${pageContext.request.contextPath}/img/foods/tra-sua.jpg"
                                    alt="Trà sữa trân châu"
                                    />
                            </div>
                        </a>
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
                        <a href="${pageContext.request.contextPath}/food-detail?foodID=6">
                            <div class="food-image">
                                <img
                                    src="${pageContext.request.contextPath}/img/foods/banh-trang-tron.jpg"
                                    alt="Bánh tráng trộn"
                                    />
                            </div>
                        </a>
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
                        <a href="${pageContext.request.contextPath}/food-detail?foodID=7">
                            <div class="food-image">
                                <img
                                    src="${pageContext.request.contextPath}/img/foods/matcha.jpg"
                                    alt="Matcha đá xay"
                                    />
                            </div>
                        </a>
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
            </div>
        </main>
    </body>
</html>
