<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/java_coursework"
                   user="root" password=""/>

<sql:query var="allBookings" dataSource="${dbConnection}">
    SELECT
        b.booking_id,
        c.first_name,
        c.last_name,
        v.vehicle_brand,
        v.vehicle_type,
        v.vehicle_numberPlate,
        b.booking_startDate,
        b.booking_endDate,
        b.booking_status
    FROM
        booking b
    JOIN
        customer c ON b.customer_id = c.customer_id
    JOIN
        vehicle v ON b.vehicle_id = v.vehicle_id
    ORDER BY
        b.booking_id DESC;
</sql:query>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Bookings</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/ManageBooking.css">
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
          <li><a href="<%= request.getContextPath() %>/settings"><span>Settings</span></a></li>
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
              <c:forEach var="row" items="${allBookings.rows}">
                <tr>
                  <td><strong><c:out value="${row.booking_id}" /></strong></td>
                  <td><c:out value="${row.first_name} ${row.last_name}" /></td>
                  <td><c:out value="${row.vehicle_brand} ${row.vehicle_type}" /></td>
                  <td><c:out value="${row.vehicle_numberPlate}" /></td>
                  <td><c:out value="${row.booking_startDate} to ${row.booking_endDate}" /></td>

                  <td style="font-weight: 600; color:
                      <c:choose>
                          <c:when test="${row.booking_status == 'Active' || row.booking_status == 'On Track'}">#3498db</c:when>
                          <c:when test="${row.booking_status == 'Completed'}">#27ae60</c:when>
                          <c:when test="${row.booking_status == 'Extended'}">#f39c12</c:when>
                          <c:otherwise>#e74c3c</c:otherwise>
                      </c:choose>;">
                      <c:out value="${row.booking_status}" />
                  </td>

                  <td class="action-buttons">
                    <button class="action-btn-view">View</button>
                    <button class="action-btn-edit">Edit</button>
                    <button class="action-btn-delete">Delete</button>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty allBookings.rows}">
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