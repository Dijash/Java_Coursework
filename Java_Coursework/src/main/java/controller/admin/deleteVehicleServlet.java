package controller.admin;

import DAO.VehicleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/deleteVehicle")
public class deleteVehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String vehicleIdStr = request.getParameter("vehicle_id");
        HttpSession session = request.getSession();

        if (vehicleIdStr != null && !vehicleIdStr.isEmpty()) {
            try {
                int vehicleId = Integer.parseInt(vehicleIdStr);

                VehicleDAO vehicleDAO = new VehicleDAO();
                boolean isDeleted = vehicleDAO.deleteVehicle(vehicleId);

                if (isDeleted) {
                    session.setAttribute("successMsg", "Vehicle deleted successfully!");
                } else {
                    session.setAttribute("errorMsg", "Could not delete vehicle. It may be attached to existing customer bookings.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("errorMsg", "Invalid vehicle ID format.");
            }
        } else {
            session.setAttribute("errorMsg", "No vehicle ID provided.");
        }

        response.sendRedirect(request.getContextPath() + "/manageVehicles");
    }
}