package DAO;

import model.Booking;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    public List<Booking> getUpcomingReturns() {
        List<Booking> returns = new ArrayList<>();

        String sql = "SELECT b.booking_id, c.first_name, c.last_name, v.vehicle_brand, v.vehicle_type, " +
                "v.vehicle_numberPlate, b.booking_status, b.booking_startDate, b.booking_endDate, b.total_price " +
                "FROM booking b " +
                "JOIN customer c ON b.customer_id = c.customer_id " +
                "JOIN vehicle v ON b.vehicle_id = v.vehicle_id " +
                "WHERE b.booking_status IN ('On Track', 'Extended') " +
                "LIMIT 5";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String customerFullName = rs.getString("first_name") + " " + rs.getString("last_name");
                String vehicleFullName = rs.getString("vehicle_brand") + " " + rs.getString("vehicle_type");

                returns.add(new Booking(
                        rs.getInt("booking_id"),
                        customerFullName,
                        vehicleFullName,
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
        return returns;
    }
}