<%-- 
    Document   : random
    Created on : Jun 18, 2025, 9:59:41 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quay món ngẫu nhiên</title>
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/main.css"
            />
        <style>
            body {
                min-height: 100vh;
                background: linear-gradient(120deg, #f6d365 0%, #fda085 100%);
                /* fallback for old browsers */
                background-repeat: no-repeat;
                background-attachment: fixed;
            }
            .wheel-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-top: 3rem;
                position: relative;
            }
            .wheel-row {
                display: flex;
                align-items: center;
                gap: 2rem;
                justify-content: center;
            }
            .pointer {
                width: 0;
                height: 0;
                border-left: 28px solid transparent;
                border-right: 28px solid transparent;
                border-bottom: 48px solid #43b78d;
                border-top: none;
                position: absolute;
                bottom: -48px;
                left: 50%;
                top: auto;
                transform: translateX(-50%) scale(1.1);
                z-index: 2;
                filter: drop-shadow(0 4px 12px #43b78d88);
            }
            .spin-btn {
                margin-top: 0;
                padding: 1rem 2.5rem;
                font-size: 1.2rem;
                border-radius: 8px;
                background: #ff6b6b;
                color: #fff;
                border: none;
                cursor: pointer;
                font-weight: bold;
                transition: background 0.2s;
                box-shadow: 0 4px 24px #ff6b6b33, 0 2px 8px #fff8;
                letter-spacing: 1px;
            }
            .spin-btn:active {
                background: #e55a5a;
            }
            .canvas-wrapper {
                position: relative;
                background: #fff;
                border-radius: 50%;
                box-shadow: 0 8px 40px 0 #ffb38555, 0 2px 12px #fff8;
                padding: 18px;
                margin-bottom: 1.5rem;
            }
            .wheel-glow {
                box-shadow: 0 0 40px 10px #ffe66d, 0 0 0 10px #fff inset;
                transition: box-shadow 0.3s;
            }
            .wheel-shake {
                animation: shake 0.5s;
            }
            @keyframes shake {
                0% {
                    transform: translateX(0);
                }
                20% {
                    transform: translateX(-10px);
                }
                40% {
                    transform: translateX(10px);
                }
                60% {
                    transform: translateX(-6px);
                }
                80% {
                    transform: translateX(6px);
                }
                100% {
                    transform: translateX(0);
                }
            }
            #resultPopup > div {
                background: linear-gradient(120deg, #f6d365 0%, #fda085 100%);
                color: #222;
                border: 2px solid #fff6;
                box-shadow: 0 8px 40px 0 #ffb38555, 0 2px 12px #fff8;
            }
            #resultPopup h2 {
                color: #ff6b6b;
                font-weight: 800;
                letter-spacing: 1px;
            }
            #resultPopup .spin-btn {
                box-shadow: 0 2px 12px #fff8;
            }
        </style>
    </head>
    <body>
        <main class="container fade-in">
            <div class="wheel-container">
                <div class="wheel-row">
                    <div class="canvas-wrapper" style="position: relative">
                        <canvas id="wheel" width="350" height="350"></canvas>
                        <div class="pointer"></div>
                    </div>
                    <button class="spin-btn" id="spinBtn">Quay</button>
                </div>
            </div>
            <!-- Popup kết quả -->
            <div
                id="resultPopup"
                style="
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(0, 0, 0, 0.45);
                z-index: 100;
                align-items: center;
                justify-content: center;
                "
                >
                <div
                    style="
                    background: #fff;
                    border-radius: 18px;
                    box-shadow: 0 4px 32px rgba(0, 0, 0, 0.18);
                    padding: 2.5rem 2rem;
                    min-width: 320px;
                    max-width: 90vw;
                    text-align: center;
                    position: relative;
                    "
                    >
                    <div
                        id="confettiBox"
                        style="
                        position: absolute;
                        left: 0;
                        top: 0;
                        width: 100%;
                        height: 100%;
                        pointer-events: none;
                        "
                        ></div>
                    <img
                        id="resultImg"
                        src=""
                        alt="Món ăn"
                        style="
                        width: 120px;
                        height: 120px;
                        object-fit: cover;
                        border-radius: 16px;
                        box-shadow: 0 2px 12px #eee;
                        margin-bottom: 1rem;
                        "
                        />
                    <h2 id="resultName" style="margin-bottom: 0.5rem"></h2>
                    <div
                        id="resultMsg"
                        style="font-size: 1.1rem; color: #555; margin-bottom: 1.2rem"
                        >
                        Hôm nay thử món này nhé!
                    </div>
                    <div style="display: flex; gap: 1rem; justify-content: center">
                        <a
                            id="viewDetailBtn"
                            class="spin-btn"
                            style="background: #4ecdc4; color: #fff; text-decoration: none"
                            >Xem chi tiết</a
                        >
                        <button
                            id="closePopupBtn"
                            class="spin-btn"
                            style="background: #eee; color: #333"
                            >
                            Quay lại
                        </button>
                    </div>
                </div>
            </div>
        </main>
        <script>
        const contextPath = "${pageContext.request.contextPath}";
        // Danh sách món ăn (foodID, tên, màu, ảnh)
        const foods = [
            {
                id: 1,
                name: "Phở Bò",
                color: "#FF6B6B",
                img: "${pageContext.request.contextPath}/img/foods/pho-bo.jpg",
            },
            {
                id: 2,
                name: "Bánh mì thịt",
                color: "#FFD166",
                img: "${pageContext.request.contextPath}/img/foods/banh-mi.jpg",
            },
            {
                id: 3,
                name: "Bún chả Hà Nội",
                color: "#4ECDC4",
                img: "${pageContext.request.contextPath}/img/foods/bun-cha.jpg",
            },
            {
                id: 4,
                name: "Cơm tấm sườn bì",
                color: "#6A4C93",
                img: "${pageContext.request.contextPath}/img/foods/com-tam.jpg",
            },
            {
                id: 5,
                name: "Trà sữa trân châu",
                color: "#F67280",
                img: "${pageContext.request.contextPath}/img/foods/tra-sua.jpg",
            },
            {
                id: 6,
                name: "Bánh tráng trộn",
                color: "#355C7D",
                img: "${pageContext.request.contextPath}/img/foods/banh-trang-tron.jpg",
            },
            {
                id: 7,
                name: "Matcha đá xay",
                color: "#43B78D",
                img: "${pageContext.request.contextPath}/img/foods/matcha.jpg",
            },
        ];
        const wheel = document.getElementById("wheel");
        const ctx = wheel.getContext("2d");
        const spinBtn = document.getElementById("spinBtn");
        const num = foods.length;
        const arc = (2 * Math.PI) / num;
        let currentAngle = 0;
        function drawWheel(angle = 0) {
            ctx.clearRect(0, 0, wheel.width, wheel.height);
            for (let i = 0; i < num; i++) {
                ctx.beginPath();
                ctx.moveTo(175, 175);
                ctx.arc(175, 175, 170, angle + i * arc, angle + (i + 1) * arc, false);
                ctx.closePath();
                ctx.fillStyle = foods[i].color;
                ctx.fill();
                ctx.save();
                ctx.translate(175, 175);
                ctx.rotate(angle + (i + 0.5) * arc);
                ctx.textAlign = "right";
                ctx.fillStyle = "#fff";
                ctx.font = "bold 16px Arial";
                ctx.fillText(foods[i].name, 160, 10);
                ctx.restore();
        }
        }
        drawWheel();
        // Confetti effect (simple, no lib)
        function launchConfetti(container, color) {
            for (let i = 0; i < 40; i++) {
                const conf = document.createElement("div");
                conf.style.position = "absolute";
                conf.style.width = conf.style.height =
                        Math.random() > 0.5 ? "10px" : "14px";
                conf.style.background = color;
                conf.style.opacity = 0.7 + Math.random() * 0.3;
                conf.style.borderRadius = Math.random() > 0.5 ? "50%" : "2px";
                conf.style.left = Math.random() * 90 + "%";
                conf.style.top = "-30px";
                conf.style.transform = `rotate(${Math.random() * 360}deg)`;
                conf.style.transition = `top 1.2s cubic-bezier(.4,1.4,.6,1), opacity 1.2s`;
                container.appendChild(conf);
                setTimeout(() => {
                    conf.style.top = 80 + 20 * Math.random() + "%";
                    conf.style.opacity = 0;
                }, 10);
                setTimeout(() => conf.remove(), 1400);
            }
        }
        // Xoay bánh xe
        let spinning = false;
        spinBtn.onclick = function () {
            if (spinning)
                return;
            spinning = true;
            spinBtn.disabled = true;
            spinBtn.textContent = "Đang quay...";
            wheel.classList.remove("wheel-glow", "wheel-shake");
            const randomIndex = Math.floor(Math.random() * num);
            const pointerAngle = Math.PI / 2;
            const targetAngle =
                    3 * 2 * Math.PI + pointerAngle - (randomIndex + 0.5) * arc;
            let start = null;
            let duration = 4000;
            let from = currentAngle;
            let to = targetAngle;
            function animateWheel(ts) {
                if (!start)
                    start = ts;
                let progress = (ts - start) / duration;
                if (progress > 1)
                    progress = 1;
                let ease = 1 - Math.pow(1 - progress, 3);
                let angle = from + (to - from) * ease;
                drawWheel(angle);
                if (progress < 1) {
                    requestAnimationFrame(animateWheel);
                } else {
                    currentAngle = to % (2 * Math.PI);
                    wheel.classList.add("wheel-glow");
                    setTimeout(() => {
                        wheel.classList.remove("wheel-glow");
                        wheel.classList.add("wheel-shake");
                        setTimeout(() => {
                            wheel.classList.remove("wheel-shake");
                            // Hiệu ứng confetti và popup kết quả
                            showResult(randomIndex);
                            spinning = false;
                            spinBtn.disabled = false;
                            spinBtn.textContent = "Quay";
                        }, 500);
                    }, 700);
                }
            }
            requestAnimationFrame(animateWheel);
        };
        // Popup kết quả
        const resultPopup = document.getElementById("resultPopup");
        const resultImg = document.getElementById("resultImg");
        const resultName = document.getElementById("resultName");
        const resultMsg = document.getElementById("resultMsg");
        const viewDetailBtn = document.getElementById("viewDetailBtn");
        const closePopupBtn = document.getElementById("closePopupBtn");
        const confettiBox = document.getElementById("confettiBox");
        function showResult(idx) {
            resultImg.src = foods[idx].img;
            resultName.textContent = foods[idx].name;
            resultMsg.textContent = "Hôm nay thử món này nhé! Chúc bạn ngon miệng!";
            viewDetailBtn.href =
                    contextPath + "/food-detail?foodID=" + foods[idx].id;
            resultPopup.style.display = "flex";
            launchConfetti(confettiBox, foods[idx].color);
        }
        closePopupBtn.onclick = function () {
            resultPopup.style.display = "none";
            confettiBox.innerHTML = "";
        };
        // Đóng popup khi click ra ngoài
        resultPopup.addEventListener("click", function (e) {
            if (e.target === resultPopup) {
                resultPopup.style.display = "none";
                confettiBox.innerHTML = "";
            }
        });
        </script>
    </body>
</html>
