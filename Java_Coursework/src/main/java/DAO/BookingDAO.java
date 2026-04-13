package DAO;

import model.Booking;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.booking_id, CONCAT(c.first_name, ' ', c.last_name) as customer_name, " +
                "CONCAT(v.vehicle_brand, ' ', v.vehicle_type) as vehicle_info, " +
                "v.vehicle_numberPlate, b.booking_startDate, b.booking_endDate, b.booking_status, b.total_price " +
                "FROM booking b " +
                "JOIN customer c ON b.customer_id = c.customer_id " +
                "JOIN vehicle v ON b.vehicle_id = v.vehicle_id " +
                "ORDER BY b.booking_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                bookings.add(new Booking(
                        rs.getInt("booking_id"),
                        rs.getString("customer_name"),
                        rs.getString("vehicle_info"),
                        rs.getString("booking_status"),
                        rs.getDate("booking_startDate"),
                        rs.getDate("booking_endDate"),
                        rs.getString("total_price"),
                        rs.getString("vehicle_numberPlate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public Booking getBookingById(int id) {
        String sql = "SELECT b.*, CONCAT(c.first_name, ' ', c.last_name) as customer_name, " +
                "CONCAT(v.vehicle_brand, ' ', v.vehicle_type) as vehicle_info, v.vehicle_numberPlate " +
                "FROM booking b " +
                "JOIN customer c ON b.customer_id = c.customer_id " +
                "JOIN vehicle v ON b.vehicle_id = v.vehicle_id " +
                "WHERE b.booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return new Booking(
                            rs.getInt("booking_id"),
                            rs.getString("customer_name"),
                            rs.getString("vehicle_info"),
                            rs.getString("booking_status"),
                            rs.getDate("booking_startDate"),
                            rs.getDate("booking_endDate"),
                            rs.getString("total_price"),
                            rs.getString("vehicle_numberPlate")
                    );
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateBookingStatus(int id, String status) {
        String sql = "UPDATE booking SET booking_status = ? WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, status);
            statement.setInt(2, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteBooking(int id) {
        String sql = "DELETE FROM booking WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}