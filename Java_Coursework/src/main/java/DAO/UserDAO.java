package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;
import util.PasswordUtil;

public class UserDAO {

    public boolean checkLogin(String email, String password) {

        boolean isValid = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                System.out.println("Stored password: " + storedPassword);
                System.out.println("Entered password: " + password);

                if (PasswordUtil.checkPassword(password, storedPassword)) {
                    isValid = true;
                }
            } else {
                System.out.println("No user found with email: " + email);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isValid;
    }
}