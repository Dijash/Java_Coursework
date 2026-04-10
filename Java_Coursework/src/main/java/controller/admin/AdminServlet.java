package controller.admin;

import DAO.AdminDAO;
import model.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/admin",
        "/manageBooking",
        "/manageVehicles",
        "/addVehicle",
        "/manageCustomers",
        "/manageReviews",
        "/manageNotification",
        "/report",
        "/settings"
})
public class AdminServlet extends HttpServlet {

    // Declare the DAO at the class level
    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        // Initialize the DAO once when the servlet is first loaded into memory
        adminDAO = new AdminDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {

            case "/admin":
                request.getRequestDispatcher("/Pages/Admin/admin.jsp").forward(request, response);
                break;

            case "/manageBooking":
                request.getRequestDispatcher("/Pages/Admin/manageBooking.jsp").forward(request, response);
                break;

            case "/addVehicle":
                request.getRequestDispatcher("/Pages/Admin/addVehicle.jsp").forward(request, response);
                break;

            case "/manageVehicles":
                request.getRequestDispatcher("/Pages/Admin/manageVehicles.jsp").forward(request, response);
                break;

            case "/manageCustomers":
                request.getRequestDispatcher("/Pages/Admin/customer.jsp").forward(request, response);
                break;

            case "/manageReviews":
                request.getRequestDispatcher("/Pages/Admin/reviews.jsp").forward(request, response);
                break;

            case "/manageNotification":
                request.getRequestDispatcher("/Pages/Admin/notifications.jsp").forward(request, response);
                break;

            case "/report":
                request.getRequestDispatcher("/Pages/Admin/reports.jsp").forward(request, response);
                break;

            case "/settings":
                request.getRequestDispatcher("/Pages/Admin/settings.jsp").forward(request, response);
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}