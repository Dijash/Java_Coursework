<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/java_coursework"
                   user="root" password=""/>

<sql:query var="upcomingReturns" dataSource="${dbConnection}">
    SELECT
        c.first_name,
        c.last_name,
        v.vehicle_brand,
        v.vehicle_type,
        b.booking_endDate,
        b.booking_status
    FROM
        booking b
    JOIN
        customer c ON b.customer_id = c.customer_id
    JOIN
        vehicle v ON b.vehicle_id = v.vehicle_id
    WHERE
        b.booking_status IN ('On Track', 'Extended')
    LIMIT 5;
</sql:query>

<sql:query var="totalBookings" dataSource="${dbConnection}">
    SELECT COUNT(*) as count FROM booking;
</sql:query>

<sql:query var="totalVehicles" dataSource="${dbConnection}">
    SELECT COUNT(*) as count FROM vehicle;
</sql:query>

<sql:query var="totalRevenue" dataSource="${dbConnection}">
    SELECT SUM(payment_amount) AS payment FROM payment;
</sql:query>

<sql:query var="totalRentals" dataSource="${dbConnection}">
    SELECT COUNT(*) as total_rentals FROM booking;
</sql:query>

<<sql:query var="totalNotification" dataSource="${dbConnection}">
     SELECT COUNT(*) as count FROM notification;
 </sql:query>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/AdminStyle.css">
  </head>
  <body>
    <input type="checkbox" id="menu-toggle" style="display:none;" />
    <label for="menu-toggle" class="menu-btn" style="display:none;">MENU</label>

    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="<%= request.getContextPath() %>/admin" class="active"><span>Dashboard</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageBooking"><span>Bookings</span></a></li>
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
     <section class="stats-container">
             <div class="stat-card">
               <h3>Total Bookings</h3>
               <div class="value"><c:out value="${totalBookings.rows[0].count}" default="0" /></div>
             </div>

             <div class="stat-card">
               <h3>Active Fleet</h3>
               <div class="value"><c:out value="${totalVehicles.rows[0].count}" default="0" /></div>
             </div>

             <div class="stat-card">
               <h3>Total Revenue</h3>
               <div class="value">₹<c:out value="${totalRevenue.rows[0].payment}" default="0" /></div>
             </div>

             <div class="stat-card">
               <h3>Active Rentals</h3>
               <div class="value"><c:out value="${totalRentals.rows[0].total_rentals}" default="0" /></div>
             </div>

             <div class="stat-card">
               <h3>Total Notifications</h3>
               <div class="value"><c:out value="${totalNotification.rows[0].count}" default="0" /></div>
             </div>
           </section>

      <div class="dashboard-grid">
        <section class="left-col">
          <div class="content-box">
            <h3>Latest Notification</h3>
            <div class="promo-banner">
              <p>
                Flash Sale: Use promo code <strong>"DRIVE2026"</strong> to offer
                clients a flat <strong>12% discount</strong> on all SUV rentals.
              </p>
              <small
                style="
                  color: #c53030;
                  display: block;
                  margin-top: 12px;
                  font-weight: 600;
                "
                >Valid until April 15, 2026</small
              >
            </div>
          </div>

          <div class="content-box">
            <h3>Upcoming Returns</h3>
            <div class="table-responsive">
              <table>
                <thead>
                  <tr>
                    <th>Customer</th>
                    <th>Vehicle</th>
                    <th>End Date</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="row" items="${upcomingReturns.rows}">
                    <tr>
                      <td><strong><c:out value="${row.first_name} ${row.last_name}" /></strong></td>
                      <td><c:out value="${row.vehicle_brand} ${row.vehicle_type}" /></td>
                      <td><c:out value="${row.booking_endDate}" /></td>
                      <td style="color: ${row.booking_status == 'Extended' ? '#f39c12' : '#27ae60'}; font-weight: 600">
                          <c:out value="${row.booking_status}" />
                      </td>
                    </tr>
                  </c:forEach>

                  <c:if test="${empty upcomingReturns.rows}">
                     <tr>
                        <td colspan="4" style="text-align: center; color: #7f8c8d;">No upcoming returns scheduled.</td>
                     </tr>
                  </c:if>
                </tbody>
              </table>
            </div>
          </div>
        </section>

        <section class="right-col">
          <div class="content-box car-highlight">
            <h3>Vehicle of the Month</h3>
            <img src="<%= request.getContextPath() %>/Assets/Background.jpg" alt="Skoda SUV" />
            <div class="car-info">
              <span class="badge">Most Requested</span>
              <strong>Skoda SUV Ti-1000</strong>
              <p><strong>Category:</strong> Premium Utility</p>
              <p>
                The Ti-1000 series continues to dominate the rental charts due
                to its exceptional fuel efficiency and European safety
                standards. Perfect for long-distance family travel.
              </p>
            </div>
          </div>
        </section>
      </div>
    </main>
  </body>
</html>