package controller.auth;

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

            PreparedStatement statement = con.prepareStatement(sql);
            PreparedStatement customerStatement = con.prepareStatement(newsql);

            statement.setString(1, firstName);
            statement.setString(2, lastName);
            statement.setString(3, dob);
            statement.setString(4, gender);
            statement.setString(5, email);
            statement.setString(6, customer_phoneNo);
            statement.setString(7, address);
            statement.setString(8, country);
            statement.setString(9, username);
            statement.setString(10, hashedPassword);
            statement.setString(11, referral);

            statement.executeUpdate();

            customerStatement.setString(1, customer_username);
            customerStatement.setString(2, customer_phoneNo);
            customerStatement.setString(3, customer_email);
            customerStatement.setString(4, customer_dob);
            customerStatement.setString(5, customer_address);
            customerStatement.setString(6, customer_country);

            customerStatement.executeUpdate();

            // Redirect after success
            response.sendRedirect("login");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}