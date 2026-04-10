package DAO;

import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class VehicleDAO {

    public boolean addVehicle(int adminId, String brand, String type, String color, String numberPlate, String condition, String status) {
        boolean isAdded = false;

        // SQL Query to insert the new vehicle. customer_id is NULL because it isn't rented yet.
        String sql = "INSERT INTO vehicle (admin_id, customer_id, vehicle_brand, vehicle_type, vehicle_color, vehicle_numberPlate, vehicle_condition, vehicle_status) " +
                "VALUES (?, NULL, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Bind the parameters to the ? placeholders
            stmt.setInt(1, adminId);
            stmt.setString(2, brand);
            stmt.setString(3, type);
            stmt.setString(4, color);
            stmt.setString(5, numberPlate);
            stmt.setString(6, condition);
            stmt.setString(7, status);

            // Execute the insert
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                isAdded = true; // Successfully inserted
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isAdded;
    }
}