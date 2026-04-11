package DAO;

import util.DBConnection;
import model.Vehicle;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VehicleDAO {

    public boolean addVehicle(int adminId, String brand, String type, String color, String numberPlate, String condition, String status, String image) {
        boolean isAdded = false;

        // SQL Query updated to include vehicle_image
        String sql = "INSERT INTO vehicle (admin_id, customer_id, vehicle_brand, vehicle_type, vehicle_color, vehicle_numberPlate, vehicle_condition, vehicle_status, vehicle_image) " +
                "VALUES (?, NULL, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, adminId);
            statement.setString(2, brand);
            statement.setString(3, type);
            statement.setString(4, color);
            statement.setString(5, numberPlate);
            statement.setString(6, condition);
            statement.setString(7, status);
            statement.setString(8, image); // Bind the new image parameter

            // Execute the insert
            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                isAdded = true; // Successfully inserted
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isAdded;
    }

    // Delete method remains exactly the same
    public boolean deleteVehicle(int vehicleId) {
        boolean isDeleted = false;

        String sql = "DELETE FROM vehicle WHERE vehicle_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, vehicleId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                isDeleted = true;
            }

        } catch (SQLException e) {
            System.out.println("Error deleting vehicle: " + e.getMessage());
            e.printStackTrace();
        }

        return isDeleted;
    }

    public boolean updateVehicle(int vehicleId, String brand, String type, String color, String numberPlate, String condition, String status, String image) {
        boolean isUpdated = false;

        // SQL Query updated to include vehicle_image in the SET clause
        String sql = "UPDATE vehicle SET vehicle_brand = ?, vehicle_type = ?, vehicle_color = ?, " +
                "vehicle_numberPlate = ?, vehicle_condition = ?, vehicle_status = ?, vehicle_image = ? " +
                "WHERE vehicle_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setString(1, brand);
            statement.setString(2, type);
            statement.setString(3, color);
            statement.setString(4, numberPlate);
            statement.setString(5, condition);
            statement.setString(6, status);
            statement.setString(7, image); // Bind the new image parameter
            statement.setInt(8, vehicleId); // ID shifts to position 8

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                isUpdated = true;
            }

        } catch (SQLException e) {
            System.out.println("Error updating vehicle: " + e.getMessage());
            e.printStackTrace();
        }

        return isUpdated;
    }

    public Vehicle getVehicleById(int id) {
        Vehicle vehicle = null;
        String sql = "SELECT * FROM vehicle WHERE vehicle_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {

            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // Constructor updated to fetch and pass the vehicle_image column
                vehicle = new Vehicle(
                        resultSet.getInt("vehicle_id"),
                        resultSet.getString("vehicle_brand"),
                        resultSet.getString("vehicle_type"),
                        resultSet.getString("vehicle_color"),
                        resultSet.getString("vehicle_numberPlate"),
                        resultSet.getString("vehicle_condition"),
                        resultSet.getString("vehicle_status"),
                        resultSet.getString("vehicle_image") // Fetch the new image column
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicle;
    }
}