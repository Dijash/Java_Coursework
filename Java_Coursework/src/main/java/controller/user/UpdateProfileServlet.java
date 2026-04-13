package controller.user;

import DAO.UserDAO;
import model.Customer;
import util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Customer currentUser = (Customer) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login");
            return;
        }

        String newUsername = request.getParameter("username");
        String newPhone = request.getParameter("phone");
        String newLicense = request.getParameter("license");
        String newAddress = request.getParameter("address");
        String newPassword = request.getParameter("password");

        UserDAO dao = new UserDAO();

        String passwordToSave = currentUser.getPassword();
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            passwordToSave = PasswordUtil.getHashPassword(newPassword);
        }

        boolean success = dao.updateCustomerProfile(
                currentUser.getCustomer_id(),
                newUsername,
                newPhone,
                newLicense,
                newAddress,
                passwordToSave
        );

        if (success) {
            Customer updatedUser = dao.getCustomerByEmail(currentUser.getCustomer_email());
            session.setAttribute("user", updatedUser);
            response.sendRedirect("settings?success=true");
        } else {
            response.sendRedirect("settings?error=true");
        }
    }
}