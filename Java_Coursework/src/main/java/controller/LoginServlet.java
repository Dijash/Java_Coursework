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
        String result = dao.checkLogin(email, password);

        if (result.equals("success")) {

            HttpSession session = request.getSession();
            session.setAttribute("email", email);

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