package controller.auth;

import util.CookieUtil;
import util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Delete the authentication cookie
        CookieUtil.deleteCookie(response, "role");

        // Invalidate the current user session
        SessionUtil.invalidateSession(request);

        // Redirect the user back to the login page
        response.sendRedirect(request.getContextPath() + "/");
    }
}