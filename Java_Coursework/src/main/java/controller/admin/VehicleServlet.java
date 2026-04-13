package controller.admin;

import DAO.VehicleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/addVehicleData")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10) // 10MB Max File Size
public class VehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String brand = request.getParameter("vehicle_brand");
        String type = request.getParameter("vehicle_type");
        String color = request.getParameter("vehicle_color");
        String numberPlate = request.getParameter("vehicle_numberPlate");
        String condition = request.getParameter("vehicle_condition");
        String status = request.getParameter("vehicle_status");
        int adminId = 1;

        String fileName = "default_car.jpg";
        Part filePart = request.getPart("vehicle_image");

        if (filePart != null && filePart.getSize() > 0) {
            fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "Assets";
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            filePart.write(uploadPath + File.separator + fileName);
        }

        VehicleDAO vehicleDAO = new VehicleDAO();
        boolean isSuccess = vehicleDAO.addVehicle(adminId, brand, type, color, numberPlate, condition, status, fileName);

        HttpSession session = request.getSession();
        if (isSuccess) {
            session.setAttribute("successMsg", "Vehicle added successfully!");
            response.sendRedirect(request.getContextPath() + "/manageVehicles");
        } else {
            session.setAttribute("errorMsg", "Database Error: Could not save vehicle.");
            response.sendRedirect(request.getContextPath() + "/addVehicle");
        }
    }
}