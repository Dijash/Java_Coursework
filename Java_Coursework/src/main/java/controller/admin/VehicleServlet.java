package controller.admin;

import DAO.VehicleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// This exact URL must match the action="" attribute in your HTML form
@WebServlet("/addVehicleData")
public class VehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve text typed into the form
        String brand = request.getParameter("vehicle_brand");
        String type = request.getParameter("vehicle_type");
        String color = request.getParameter("vehicle_color");
        String numberPlate = request.getParameter("vehicle_numberPlate");
        String condition = request.getParameter("vehicle_condition");
        String status = request.getParameter("vehicle_status");

        int adminId = 1;

        VehicleDAO vehicleDAO = new VehicleDAO();
        boolean isSuccess = vehicleDAO.addVehicle(adminId, brand, type, color, numberPlate, condition, status);

        if (isSuccess) {
            response.sendRedirect(request.getContextPath() + "/manageVehicles");
        } else {
            response.sendRedirect(request.getContextPath() + "/addVehicle");
        }
    }
}