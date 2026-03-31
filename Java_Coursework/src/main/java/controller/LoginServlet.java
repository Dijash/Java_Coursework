package controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/Pages/Auth/Login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();

        boolean isValid = dao.checkLogin(email, password);

        if (isValid) {
            HttpSession session = request.getSession();
            session.setAttribute("email", email);

            System.out.println("Login success! Redirecting to home for user: " + email);

            response.sendRedirect(request.getContextPath() + "/home");
        } else {

            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/Pages/Auth/Login.jsp").forward(request, response);
        }
    }
}