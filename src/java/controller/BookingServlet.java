package controller;

import DAO.ReservationDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import model.Reservation;
import model.TimeSlot;
import service.ReservationService;

@WebServlet(name = "BookingServlet", urlPatterns = {"/book"})

public class BookingServlet extends HttpServlet {

    private ReservationService reservationService;

    @Override
    public void init() throws ServletException {
        reservationService = new ReservationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));

        // Fetch available time slots from the service
        List<TimeSlot> availableSlots = reservationService.getAvailableTimeSlots(restaurantId);

        // Pass the available time slots to the JSP
        request.setAttribute("availableSlots", availableSlots);
        RequestDispatcher dispatcher = request.getRequestDispatcher("bookReservation.jsp");
        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
            String reservationTimeStr = request.getParameter("reservationTime");

            if (reservationTimeStr == null || reservationTimeStr.trim().isEmpty()) {
                response.sendRedirect("error.jsp");
                return;
            }

            Timestamp timestamp = Timestamp.valueOf(reservationTimeStr);
            Date reservationTime = new Date(timestamp.getTime());

            Reservation reservation = new Reservation();
            reservation.setCustomerId(customerId);
            reservation.setRestaurantId(restaurantId);
            reservation.setReservationTime(reservationTime);
            reservation.setHasOrder(false);

            boolean success = reservationService.addReservation(reservation);

            if (success) {
                response.sendRedirect("view/reservationConfirmation.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
