<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<%-- Database Connection --%>
<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/java_coursework"
                   user="root" password=""/>

<sql:query var="notifHistory" dataSource="${dbConnection}">
    SELECT * FROM notification ORDER BY notification_date DESC;
</sql:query>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>RentAll | Manage Notifications</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/AdminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
      body { font-family: "Poppins", sans-serif; }

      /* Form Styling */
      .send-box { background: var(--white); padding: 30px; border-radius: var(--radius); box-shadow: var(--shadow); margin-bottom: 30px; border: 1px solid #e2e8f0; }
      .form-group { margin-bottom: 15px; }
      .form-group label { display: block; font-weight: 600; margin-bottom: 8px; font-size: 0.9rem; }
      .form-control { width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 8px; font-family: inherit; }
      .btn-send { background: var(--primary); color: white; border: none; padding: 12px 24px; border-radius: 8px; font-weight: 600; cursor: pointer; transition: 0.2s; }
      .btn-send:hover { background: var(--primary-hover); }

      /* Table Specifics */
      .notif-msg { color: var(--text-muted); font-size: 0.85rem; max-width: 400px; }
    </style>
  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="<%= request.getContextPath() %>/admin"><span>Dashboard</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageBooking"><span>Bookings</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageVehicles"><span>Manage Vehicles</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageCustomers"><span>Customers</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageReviews"><span>Reviews</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageNotification" class="active"><span>Notifications</span></a></li>
          <li><a href="<%= request.getContextPath() %>/report"><span>Reports</span></a></li>

        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout"><span>Logout</span></a>
    </aside>

    <main>
      <div class="page-header">
        <h2>Broadcast Notification</h2>
      </div>

      <div class="send-box">
        <form action="sendNotification" method="POST">
          <div class="form-group">
            <label>Subject</label>
            <input type="text" name="subject" class="form-control" placeholder="e.g., Weekend Discount!" required>
          </div>
          <div class="form-group">
            <label>Message Content</label>
            <textarea name="message" class="form-control" rows="3" placeholder="Write your message to all users..." required></textarea>
          </div>
          <button type="submit" class="btn-send">Send to All Users</button>
        </form>
      </div>

      <div class="content-box">
        <h3 style="padding: 20px; font-size: 1.1rem; border-bottom: 1px solid #f1f5f9;">Sent History</h3>
        <div class="table-responsive">
          <table style="width: 100%; border-collapse: collapse;">
            <thead>
              <tr style="background: #f8fafc; text-align: left;">
                <th style="padding: 15px;">Subject</th>
                <th style="padding: 15px;">Message</th>
                <th style="padding: 15px;">Date Sent</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="row" items="${notifHistory.rows}">
                  <tr style="border-bottom: 1px solid #f1f5f9;">
                    <td style="padding: 15px;"><strong><c:out value="${row.notification_type}" /></strong></td>
                    <td style="padding: 15px;"><div class="notif-msg"><c:out value="${row.notification_description}" /></div></td>
                    <td style="padding: 15px; font-size: 0.8rem; color: #94a3b8;">${row.notification_date}</td>
                  </tr>
              </c:forEach>
              <c:if test="${empty notifHistory.rows}">
                <tr><td colspan="3" style="text-align: center; padding: 30px; color: #94a3b8;">No notifications sent yet.</td></tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </body>
</html>