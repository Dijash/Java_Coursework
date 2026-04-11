package DAO;

import model.Booking;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDashboardDAO {

    public int getActiveBookingsCount(int customerId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM booking WHERE customer_id = ? AND booking_status = 'On Track'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, customerId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    // 2. Get Completed Trips Count
    public int getCompletedTripsCount(int customerId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM booking WHERE customer_id = ? AND booking_status = 'Completed'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, customerId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    public double getTotalSpent(int customerId) {
        double total = 0;

        String sql = "SELECT SUM(total_price) as total FROM booking WHERE customer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, customerId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                total = rs.getDouble("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // 4. Get Recent Bookings for Table
    public List<Booking> getRecentBookings(int customerId) {
        List<Booking> bookings = new ArrayList<>();
        // Fetching vehicle details alongside booking data
        String sql = "SELECT b.booking_id, v.vehicle_brand, v.vehicle_type, v.vehicle_numberPlate, " +
                "b.booking_startDate, b.booking_endDate, b.total_price, b.booking_status " +
                "FROM booking b " +
                "JOIN vehicle v ON b.vehicle_id = v.vehicle_id " +
                "WHERE b.customer_id = ? " +
                "ORDER BY b.booking_id DESC LIMIT 5";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, customerId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                String vehicleDetails = rs.getString("vehicle_brand") + " " + rs.getString("vehicle_type");

                bookings.add(new Booking(
                        rs.getInt("booking_id"),
                        null, // Customer name not needed for their own dashboard
                        vehicleDetails,
                        rs.getString("booking_status"),
                        rs.getDate("booking_startDate"),
                        rs.getDate("booking_endDate"),
                        rs.getString("total_price"),
                        rs.getString("vehicle_numberPlate")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return bookings;
    }
    public List<Booking> getAllUserBookings(int customerId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.booking_id, v.vehicle_brand, v.vehicle_type, v.vehicle_numberPlate, " +
                "b.booking_startDate, b.booking_endDate, b.total_price, b.booking_status " +
                "FROM booking b " +
                "JOIN vehicle v ON b.vehicle_id = v.vehicle_id " +
                "WHERE b.customer_id = ? " +
                "ORDER BY b.booking_startDate DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, customerId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                String vehicleDetails = rs.getString("vehicle_brand") + " " + rs.getString("vehicle_type");

                bookings.add(new Booking(
                        rs.getInt("booking_id"),
                        null,
                        vehicleDetails,
                        rs.getString("booking_status"),
                        rs.getDate("booking_startDate"),
                        rs.getDate("booking_endDate"),
                        rs.getString("total_price"),
                        rs.getString("vehicle_numberPlate")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return bookings;
    }
}