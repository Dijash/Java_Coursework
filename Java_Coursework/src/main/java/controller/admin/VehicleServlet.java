package controller.admin;

import DAO.VehicleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/addVehicleData")
// This annotation is REQUIRED for the Servlet to understand file uploads
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10) // 10MB Max File Size
public class VehicleServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve standard text fields
        String brand = request.getParameter("vehicle_brand");
        String type = request.getParameter("vehicle_type");
        String color = request.getParameter("vehicle_color");
        String numberPlate = request.getParameter("vehicle_numberPlate");
        String condition = request.getParameter("vehicle_condition");
        String status = request.getParameter("vehicle_status");
        int adminId = 1;

        // 2. IMAGE UPLOAD LOGIC
        String fileName = "default_car.jpg"; // A default image just in case they don't upload one
        Part filePart = request.getPart("vehicle_image");

        // Check if a file was actually uploaded
        if (filePart != null && filePart.getSize() > 0) {
            fileName = filePart.getSubmittedFileName();

            // Find the exact path on your computer where the webapp is running
            String uploadPath = getServletContext().getRealPath("") + File.separator + "Assets";
            File uploadDir = new File(uploadPath);

            // Create the Assets folder if it doesn't exist yet
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Save the physical file into that folder
            filePart.write(uploadPath + File.separator + fileName);
        }

        // 3. Save to Database (Now passing the fileName at the end)
        VehicleDAO vehicleDAO = new VehicleDAO();
        boolean isSuccess = vehicleDAO.addVehicle(adminId, brand, type, color, numberPlate, condition, status, fileName);

        // 4. Redirect with success/error messages
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