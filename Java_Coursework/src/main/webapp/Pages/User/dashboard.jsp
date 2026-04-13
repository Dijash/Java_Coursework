<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<%-- Database Connection --%>
<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/java_coursework"
                   user="root" password=""/>

<%-- Fetch Total Notification Count --%>
<sql:query var="totalNotification" dataSource="${dbConnection}">
     SELECT COUNT(*) as count FROM notification;
</sql:query>

<%-- Fetch Recent Notifications for Dropdown --%>
<sql:query var="recentNotifications" dataSource="${dbConnection}">
     SELECT notification_type, notification_description, notification_date
     FROM notification
     ORDER BY notification_date DESC LIMIT 5;
</sql:query>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | User Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
      :root {
        --primary: #0f172a;
        --sidebar-active: #334155;
        --accent: #3b82f6;
        --accent-hover: #2563eb;
        --success: #10b981;
        --warning: #f59e0b;
        --danger: #ef4444;
        --bg-main: #f8fafc;
        --card-bg: #ffffff;
        --text-main: #1e293b;
        --text-muted: #64748b;
        --border: #e2e8f0;
        --radius-lg: 12px;
        --radius-md: 8px;
        --radius-sm: 4px;
        --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        --shadow-lg: 0 10px 25px rgba(0, 0, 0, 0.1);
      }

      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Poppins", sans-serif;
        background-color: var(--bg-main);
        color: var(--text-main);
        display: flex;
        min-height: 100vh;
      }

      /* Sidebar */
      .sidebar {
        width: 260px;
        background: var(--primary);
        color: white;
        padding: 2rem 1.5rem;
        display: flex;
        flex-direction: column;
        position: fixed;
        height: 100vh;
      }

      .sidebar h2 {
        font-size: 1.5rem;
        font-weight: 700;
        margin-bottom: 2.5rem;
      }
      .sidebar nav ul {
        list-style: none;
      }
      .sidebar nav a {
        text-decoration: none;
        color: #94a3b8;
        padding: 0.8rem 1rem;
        display: flex;
        align-items: center;
        border-radius: var(--radius-md);
        margin-bottom: 0.5rem;
        transition: 0.3s;
        font-weight: 500;
      }
      .sidebar nav a:hover,
      .sidebar nav a.active {
        background: var(--sidebar-active);
        color: white;
      }

      .logout {
        margin-top: auto;
        background: var(--danger);
        color: white !important;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 0.8rem 1rem;
        border-radius: var(--radius-md);
        text-decoration: none;
        font-weight: 500;
        transition: 0.3s;
      }
      .logout:hover {
        background: #dc2626;
      }

      /* Main Area */
      main {
        flex: 1;
        margin-left: 260px;
        display: flex;
        flex-direction: column;
      }

      /* Top Nav */
      .top-navbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1.5rem 2.5rem;
        background: var(--bg-main);
        border-bottom: 1px solid var(--border);
      }
      .welcome-text h1 {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary);
      }
      .welcome-text p {
        font-size: 0.9rem;
        color: var(--text-muted);
      }

      .user-actions {
        display: flex;
        align-items: center;
        gap: 1.25rem;
      }

      /* Home Button */
      .btn-home {
        text-decoration: none;
        background: transparent;
        color: var(--text-main);
        padding: 0.6rem 1.2rem;
        border-radius: var(--radius-md);
        font-weight: 600;
        font-size: 0.9rem;
        border: 1px solid var(--border);
        transition: 0.2s;
      }
      .btn-home:hover {
        background: var(--card-bg);
        border-color: #cbd5e1;
        box-shadow: var(--shadow);
      }

      /* Notification Button & Dropdown */
      .dropdown-wrapper {
        position: relative;
      }

      .btn-notif {
        background: var(--card-bg);
        border: 1px solid var(--border);
        padding: 0.6rem 1.2rem;
        border-radius: var(--radius-md);
        font-weight: 600;
        font-size: 0.9rem;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: var(--text-main);
        transition: 0.2s;
      }
      .btn-notif:hover {
        border-color: var(--accent);
      }

      .notif-badge {
        background: var(--danger);
        color: white;
        padding: 2px 6px;
        border-radius: var(--radius-sm);
        font-size: 0.75rem;
      }

      .notif-dropdown {
        position: absolute;
        top: calc(100% + 0.5rem);
        right: 0;
        width: 340px;
        background: var(--card-bg);
        border: 1px solid var(--border);
        border-radius: var(--radius-md);
        box-shadow: var(--shadow-lg);
        display: none;
        flex-direction: column;
        z-index: 100;
        overflow: hidden;
      }

      .notif-dropdown.show {
        display: flex;
      }

      .notif-header {
        padding: 1rem;
        border-bottom: 1px solid var(--border);
        background: var(--bg-main);
        font-weight: 600;
        font-size: 0.9rem;
        color: var(--primary);
      }

      .notif-list {
        max-height: 320px;
        overflow-y: auto;
      }

      .notif-item {
        padding: 1rem;
        border-bottom: 1px solid var(--border);
        transition: background 0.2s;
        text-align: left;
      }
      .notif-item:last-child {
        border-bottom: none;
      }
      .notif-item:hover {
        background: #f8fafc;
      }
      .notif-item strong {
        display: block;
        font-size: 0.85rem;
        color: var(--accent);
        margin-bottom: 0.25rem;
      }
      .notif-item p {
        font-size: 0.8rem;
        color: var(--text-muted);
        margin-bottom: 0.5rem;
        line-height: 1.4;
      }
      .notif-item small {
        font-size: 0.7rem;
        color: #94a3b8;
        display: block;
      }

      .user-profile {
        display: flex;
        align-items: center;
        font-weight: 600;
        padding-left: 1.25rem;
        border-left: 2px solid var(--border);
        color: var(--primary);
      }

      /* Dashboard Content */
      .dashboard-content {
        padding: 2.5rem;
      }
      .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2.5rem;
      }
      .stat-card {
        background: var(--card-bg);
        padding: 1.5rem;
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        border: 1px solid var(--border);
      }
      .stat-card h3 {
        font-size: 0.85rem;
        color: var(--text-muted);
        text-transform: uppercase;
        margin-bottom: 0.5rem;
      }
      .stat-card .value {
        font-size: 1.75rem;
        font-weight: 700;
        color: var(--primary);
      }

      /* Table */
      .content-box {
        background: var(--card-bg);
        border-radius: var(--radius-lg);
        padding: 1.5rem;
        box-shadow: var(--shadow);
        border: 1px solid var(--border);
      }
      .content-box h3 {
        font-size: 1.1rem;
        margin-bottom: 1.25rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      .view-all-link {
        font-size: 0.85rem;
        color: var(--accent);
        text-decoration: none;
        font-weight: 500;
      }
      table {
        width: 100%;
        border-collapse: collapse;
      }
      th {
        text-align: left;
        padding: 0.75rem 1rem;
        font-size: 0.75rem;
        color: var(--text-muted);
        text-transform: uppercase;
        border-bottom: 2px solid var(--bg-main);
      }
      td {
        padding: 1rem;
        font-size: 0.9rem;
        border-bottom: 1px solid var(--bg-main);
      }

      .status-container {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-weight: 600;
        font-size: 0.85rem;
      }


      .btn-action {
        text-decoration: none;
        background: var(--bg-main);
        color: var(--primary);
        padding: 6px 12px;
        border-radius: var(--radius-md);
        font-size: 0.8rem;
        font-weight: 600;
        border: 1px solid var(--border);
      }
    </style>
  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="<%= request.getContextPath() %>/userDashboard" class="active">Dashboard</a></li>
          <li><a href="<%= request.getContextPath() %>/myBookings">My Bookings</a></li>
          <li><a href="<%= request.getContextPath() %>/settings">Settings</a></li>
        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout">Logout</a>
    </aside>

    <main>
      <header class="top-navbar">
        <div class="welcome-text">
          <h1>
            Hello, <c:out value="${sessionScope.user.customer_username}" default="Driver" />
          </h1>
          <p>Ready for your next journey?</p>
        </div>

        <div class="user-actions">
          <a href="<%= request.getContextPath() %>/home" class="btn-home">Return to Home</a>

          <div class="dropdown-wrapper">
            <button class="btn-notif" id="notifBtn">
              Notifications
              <span class="notif-badge"><c:out value="${totalNotification.rows[0].count}" default="0" /></span>
            </button>

            <div class="notif-dropdown" id="notifMenu">
              <div class="notif-header">
                Recent Broadcasts
              </div>
              <div class="notif-list">
                <c:forEach var="notif" items="${recentNotifications.rows}">
                  <div class="notif-item">
                    <strong><c:out value="${notif.notification_type}"/></strong>
                    <p><c:out value="${notif.notification_description}"/></p>
                    <small>Date: <c:out value="${notif.notification_date}"/></small>
                  </div>
                </c:forEach>

                <c:if test="${empty recentNotifications.rows}">
                  <div class="notif-item" style="text-align: center; color: var(--text-muted);">
                    No active system alerts.
                  </div>
                </c:if>
              </div>
            </div>
          </div>

          <div class="user-profile">
            <span><c:out value="${sessionScope.user.customer_username}" default="Profile" /></span>
          </div>
        </div>
      </header>

      <div class="dashboard-content">
        <section class="stats-container">
          <div class="stat-card">
            <h3>Active Bookings</h3>
            <div class="value" style="color: var(--accent)">
              <c:out value="${activeBookingsCount}" default="0" />
            </div>
          </div>
          <div class="stat-card">
            <h3>Completed Trips</h3>
            <div class="value">
              <c:out value="${completedTripsCount}" default="0" />
            </div>
          </div>
          <div class="stat-card">
            <h3>Total Spent</h3>
            <div class="value" style="color: var(--success)">
              ₹ <c:out value="${totalSpent}" default="0.00" />
            </div>
          </div>
        </section>

        <section class="content-box">
          <h3>
            Recent Bookings
            <a href="<%= request.getContextPath() %>/myBookings" class="view-all-link">View All</a>
          </h3>
          <div class="table-responsive">
            <table>
              <thead>
                <tr>
                  <th>Vehicle</th>
                  <th>Rental Period</th>
                  <th>Total Fare</th>
                  <th>Status</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="booking" items="${userRecentBookings}">
                  <tr>
                    <td>
                      <span style="font-weight: 600"><c:out value="${booking.vehicleDetails}" /></span>
                    </td>
                    <td style="color: var(--text-muted)">
                      <c:out value="${booking.startDate}" /> - <c:out value="${booking.endDate}" />
                    </td>
                    <td style="font-weight: 500">
                      ₹ <c:out value="${booking.totalPrice}" />
                    </td>
                    <td>
                      <div class="status-container"
                           style="color: ${booking.status == 'On Track' ? '#10b981' : (booking.status == 'Completed' ? '#64748b' : '#f59e0b')};">
                        <span class=""
                              style="background-color: ${booking.status == 'On Track' ? '#10b981' : (booking.status == 'Completed' ? '#64748b' : '#f59e0b')};
                                     box-shadow: 0 0 8px ${booking.status == 'On Track' ? 'rgba(16,185,129,0.4)' : (booking.status == 'Completed' ? 'rgba(100,116,139,0.3)' : 'rgba(245,158,11,0.4)')};">
                        </span>
                        <c:out value="${booking.status}" />
                      </div>
                    </td>
                    <td>
                      <a href="<%= request.getContextPath() %>/viewUserBooking?id=${booking.bookingId}" class="btn-action">Details</a>
                    </td>
                  </tr>
                </c:forEach>

                <c:if test="${empty userRecentBookings}">
                  <tr>
                    <td colspan="5" style="text-align: center; padding: 2rem; color: var(--text-muted);">
                      You have no recent bookings recorded.
                    </td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>
        </section>
      </div>
    </main>

    <script>
      document.addEventListener("DOMContentLoaded", function() {
        const notifBtn = document.getElementById("notifBtn");
        const notifMenu = document.getElementById("notifMenu");

        notifBtn.addEventListener("click", function(event) {
          event.stopPropagation();
          notifMenu.classList.toggle("show");
        });

        window.addEventListener("click", function() {
          if (notifMenu.classList.contains("show")) {
            notifMenu.classList.remove("show");
          }
        });

        notifMenu.addEventListener("click", function(event) {
          event.stopPropagation();
        });
      });
    </script>
  </body>
</html>