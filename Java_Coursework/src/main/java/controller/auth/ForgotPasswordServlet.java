package controller.auth;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Pages/Auth/forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        UserDAO dao = new UserDAO();

        if (dao.checkEmailExists(email)) {
            HttpSession session = request.getSession();
            session.setAttribute("reset_email", email);

            response.sendRedirect(request.getContextPath() + "/resetPassword");
        } else {
            request.setAttribute("error", "We couldn't find an account with that email.");
            request.getRequestDispatcher("/Pages/Auth/forgotPassword.jsp").forward(request, response);
        }
    }
}