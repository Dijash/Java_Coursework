package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DBConnection;
import util.PasswordUtil;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/Pages/Auth/Register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // Get form data
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String country = request.getParameter("country");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String referral = request.getParameter("referral");

            String customer_username = request.getParameter("username");
            String customer_phoneNo = request.getParameter("phone");
            String customer_email = request.getParameter("email");
            String customer_dob = request.getParameter("dob");
            String customer_address = request.getParameter("address");
            String customer_country = request.getParameter("country");


            // Hash password
            String hashedPassword = PasswordUtil.getHashPassword(password);

            // Insert into DB
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO users (first_name, last_name, dob, gender, email, phone, address, country, username, password, referral_code) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            String newsql = "INSERT INTO customer (customer_username, customer_phoneNo, customer_email, customer_dob, customer_address, customer_country) VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            PreparedStatement pps = con.prepareStatement(newsql);

            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, dob);
            ps.setString(4, gender);
            ps.setString(5, email);
            ps.setString(6, customer_phoneNo);
            ps.setString(7, address);
            ps.setString(8, country);
            ps.setString(9, username);
            ps.setString(10, hashedPassword);
            ps.setString(11, referral);

            ps.executeUpdate();

            pps.setString(1, customer_username);
            pps.setString(2, customer_phoneNo);
            pps.setString(3, customer_email);
            pps.setString(4, customer_dob);
            pps.setString(5, customer_address);
            pps.setString(6, customer_country);

            pps.executeUpdate();

            // Redirect after success
            response.sendRedirect("login");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}