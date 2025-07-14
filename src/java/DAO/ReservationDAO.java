
package DAO;

import model.Reservation;
import model.ReservationFood;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.TimeSlot;

public class ReservationDAO {

    // Add a new reservation
    public boolean addReservation(Reservation reservation) {
        String query = "INSERT INTO Reservation (CustomerID, RestaurantID, ReservationTime, HasOrder) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBconnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, reservation.getCustomerId());
            stmt.setInt(2, reservation.getRestaurantId());
            stmt.setTimestamp(3, new Timestamp(reservation.getReservationTime().getTime()));
            stmt.setBoolean(4, reservation.isHasOrder());
            int rowsAffected = stmt.executeUpdate();
            
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve available time slots for a restaurant
    public List<TimeSlot> getAvailableTimeSlots(int restaurantId) {
        List<TimeSlot> slots = new ArrayList<>();
        String query = "SELECT * FROM TimeSlot WHERE RestaurantID = ? AND Available = 1";
        
        try (Connection conn = DBconnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, restaurantId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                TimeSlot slot = new TimeSlot();
                slot.setId(rs.getInt("ID"));
                slot.setRestaurantId(rs.getInt("RestaurantID"));
                slot.setStartTime(rs.getTimestamp("StartTime"));
                slot.setEndTime(rs.getTimestamp("EndTime"));
                slot.setAvailable(rs.getBoolean("Available"));
                slots.add(slot);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return slots;
    }

    // Add food items to a reservation
    public boolean addFoodOrder(int reservationId, String[] foodIds, String[] quantities) {
        String query = "INSERT INTO ReservationFood (ReservationID, FoodID, Quantity) VALUES (?, ?, ?)";
        
        try (Connection conn = DBconnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            for (int i = 0; i < foodIds.length; i++) {
                stmt.setInt(1, reservationId);
                stmt.setInt(2, Integer.parseInt(foodIds[i]));
                stmt.setInt(3, Integer.parseInt(quantities[i]));
                stmt.addBatch();
            }
            int[] rowsAffected = stmt.executeBatch();
            return rowsAffected.length == foodIds.length;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve reservation details by ID
    public Reservation getReservationById(int reservationId) {
        Reservation reservation = null;
        String query = "SELECT * FROM Reservation WHERE ID = ?";
        
        try (Connection conn = DBconnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, reservationId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                reservation = new Reservation();
                reservation.setId(rs.getInt("ID"));
                reservation.setCustomerId(rs.getInt("CustomerID"));
                reservation.setRestaurantId(rs.getInt("RestaurantID"));
                reservation.setReservationTime(rs.getTimestamp("ReservationTime"));
                reservation.setHasOrder(rs.getBoolean("HasOrder"));
                reservation.setOrderTime(rs.getTimestamp("OrderTime"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservation;
    }

    // Update the 'HasOrder' field after order placement
    public boolean updateOrderStatus(int reservationId, boolean hasOrder) {
        String query = "UPDATE Reservation SET HasOrder = ?, OrderTime = ? WHERE ID = ?";
        try (Connection conn = DBconnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setBoolean(1, hasOrder);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));  // Set current time as OrderTime
            stmt.setInt(3, reservationId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
