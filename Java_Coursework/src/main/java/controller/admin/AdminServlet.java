package controller.admin;

import DAO.*;
import model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet({
        "/admin",
        "/manageBooking", "/viewBooking", "/editBooking", "/updateBooking", "/deleteBooking",
        "/manageVehicles", "/addVehicle", "/viewVehicle", "/editVehicle",
        "/manageCustomers", "/viewCustomer", "/deleteCustomer",
        "/manageReviews", "/deleteReview",
        "/manageNotification", "/sendNotification",
        "/report"
})
public class AdminServlet extends HttpServlet {

    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();
        BookingDAO bookingDAO = new BookingDAO();

        switch (path) {
            case "/admin":
                request.getRequestDispatcher("/Pages/Admin/admin.jsp").forward(request, response);
                break;
            case "/addVehicle":
                request.getRequestDispatcher("/Pages/Admin/addVehicle.jsp").forward(request, response);
                break;

            case "/manageBooking":
                request.setAttribute("bookings", bookingDAO.getAllBookings());
                request.getRequestDispatcher("/Pages/Admin/manageBooking.jsp").forward(request, response);
                break;

            case "/viewBooking":
            case "/editBooking":
                String bIdStr = request.getParameter("id");
                if (bIdStr != null) {
                    request.setAttribute("booking", bookingDAO.getBookingById(Integer.parseInt(bIdStr)));
                }
                String target = path.equals("/viewBooking") ? "/Pages/Admin/viewBooking.jsp" : "/Pages/Admin/editBooking.jsp";
                request.getRequestDispatcher(target).forward(request, response);
                break;

            case "/manageVehicles":
                request.getRequestDispatcher("/Pages/Admin/manageVehicles.jsp").forward(request, response);
                break;

            case "/viewVehicle":
            case "/editVehicle":
                String vehicleIdStr = request.getParameter("id");
                if (vehicleIdStr != null && !vehicleIdStr.isEmpty()) {
                    VehicleDAO vDao = new VehicleDAO();
                    request.setAttribute("vehicle", vDao.getVehicleById(Integer.parseInt(vehicleIdStr)));
                }
                String vTarget = path.equals("/editVehicle") ? "/Pages/Admin/editVehicle.jsp" : "/Pages/Admin/viewVehicle.jsp";
                request.getRequestDispatcher(vTarget).forward(request, response);
                break;

            case "/manageCustomers":
                CustomerDAO customerDAO = new CustomerDAO();
                request.setAttribute("customers", customerDAO.getAllCustomers());
                request.getRequestDispatcher("/Pages/Admin/customer.jsp").forward(request, response);
                break;

            case "/viewCustomer":
                String cIdParam = request.getParameter("id");
                if (cIdParam != null) {
                    CustomerDAO cDao = new CustomerDAO();
                    request.setAttribute("customer", cDao.getCustomerById(Integer.parseInt(cIdParam)));
                }
                request.getRequestDispatcher("/Pages/Admin/viewCustomer.jsp").forward(request, response);
                break;

            case "/manageNotification":
                request.getRequestDispatcher("/Pages/Admin/notifications.jsp").forward(request, response);
                break;

            case "/manageReviews":
                request.getRequestDispatcher("/Pages/Admin/reviews.jsp").forward(request, response);
                break;

            default:
                request.getRequestDispatcher("/index.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        BookingDAO bookingDAO = new BookingDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        NotificationDAO notificationDAO = new NotificationDAO();
        ReviewDAO reviewDAO = new ReviewDAO();

        switch (path) {
            case "/sendNotification":
            String type = request.getParameter("subject");
            String desc = request.getParameter("message");

            if (type != null && desc != null) {
                notificationDAO.sendBroadcast(type, desc);
            }
            response.sendRedirect(request.getContextPath() + "/manageNotification");
            break;

            case "/deleteReview":
                String reviewIdStr = request.getParameter("reviewId");
                if (reviewIdStr != null) {
                }
                response.sendRedirect(request.getContextPath() + "/manageReviews");
                break;

            case "/updateBooking":
                int updateId = Integer.parseInt(request.getParameter("booking_id"));
                String newStatus = request.getParameter("status");
                bookingDAO.updateBookingStatus(updateId, newStatus);
                response.sendRedirect(request.getContextPath() + "/manageBooking");
                break;

            case "/deleteBooking":
                int delBId = Integer.parseInt(request.getParameter("booking_id"));
                bookingDAO.deleteBooking(delBId);
                response.sendRedirect(request.getContextPath() + "/manageBooking");
                break;

            case "/deleteCustomer":
                String cIdStr = request.getParameter("customer_id");
                if (cIdStr != null && !cIdStr.isEmpty()) {
                    customerDAO.deleteCustomer(Integer.parseInt(cIdStr));
                }
                response.sendRedirect(request.getContextPath() + "/manageCustomers");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/admin");
                break;
        }
    }
}