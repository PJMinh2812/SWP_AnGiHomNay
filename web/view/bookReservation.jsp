<%-- 
    Document   : bookReservation
    Created on : Jul 14, 2025, 9:49:00 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Book Reservation</title>
</head>
<body>
<form action="book" method="post">
    <input type="hidden" name="restaurantId" value="${param.restaurantId}">
    <input type="hidden" name="customerId" value="${sessionScope.userID}">

    <label for="reservationTime">Select a Time Slot:</label>
    <c:choose>
        <c:when test="${not empty availableSlots}">
            <select name="reservationTime" required>
                <c:forEach var="slot" items="${availableSlots}">
                    <option value="${slot.startTime}">${slot.startTime} - ${slot.endTime}</option>
                </c:forEach>
            </select>
        </c:when>
        <c:otherwise>
            <p>No available time slots for this restaurant.</p>
        </c:otherwise>
    </c:choose>

    <input type="submit" value="Book Reservation">
</form>
</body>
</html>