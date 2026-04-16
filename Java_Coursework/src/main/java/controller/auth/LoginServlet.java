package controller.auth;

import DAO.UserDAO;
import model.Customer;
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

        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(30 * 60);


        if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
            session.setAttribute("email", email);
            session.setAttribute("role", "admin");

            response.sendRedirect(request.getContextPath() + "/admin");
            return;
        }

        // Customer Login
        UserDAO dao = new UserDAO();
        String result = dao.checkLogin(email, password);

        if (result.equals("success")) {
            Customer loggedInCustomer = dao.getCustomerByEmail(email);

            session.setAttribute("user", loggedInCustomer);
            session.setAttribute("email", email);
            session.setAttribute("role", "customer");

            response.sendRedirect(request.getContextPath() + "/home");

        } else if (result.equals("wrong_password")) {
            request.setAttribute("error", "Wrong password!");
            request.getRequestDispatcher("/Pages/Auth/Login.jsp").forward(request, response);

        } else if (result.equals("user_not_found")) {
            request.setAttribute("error", "User does not exist. Please register.");
            request.getRequestDispatcher("/Pages/Auth/Login.jsp").forward(request, response);
        }
    }
}