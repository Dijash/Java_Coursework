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


            String hashedPassword = PasswordUtil.getHashPassword(password);

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO customer (first_name, last_name, gender, password, referral_code, customer_username, customer_phoneNo,  customer_email, customer_dob, customer_address, customer_country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement statement = con.prepareStatement(sql);

            statement.setString(1, firstName);
            statement.setString(2, lastName);
            statement.setString(3, gender);
            statement.setString(4, hashedPassword);
            statement.setString(5, referral);
            statement.setString(6, username);
            statement.setString(7, phone);
            statement.setString(8, email);
            statement.setString(9, dob);
            statement.setString(10, address);
            statement.setString(11, country);

            statement.executeUpdate();

            response.sendRedirect("login");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}