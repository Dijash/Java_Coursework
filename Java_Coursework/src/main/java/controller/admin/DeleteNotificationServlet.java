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

        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int notificationId = Integer.parseInt(idParam);

                AdminDAO dao = new AdminDAO();
                boolean success = dao.deleteNotification(notificationId);

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