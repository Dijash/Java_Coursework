package DAO;

import model.Review;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.review_id, r.customer_id, CONCAT(c.first_name, ' ', c.last_name) as customer_name, " +
                "r.review_description, r.review_date " +
                "FROM review r " +
                "JOIN customer c ON r.customer_id = c.customer_id " +
                "ORDER BY r.review_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                reviews.add(new Review(
                        rs.getInt("review_id"),
                        rs.getInt("customer_id"),
                        rs.getString("customer_name"),
                        rs.getString("review_description"),
                        rs.getTimestamp("review_date")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return reviews;
    }
}