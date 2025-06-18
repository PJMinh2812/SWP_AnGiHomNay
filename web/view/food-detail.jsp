<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${food.name} - AnGiHomNay</title>
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/main.css">
        <link rel="stylesheet" href="<%= request.getContextPath()%>/css/header.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                --accent-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                --warm-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
                --glass-bg: rgba(255, 255, 255, 0.1);
                --glass-border: rgba(255, 255, 255, 0.2);
                --shadow-soft: 0 8px 32px rgba(0, 0, 0, 0.1);
                --shadow-strong: 0 20px 60px rgba(0, 0, 0, 0.15);
                --border-radius: 20px;
                --transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: var(--primary-gradient);
                min-height: 100vh;
                overflow-x: hidden;
            }

            .food-detail-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 2rem;
                position: relative;
            }

            /* Floating Background Elements */
            .bg-decoration {
                position: fixed;
                pointer-events: none;
                z-index: -1;
            }

            .bg-circle-1 {
                width: 300px;
                height: 300px;
                background: var(--secondary-gradient);
                border-radius: 50%;
                top: -150px;
                right: -150px;
                opacity: 0.3;
                animation: float 6s ease-in-out infinite;
            }

            .bg-circle-2 {
                width: 200px;
                height: 200px;
                background: var(--accent-gradient);
                border-radius: 50%;
                bottom: -100px;
                left: -100px;
                opacity: 0.2;
                animation: float 8s ease-in-out infinite reverse;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px) rotate(0deg);
                }
                50% {
                    transform: translateY(-20px) rotate(180deg);
                }
            }

            /* Hero Section */
            .food-hero {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 3rem;
                margin-bottom: 3rem;
                background: var(--glass-bg);
                backdrop-filter: blur(20px);
                border: 1px solid var(--glass-border);
                border-radius: var(--border-radius);
                padding: 3rem;
                box-shadow: var(--shadow-strong);
                position: relative;
                overflow: hidden;
            }

            .food-hero::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 4px;
                background: var(--warm-gradient);
            }

            .food-image-section {
                position: relative;
            }

            .food-image {
                width: 100%;
                height: 400px;
                border-radius: var(--border-radius);
                object-fit: cover;
                box-shadow: var(--shadow-soft);
                transition: var(--transition);
            }

            .food-image:hover {
                transform: scale(1.05);
                box-shadow: var(--shadow-strong);
            }

            .image-overlay {
                position: absolute;
                top: 1rem;
                right: 1rem;
                display: flex;
                gap: 0.5rem;
            }

            .action-btn {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                border: none;
                background: var(--glass-bg);
                backdrop-filter: blur(10px);
                color: white;
                font-size: 1.2rem;
                cursor: pointer;
                transition: var(--transition);
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .action-btn:hover {
                background: var(--secondary-gradient);
                transform: scale(1.1);
            }

            .food-info-section {
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .food-title {
                font-family: 'Playfair Display', serif;
                font-size: 3rem;
                font-weight: 700;
                color: white;
                margin-bottom: 1rem;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            }

            .food-description {
                font-size: 1.2rem;
                color: rgba(255, 255, 255, 0.9);
                line-height: 1.6;
                margin-bottom: 2rem;
            }

            .nutrition-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 1rem;
                margin-bottom: 2rem;
            }

            .nutrition-card {
                background: var(--glass-bg);
                backdrop-filter: blur(10px);
                border: 1px solid var(--glass-border);
                border-radius: 15px;
                padding: 1.5rem;
                text-align: center;
                transition: var(--transition);
            }

            .nutrition-card:hover {
                transform: translateY(-5px);
                background: rgba(255, 255, 255, 0.2);
            }

            .nutrition-icon {
                font-size: 2rem;
                margin-bottom: 0.5rem;
                background: var(--warm-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .nutrition-value {
                font-size: 1.5rem;
                font-weight: 600;
                color: white;
                margin-bottom: 0.25rem;
            }

            .nutrition-label {
                font-size: 0.9rem;
                color: rgba(255, 255, 255, 0.7);
            }

            /* Content Sections */
            .content-section {
                background: var(--glass-bg);
                backdrop-filter: blur(20px);
                border: 1px solid var(--glass-border);
                border-radius: var(--border-radius);
                padding: 2.5rem;
                margin-bottom: 2rem;
                box-shadow: var(--shadow-soft);
                transition: var(--transition);
            }

            .content-section:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-strong);
            }

            .section-title {
                font-family: 'Playfair Display', serif;
                font-size: 2rem;
                font-weight: 600;
                color: white;
                margin-bottom: 1.5rem;
                position: relative;
                padding-left: 2rem;
            }

            .section-title::before {
                content: '';
                position: absolute;
                left: 0;
                top: 50%;
                transform: translateY(-50%);
                width: 4px;
                height: 30px;
                background: var(--warm-gradient);
                border-radius: 2px;
            }

            /* Ingredients Section */
            .ingredients-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1rem;
            }

            .ingredient-item {
                background: rgba(255, 255, 255, 0.05);
                border-radius: 12px;
                padding: 1rem;
                display: flex;
                align-items: center;
                gap: 1rem;
                transition: var(--transition);
            }

            .ingredient-item:hover {
                background: rgba(255, 255, 255, 0.1);
                transform: translateX(10px);
            }

            .ingredient-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: var(--accent-gradient);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.2rem;
            }

            .ingredient-details {
                flex: 1;
            }

            .ingredient-name {
                font-weight: 600;
                color: white;
                margin-bottom: 0.25rem;
            }

            .ingredient-quantity {
                color: rgba(255, 255, 255, 0.7);
                font-size: 0.9rem;
            }

            /* Instructions Section */
            .instructions-list {
                list-style: none;
                counter-reset: step-counter;
            }

            .instruction-item {
                counter-increment: step-counter;
                background: rgba(255, 255, 255, 0.05);
                border-radius: 15px;
                padding: 1.5rem;
                margin-bottom: 1rem;
                position: relative;
                transition: var(--transition);
            }

            .instruction-item:hover {
                background: rgba(255, 255, 255, 0.1);
                transform: translateX(10px);
            }

            .instruction-item::before {
                content: counter(step-counter);
                position: absolute;
                left: -20px;
                top: 50%;
                transform: translateY(-50%);
                width: 40px;
                height: 40px;
                background: var(--secondary-gradient);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
                font-size: 1.1rem;
            }

            .instruction-title {
                font-weight: 600;
                color: white;
                margin-bottom: 0.5rem;
                margin-left: 2rem;
            }

            .instruction-description {
                color: rgba(255, 255, 255, 0.8);
                line-height: 1.6;
                margin-left: 2rem;
            }

            /* Reviews Section */
            .reviews-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
            }

            .rating-summary {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .rating-score {
                font-size: 3rem;
                font-weight: 700;
                color: white;
            }

            .stars {
                display: flex;
                gap: 0.25rem;
            }

            .star {
                font-size: 1.5rem;
                color: #ffd700;
            }

            .review-form {
                background: rgba(255, 255, 255, 0.05);
                border-radius: 15px;
                padding: 2rem;
                margin-bottom: 2rem;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                color: white;
                font-weight: 500;
                margin-bottom: 0.5rem;
                display: block;
            }

            .form-input {
                width: 100%;
                padding: 1rem;
                border: 1px solid var(--glass-border);
                border-radius: 12px;
                background: var(--glass-bg);
                backdrop-filter: blur(10px);
                color: white;
                font-size: 1rem;
                transition: var(--transition);
            }

            .form-input:focus {
                outline: none;
                border-color: rgba(255, 255, 255, 0.5);
                background: rgba(255, 255, 255, 0.1);
            }

            .form-input::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }

            .rating-input {
                display: flex;
                gap: 0.5rem;
                flex-direction: row-reverse;
                justify-content: flex-end;
            }

            .rating-input input {
                display: none;
            }

            .rating-input label {
                font-size: 2rem;
                color: rgba(255, 255, 255, 0.3);
                cursor: pointer;
                transition: var(--transition);
            }

            .rating-input input:checked ~ label,
            .rating-input label:hover,
            .rating-input label:hover ~ label {
                color: #ffd700;
            }

            .submit-btn {
                background: var(--warm-gradient);
                color: white;
                border: none;
                padding: 1rem 2rem;
                border-radius: 12px;
                font-weight: 600;
                cursor: pointer;
                transition: var(--transition);
                font-size: 1rem;
            }

            .submit-btn:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-soft);
            }

            .review-item {
                background: rgba(255, 255, 255, 0.05);
                border-radius: 15px;
                padding: 1.5rem;
                margin-bottom: 1rem;
            }

            .review-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }

            .reviewer-name {
                font-weight: 600;
                color: white;
            }

            .review-date {
                color: rgba(255, 255, 255, 0.6);
                font-size: 0.9rem;
            }

            .review-comment {
                color: rgba(255, 255, 255, 0.8);
                line-height: 1.6;
            }

            /* Responsive Design */
            @media (max-width: 1024px) {
                .food-hero {
                    grid-template-columns: 1fr;
                    gap: 2rem;
                }

                .nutrition-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }

            @media (max-width: 768px) {
                .food-detail-container {
                    padding: 1rem;
                }

                .food-hero {
                    padding: 2rem;
                }

                .food-title {
                    font-size: 2rem;
                }

                .nutrition-grid {
                    grid-template-columns: 1fr;
                }

                .ingredients-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <!-- header -->
        <jsp:include page="common/header.jsp"></jsp:include>
            <!-- Background Decorations -->
            <div class="bg-decoration bg-circle-1"></div>
            <div class="bg-decoration bg-circle-2"></div>

            <div class="food-detail-container">
                <!-- Hero Section -->
                <section class="food-hero">
                    <div class="food-image-section">
                        <img src="${food.image}" alt="${food.name}" class="food-image" 
                         onerror="this.src='<%= request.getContextPath()%>/img/default-food.jpg'">
                    <div class="image-overlay">
                        <button class="action-btn" title="Thêm vào yêu thích">
                            <i class="fas fa-heart"></i>
                        </button>
                        <button class="action-btn" title="Chia sẻ">
                            <i class="fas fa-share-alt"></i>
                        </button>
                    </div>
                </div>

                <div class="food-info-section">
                    <h1 class="food-title">${food.name}</h1>
                    <p class="food-description">
                        <%= request.getAttribute("food") != null
                                ? ((Map<String, Object>) request.getAttribute("food")).get("description")
                                : "Món ăn ngon tuyệt vời"%>
                    </p>

                    <div class="nutrition-grid">
                        <div class="nutrition-card">
                            <div class="nutrition-icon">
                                <i class="fas fa-fire"></i>
                            </div>
                            <div class="nutrition-value">${food.calories}</div>
                            <div class="nutrition-label">Calories</div>
                        </div>
                        <div class="nutrition-card">
                            <div class="nutrition-icon">
                                <i class="fas fa-dumbbell"></i>
                            </div>
                            <div class="nutrition-value">${food.protein}g</div>
                            <div class="nutrition-label">Protein</div>
                        </div>
                        <div class="nutrition-card">
                            <div class="nutrition-icon">
                                <i class="fas fa-bread-slice"></i>
                            </div>
                            <div class="nutrition-value">${food.carbs}g</div>
                            <div class="nutrition-label">Carbs</div>
                        </div>
                        <div class="nutrition-card">
                            <div class="nutrition-icon">
                                <i class="fas fa-tint"></i>
                            </div>
                            <div class="nutrition-value">${food.fat}g</div>
                            <div class="nutrition-label">Fat</div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Ingredients Section -->
            <section class="content-section">
                <h2 class="section-title">
                    <i class="fas fa-list-ul"></i> Nguyên Liệu
                </h2>
                <div class="ingredients-grid">
                    <c:forEach var="ingredient" items="${food.ingredients}">
                        <div class="ingredient-item">
                            <div class="ingredient-icon">
                                <i class="fas fa-leaf"></i>
                            </div>
                            <div class="ingredient-details">
                                <div class="ingredient-name">${ingredient.name}</div>
                                <div class="ingredient-quantity">${ingredient.quantity}${ingredient.unit}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>

            <!-- Instructions Section -->
            <section class="content-section">
                <h2 class="section-title">
                    <i class="fas fa-utensils"></i> Hướng Dẫn Nấu
                </h2>
                <ol class="instructions-list">
                    <c:forEach var="instruction" items="${food.instructions}">
                        <li class="instruction-item">
                            <div class="instruction-title">${instruction.title}</div>
                            <div class="instruction-description">${instruction.description}</div>
                        </li>
                    </c:forEach>
                </ol>
            </section>

            <!-- Reviews Section -->
            <section class="content-section">
                <div class="reviews-header">
                    <h2 class="section-title">
                        <i class="fas fa-star"></i> Đánh Giá (${reviews.size()} bình luận)
                    </h2>
                    <div class="rating-summary">
                        <div class="rating-score">${avgRating}</div>
                        <div class="stars">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="fas fa-star star ${i <= avgRating ? 'active' : ''}"></i>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Add Review Form -->
                <form action="<%= request.getContextPath()%>/food-detail" method="post" class="review-form">
                    <input type="hidden" name="foodID" value="${food.foodID}">
                    <div class="form-group">
                        <label class="form-label">Đánh giá của bạn:</label>
                        <div class="rating-input">
                            <input type="radio" name="rating" value="5" id="star5">
                            <label for="star5"><i class="fas fa-star"></i></label>
                            <input type="radio" name="rating" value="4" id="star4">
                            <label for="star4"><i class="fas fa-star"></i></label>
                            <input type="radio" name="rating" value="3" id="star3">
                            <label for="star3"><i class="fas fa-star"></i></label>
                            <input type="radio" name="rating" value="2" id="star2">
                            <label for="star2"><i class="fas fa-star"></i></label>
                            <input type="radio" name="rating" value="1" id="star1">
                            <label for="star1"><i class="fas fa-star"></i></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Nhận xét:</label>
                        <textarea name="comment" class="form-input" rows="4" 
                                  placeholder="Chia sẻ trải nghiệm của bạn về món ăn này..." required></textarea>
                    </div>
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-paper-plane"></i> Gửi Đánh Giá
                    </button>
                </form>

                <!-- Reviews List -->
                <div class="reviews-list">
                    <c:forEach var="review" items="${reviews}">
                        <div class="review-item">
                            <div class="review-header">
                                <div>
                                    <div class="reviewer-name">${review.name}</div>
                                    <div class="stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star star ${i <= review.rating ? 'active' : ''}"></i>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="review-date">${review.date}</div>
                            </div>
                            <p class="review-comment">${review.comment}</p>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </div>

        <script>
            // Add smooth scrolling and interactive effects
            document.addEventListener('DOMContentLoaded', function () {
                // Animate elements on scroll
                const observerOptions = {
                    threshold: 0.1,
                    rootMargin: '0px 0px -50px 0px'
                };

                const observer = new IntersectionObserver(function (entries) {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.style.opacity = '1';
                            entry.target.style.transform = 'translateY(0)';
                        }
                    });
                }, observerOptions);

                // Observe all content sections
                document.querySelectorAll('.content-section').forEach(section => {
                    section.style.opacity = '0';
                    section.style.transform = 'translateY(30px)';
                    section.style.transition = 'all 0.6s ease';
                    observer.observe(section);
                });

                // Add click effects to action buttons
                document.querySelectorAll('.action-btn').forEach(btn => {
                    btn.addEventListener('click', function () {
                        this.style.transform = 'scale(0.95)';
                        setTimeout(() => {
                            this.style.transform = 'scale(1.1)';
                        }, 150);
                    });
                });
            });
        </script>
    </body>
</html>