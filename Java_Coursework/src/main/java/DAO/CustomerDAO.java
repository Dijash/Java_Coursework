package DAO;

import model.Customer;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customer ORDER BY customer_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                customers.add(extractCustomerFromResultSet(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return customers;
    }

    public Customer getCustomerById(int id) {
        String sql = "SELECT * FROM customer WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return extractCustomerFromResultSet(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean deleteCustomer(int id) {
        String sql = "DELETE FROM customer WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Customer extractCustomerFromResultSet(ResultSet rs) throws SQLException {
        return new Customer(
                rs.getInt("customer_id"),
                rs.getString("first_name"),
                rs.getString("last_name"),
                rs.getString("gender"),
                rs.getString("customer_email"),
                rs.getString("customer_phoneNo"),
                rs.getString("customer_dob"),
                rs.getString("customer_address"),
                rs.getString("customer_country"),
                rs.getString("customer_license"),
                rs.getString("customer_username"),
                rs.getString("referral_code"),
                rs.getTimestamp("created_at")
        );
    }
}