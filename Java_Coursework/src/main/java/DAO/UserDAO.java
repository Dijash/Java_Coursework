package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;
import util.PasswordUtil;

public class UserDAO {

    public String checkLogin(String email, String password) {

        String result = "error";

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String storedPassword = rs.getString("password");

                if (PasswordUtil.checkPassword(password, storedPassword)) {
                    result = "success";
                } else {
                    result = "wrong_password";   // ❌ Wrong password
                }

            } else {
                result = "user_not_found";      // ❌ No user
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}