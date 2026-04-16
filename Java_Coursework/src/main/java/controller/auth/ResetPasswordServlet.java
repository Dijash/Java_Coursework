package controller.auth;

import DAO.UserDAO;
import util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("reset_email") == null) {
            response.sendRedirect(request.getContextPath() + "/forgotPassword");
            return;
        }

        request.getRequestDispatcher("/Pages/Auth/resetPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("reset_email") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String email = (String) session.getAttribute("reset_email");
        String newPassword = request.getParameter("newPassword");

        String hashedPassword = PasswordUtil.getHashPassword(newPassword);

        UserDAO dao = new UserDAO();
        boolean success = dao.updatePasswordByEmail(email, hashedPassword);

        if (success) {
            session.removeAttribute("reset_email");

            request.setAttribute("message", "Password reset successful! You can now log in.");
            request.getRequestDispatcher("/Pages/Auth/Login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to reset password. Please try again.");
            request.getRequestDispatcher("/Pages/Auth/resetPassword.jsp").forward(request, response);
        }
    }
}