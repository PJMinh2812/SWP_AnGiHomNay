package service;

import DAO.ReservationDAO;
import model.Reservation;
import model.TimeSlot;
import java.util.List;

public class ReservationService {
    
    private ReservationDAO reservationDAO;

    public ReservationService() {
        reservationDAO = new ReservationDAO(); // Dependency Injection can be used here as well
    }

    // Method to add a reservation
    public boolean addReservation(Reservation reservation) {
        return reservationDAO.addReservation(reservation);
    }

    // Method to retrieve available time slots for a restaurant
    public List<TimeSlot> getAvailableTimeSlots(int restaurantId) {
        return reservationDAO.getAvailableTimeSlots(restaurantId);
    }

    // Add food items to a reservation
    public boolean addFoodOrder(int reservationId, String[] foodIds, String[] quantities) {
        return reservationDAO.addFoodOrder(reservationId, foodIds, quantities);
    }

    // Update reservation with order status
    public boolean updateOrderStatus(int reservationId, boolean hasOrder) {
        return reservationDAO.updateOrderStatus(reservationId, hasOrder);
    }

    // Additional business methods for other reservation-related actions can go here
    
}
