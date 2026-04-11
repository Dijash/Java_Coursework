package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Customer;
import util.DBConnection;
import util.PasswordUtil;

public class UserDAO {

    public String checkLogin(String email, String password) {

        String result = "error";

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM customer WHERE customer_email = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, email);

            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");

                if (PasswordUtil.checkPassword(password, storedPassword)) {
                    result = "success";
                } else {
                    result = "wrong_password";
                }

            } else {
                result = "user_not_found";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // NEW METHOD: Fetches the full customer profile for the session
    public Customer getCustomerByEmail(String email) {
        String sql = "SELECT * FROM customer WHERE customer_email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {

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
                        rs.getString("password"),
                        rs.getTimestamp("created_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
    public boolean updateCustomerProfile(int id, String user, String phone, String license, String addr, String pass) {
        String sql = "UPDATE customer SET customer_username=?, customer_phoneNo=?, customer_license=?, customer_address=?, password=? WHERE customer_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user);
            stmt.setString(2, phone);
            stmt.setString(3, license);
            stmt.setString(4, addr);
            stmt.setString(5, pass);
            stmt.setInt(6, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}