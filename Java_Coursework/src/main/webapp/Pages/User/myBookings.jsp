<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="jakarta.tags.core" %> <%@
taglib prefix="fmt" uri="jakarta.tags.fmt" %> <%@ taglib prefix="sql"
uri="jakarta.tags.sql" %> <%-- Database Connection --%>
<sql:setDataSource
  var="dbConnection"
  driver="com.mysql.cj.jdbc.Driver"
  url="jdbc:mysql://localhost:3306/java_coursework"
  user="root"
  password=""
/>

<%-- Fetch Total Notification Count --%>
<sql:query var="totalNotification" dataSource="${dbConnection}">
  SELECT COUNT(*) as count FROM notification;
</sql:query>

<%-- Fetch Recent Notifications for Dropdown --%>
<sql:query var="recentNotifications" dataSource="${dbConnection}">
  SELECT notification_type, notification_description, notification_date FROM
  notification ORDER BY notification_date DESC LIMIT 5;
</sql:query>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | My Bookings</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
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

      /* Notification Dropdown */
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

      /* Table */
      .content-box {
        background: var(--card-bg);
        border-radius: var(--radius-lg);
        padding: 1.5rem;
        box-shadow: var(--shadow);
        border: 1px solid var(--border);
      }
      .content-box h3 {
        font-size: 1.2rem;
        margin-bottom: 1.5rem;
        font-weight: 600;
        color: var(--primary);
      }

      table {
        width: 100%;
        border-collapse: collapse;
      }
      th {
        text-align: left;
        padding: 1rem;
        font-size: 0.75rem;
        color: var(--text-muted);
        text-transform: uppercase;
        border-bottom: 2px solid var(--bg-main);
      }
      td {
        padding: 1.25rem 1rem;
        font-size: 0.9rem;
        border-bottom: 1px solid var(--bg-main);
      }

      /* Immersive Status */
      .status-container {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-weight: 600;
        font-size: 0.85rem;
      }
      .status-dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
      }

      .btn-action {
        text-decoration: none;
        background: var(--bg-main);
        color: var(--primary);
        padding: 8px 16px;
        border-radius: var(--radius-md);
        font-size: 0.85rem;
        font-weight: 600;
        border: 1px solid var(--border);
        transition: 0.2s;
      }
      .btn-action:hover {
        background: var(--primary);
        color: white;
      }

      /* Empty State */
      .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        color: var(--text-muted);
      }
      .empty-state h4 {
        font-size: 1.1rem;
        margin-bottom: 0.5rem;
        color: var(--primary);
      }
      .empty-state p {
        font-size: 0.9rem;
      }
    </style>
  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li>
            <a href="<%= request.getContextPath() %>/userDashboard"
              >Dashboard</a
            >
          </li>
          <%-- Set My Bookings to active --%>
          <li>
            <a href="<%= request.getContextPath() %>/myBookings" class="active"
              >My Bookings</a
            >
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/settings">Settings</a>
          </li>
        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout">Logout</a>
    </aside>

    <main>
      <header class="top-navbar">
        <div class="welcome-text">
          <h1>Booking History</h1>
          <p>Review all your past and active reservations.</p>
        </div>

        <div class="user-actions">
          <a href="<%= request.getContextPath() %>/home" class="btn-home"
            >Return to Home</a
          >

          <div class="dropdown-wrapper">
            <button class="btn-notif" id="notifBtn">
              System Alerts
              <span class="notif-badge"
                ><c:out value="${totalNotification.rows[0].count}" default="0"
              /></span>
            </button>
            <div class="notif-dropdown" id="notifMenu">
              <div class="notif-header">Recent Broadcasts</div>
              <div class="notif-list">
                <c:forEach var="notif" items="${recentNotifications.rows}">
                  <div class="notif-item">
                    <strong
                      ><c:out value="${notif.notification_type}"
                    /></strong>
                    <p><c:out value="${notif.notification_description}" /></p>
                    <small
                      >Date: <c:out value="${notif.notification_date}"
                    /></small>
                  </div>
                </c:forEach>
                <c:if test="${empty recentNotifications.rows}">
                  <div
                    class="notif-item"
                    style="text-align: center; color: var(--text-muted)"
                  >
                    No active system alerts.
                  </div>
                </c:if>
              </div>
            </div>
          </div>

          <div class="user-profile">
            <span
              ><c:out
                value="${sessionScope.user.customer_username}"
                default="Profile"
            /></span>
          </div>
        </div>
      </header>

      <div class="dashboard-content">
        <section class="content-box">
          <h3>All Reservations</h3>
          <div class="table-responsive">
            <table>
              <thead>
                <tr>
                  <th>Vehicle Model</th>
                  <th>License Plate</th>
                  <th>Rental Period</th>
                  <th>Total Fare</th>
                  <th>Status</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="booking" items="${userAllBookings}">
                  <tr>
                    <td>
                      <span style="font-weight: 600; color: var(--primary)"
                        ><c:out value="${booking.vehicleDetails}"
                      /></span>
                    </td>
                    <td
                      style="color: var(--text-muted); font-family: monospace"
                    >
                      <c:out value="${booking.numberPlate}" default="N/A" />
                    </td>
                    <td style="color: var(--text-main)">
                      <c:out value="${booking.startDate}" /> &nbsp;&rarr;&nbsp;
                      <c:out value="${booking.endDate}" />
                    </td>
                    <td style="font-weight: 600">
                      ₹ <c:out value="${booking.totalPrice}" />
                    </td>
                    <td>
                      <div
                        class="status-container"
                        style="
                          color: $ {
                            booking.status== 'On Track' ? '#10b981' : (
                              booking.status == &quot;Completed&quot; ?
                                &quot;#64748b&quot;: &quot;#f59e0b&quot;
                            );
                          }
                        "
                      >
                        <span
                          class=""
                          style="
                            background-color: $ {
                              booking.status== 'On Track' ? '#10b981' : (
                                booking.status == &quot;Completed&quot; ?
                                  &quot;#64748b&quot;: &quot;#f59e0b&quot;
                              );
                            }
                            box-shadow: 0 0 8px $ {
                              booking.status== 'On Track' ? 'rgba(16,185,129,0.4)' : (
                                booking.status == &quot;Completed&quot; ?
                                  &quot;rgba(100,116,139,0.3)&quot;:
                                  &quot;rgba(245,158,11,0.4)&quot;
                              );
                            }
                          "
                        >
                        </span>
                        <c:out value="${booking.status}" />
                      </div>
                    </td>
                    <td>
                      <a
                        href="<%= request.getContextPath() %>/viewUserBooking?id=${booking.bookingId}"
                        class="btn-action"
                        >Details</a
                      >
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>

            <c:if test="${empty userAllBookings}">
              <div class="empty-state">
                <h4>No bookings found</h4>
                <p>You haven't rented any vehicles with us yet.</p>
              </div>
            </c:if>
          </div>
        </section>
      </div>
    </main>

    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const notifBtn = document.getElementById("notifBtn");
        const notifMenu = document.getElementById("notifMenu");

        notifBtn.addEventListener("click", function (event) {
          event.stopPropagation();
          notifMenu.classList.toggle("show");
        });

        window.addEventListener("click", function () {
          if (notifMenu.classList.contains("show")) {
            notifMenu.classList.remove("show");
          }
        });

        notifMenu.addEventListener("click", function (event) {
          event.stopPropagation();
        });
      });
    </script>
  </body>
</html>
