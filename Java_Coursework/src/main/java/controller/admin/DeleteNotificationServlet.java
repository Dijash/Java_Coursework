package controller.admin;

import DAO.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteNotification")
public class DeleteNotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Ensure the user is an admin (Optional but recommended for security)
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Get the ID from the URL (?id=X)
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int notificationId = Integer.parseInt(idParam);

                // 3. Call your DAO to delete the record
                AdminDAO dao = new AdminDAO(); // Update this if your DAO has a different name
                boolean success = dao.deleteNotification(notificationId);

                // 4. Redirect back to the notifications page
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/manageNotification?msg=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/manageNotification?error=delete_failed");
                }

            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/manageNotification?error=invalid_id");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/manageNotification");
        }
    }
}