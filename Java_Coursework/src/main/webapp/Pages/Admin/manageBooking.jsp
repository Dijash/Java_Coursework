<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Bookings</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/AdminStyle.css">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/ManageBooking.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            background-color: #f4f7f9;
        }
        main {
            flex: 1;
            margin-left: 260px;
            padding: 40px;
        }
        .action-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
        }
        .action-btn {
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }
        .action-btn:active { transform: scale(0.95); }
        .action-btn-view { background: #e1f0fa; color: #2980b9; }
        .action-btn-view:hover { background: #3498db; color: white; }
        .action-btn-edit { background: #fef9e7; color: #f39c12; }
        .action-btn-edit:hover { background: #f1c40f; color: white; }
        .action-btn-delete { background: #fceceb; color: #c0392b; }
        .action-btn-delete:hover { background: #e74c3c; color: white; }
    </style>
  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="<%= request.getContextPath() %>/admin"><span>Dashboard</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageBooking" class="active"><span>Bookings</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageVehicles"><span>Manage Vehicles</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageCustomers"><span>Customers</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageReviews"><span>Reviews</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageNotification"><span>Notifications</span></a></li>
          <li><a href="<%= request.getContextPath() %>/report"><span>Reports</span></a></li>

        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout"><span>Logout</span></a>
    </aside>

    <main>
      <div class="page-header">
        <h2>All Bookings</h2>
      </div>

      <div class="content-box">
        <div class="table-responsive">
          <table>
            <thead>
              <tr>
                <th>Booking ID</th>
                <th>Customer</th>
                <th>Vehicle</th>
                <th>Number Plate</th>
                <th>Dates</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="booking" items="${bookings}">
                <tr>
                  <td><strong>#<c:out value="${booking.bookingId}" /></strong></td>
                  <td><c:out value="${booking.customerName}" /></td>
                  <td><c:out value="${booking.vehicleDetails}" /></td>
                  <td><c:out value="${booking.numberPlate}" /></td>
                  <td><c:out value="${booking.startDate} to ${booking.endDate}" /></td>

                  <td style="font-weight: 600; color:
                      <c:choose>
                          <c:when test="${booking.status == 'Active' || booking.status == 'On Track'}">#3498db</c:when>
                          <c:when test="${booking.status == 'Completed'}">#27ae60</c:when>
                          <c:otherwise>#e74c3c</c:otherwise>
                      </c:choose>;">
                      <c:out value="${booking.status}" />
                  </td>

                  <td>
                    <div class="action-buttons">
                        <a href="<%= request.getContextPath() %>/viewBooking?id=${booking.bookingId}" class="action-btn action-btn-view">View</a>

                        <a href="<%= request.getContextPath() %>/editBooking?id=${booking.bookingId}" class="action-btn action-btn-edit">Edit</a>

                        <form action="<%= request.getContextPath() %>/deleteBooking" method="POST" style="display: contents;">
                            <input type="hidden" name="booking_id" value="${booking.bookingId}">
                            <button type="submit" class="action-btn action-btn-delete" onclick="return confirm('Are you sure you want to delete this booking?');">Delete</button>
                        </form>
                    </div>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty bookings}">
                 <tr>
                    <td colspan="7" style="text-align: center; color: #7f8c8d; padding: 30px;">No bookings found.</td>
                 </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </body>
</html>