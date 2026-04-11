package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// Protect all these admin routes
@WebFilter({
        "/admin",
        "/manageBooking", "/viewBooking", "/editBooking", "/updateBooking", "/deleteBooking",
        "/manageVehicles", "/addVehicle", "/viewVehicle", "/editVehicle",
        "/manageCustomers", "/viewCustomer", "/deleteCustomer",
        "/manageReviews", "/deleteReview",
        "/manageNotification", "/sendNotification",
        "/report"
})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedAsAdmin = (session != null && "admin".equals(session.getAttribute("role")));

        if (isLoggedAsAdmin) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
    }
}