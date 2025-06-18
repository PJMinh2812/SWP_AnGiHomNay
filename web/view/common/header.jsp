<%-- 
    Document   : header
    Created on : Jun 18, 2025, 9:25:06 AM
    Author     : Admin
--%>
<%@page import="model.Users"%>
<%@page import="dao.UserDAO"%>
<%
    Users user = null;
    HttpSession currentSession = request.getSession(false);

    // First check if user is already in session
    if (currentSession != null) {
        user = (Users) currentSession.getAttribute("user");
        System.out.println("User found in session: " + (user != null ? user.getEmail() : "null"));
    }

    // If no user in session, try to restore from remember me cookies
    if (user == null) {
        String userEmail = null;
        String userIdStr = null;
        boolean rememberMe = false;

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                switch (cookie.getName()) {
                    case "userEmail":
                        userEmail = cookie.getValue();
                        System.out.println("Found userEmail cookie: " + userEmail);
                        break;
                    case "userID":
                        userIdStr = cookie.getValue();
                        System.out.println("Found userID cookie: " + userIdStr);
                        break;
                    case "rememberMe":
                        rememberMe = "true".equals(cookie.getValue());
                        System.out.println("Found rememberMe cookie: " + rememberMe);
                        break;
                }
            }
        }

        // Restore session from cookies if remember me was enabled
        if (rememberMe && userEmail != null && userIdStr != null) {
            try {
                int userId = Integer.parseInt(userIdStr);
                UserDAO userDAO = new UserDAO();
                user = userDAO.getUserWithRole(userId);

                if (user != null && user.getEmail().equals(userEmail)) {
                    // Recreate session
                    HttpSession newSession = request.getSession(true);
                    newSession.setAttribute("user", user);
                    newSession.setAttribute("userID", user.getUserID());
                    newSession.setAttribute("userEmail", user.getEmail());
                    newSession.setMaxInactiveInterval(24 * 60 * 60);

                    System.out.println("Session restored from cookies for user: " + user.getEmail());
                } else {
                    System.out.println("User validation failed, clearing invalid cookies");
                    // Clear invalid cookies
                    response.addCookie(new Cookie("userEmail", "") {
                        {
                            setMaxAge(0);
                            setPath(request.getContextPath());
                        }
                    });
                    response.addCookie(new Cookie("userID", "") {
                        {
                            setMaxAge(0);
                            setPath(request.getContextPath());
                        }
                    });
                    response.addCookie(new Cookie("rememberMe", "") {
                        {
                            setMaxAge(0);
                            setPath(request.getContextPath());
                        }
                    });
                }
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("Error restoring session from cookies: " + e.getMessage());
            }
        } else {
            System.out.println("No valid remember me cookies found");
        }
    }

    // If still no user, redirect to login
    if (user == null) {
        System.out.println("No user found, should redirect to login");
    }
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
                <%
                    if (user == null) {
                %>
                <a href="<%= request.getContextPath()%>/view/authen/login.jsp" class="btn-login">Đăng nhập</a>
                <a href="<%= request.getContextPath()%>/view/authen/register.jsp" class="btn-register">Đăng ký</a>
                <%
                } else {
                %>
                <div class="user-dropdown">
                    <img src="<%= request.getContextPath()%>/img/avatar-default.png" alt="${user.fullName}" class="avatar-icon" id="avatarIcon">
                    <ul class="dropdown-menu" id="userDropdown">
                        <li><a href="<%= request.getContextPath()%>/view/user-profile.jsp">Trang cá nhân</a></li>
                        <li><a href="<%= request.getContextPath()%>/settings.jsp">Cài đặt</a></li>
                        <li><a href="<%= request.getContextPath()%>/logout">Đăng xuất</a></li>
                    </ul>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </header>
</html>
