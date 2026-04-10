package DAO;

import model.Booking;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    public List<Booking> getUpcomingReturns() {
        List<Booking> returns = new ArrayList<>();

        // Using JOINs to get the actual names instead of just the ID numbers
        String sql = "SELECT c.first_name, c.last_name, v.vehicle_brand, v.vehicle_type, b.booking_endDate, b.booking_status " +
                "FROM booking b " +
                "JOIN customer c ON b.customer_id = c.customer_id " +
                "JOIN vehicle v ON b.vehicle_id = v.vehicle_id " +
                "WHERE b.booking_status IN ('On Track', 'Extended') " +
                "LIMIT 5";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                // Combine the names into single strings for easy display in your JSP
                String customerFullName = rs.getString("first_name") + " " + rs.getString("last_name");
                String vehicleFullName = rs.getString("vehicle_brand") + " " + rs.getString("vehicle_type");

                // Create the Booking object using the formatted strings
                returns.add(new Booking(
                        customerFullName,
                        vehicleFullName,
                        rs.getString("booking_endDate"),
                        rs.getString("booking_status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returns;
    }
}