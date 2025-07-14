<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Restaurants</title>
    </head>
    <body>
        <h1>Available Restaurants</h1>

        <!-- Test links to book reservations -->
        <div>
            <h3>La Maison 1888</h3>
            <a href="book?restaurantId=1">Book Reservation</a>
        </div>

        <div>
            <h3>Madam Lan</h3>
            <a href="book?restaurantId=2">Book Reservation</a>
        </div>

        <div>
            <h3>The Rachel</h3>
            <a href="book?restaurantId=3">Book Reservation</a>
        </div>

        <div>
            <h3>Bếp 7</h3>
            <a href="book?restaurantId=4">Book Reservation</a>
        </div>
    </body>
</html>