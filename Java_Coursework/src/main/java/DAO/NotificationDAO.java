package DAO;

import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    // Fetch all sent notifications for the table
    public ResultSet getAllNotifications() throws SQLException {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT * FROM notification ORDER BY created_at DESC";
        return conn.prepareStatement(sql).executeQuery();
    }

    // Insert a notification that will be visible to all users
    public boolean sendBroadcast(String type, String description) {
        // Matches your table: notification_type, notification_description, notification_date
        String sql = "INSERT INTO notification (notification_type, notification_description, notification_date) VALUES (?, ?, CURDATE())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, type);
            stmt.setString(2, description);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}