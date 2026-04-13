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
  FROM notification ORDER BY notification_date DESC LIMIT 5;
</sql:query>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Booking Details</title>
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

      * { margin: 0; padding: 0; box-sizing: border-box; }

      body {
        font-family: "Poppins", sans-serif;
        background-color: var(--bg-main);
        color: var(--text-main);
        display: flex;
        min-height: 100vh;
      }

      /* Sidebar */
      .sidebar {
        width: 260px; background: var(--primary); color: white;
        padding: 2rem 1.5rem; display: flex; flex-direction: column;
        position: fixed; height: 100vh;
      }
      .sidebar h2 { font-size: 1.5rem; font-weight: 700; margin-bottom: 2.5rem; }
      .sidebar nav ul { list-style: none; }
      .sidebar nav a {
        text-decoration: none; color: #94a3b8; padding: 0.8rem 1rem;
        display: flex; align-items: center; border-radius: var(--radius-md);
        margin-bottom: 0.5rem; transition: 0.3s; font-weight: 500;
      }
      .sidebar nav a:hover, .sidebar nav a.active { background: var(--sidebar-active); color: white; }

      .logout {
        margin-top: auto; background: var(--danger); color: white !important;
        display: flex; justify-content: center; padding: 0.8rem 1rem;
        border-radius: var(--radius-md); text-decoration: none;
        font-weight: 500; transition: 0.3s;
      }
      .logout:hover { background: #dc2626; }

      /* Main Area */
      main { flex: 1; margin-left: 260px; display: flex; flex-direction: column; }

      /* Top Nav */
      .top-navbar {
        display: flex; justify-content: space-between; align-items: center;
        padding: 1.5rem 2.5rem; background: var(--bg-main); border-bottom: 1px solid var(--border);
      }
      .welcome-text h1 { font-size: 1.5rem; font-weight: 700; color: var(--primary); }
      .welcome-text p { font-size: 0.9rem; color: var(--text-muted); }

      .user-actions { display: flex; align-items: center; gap: 1.25rem; }

      .btn-home {
        text-decoration: none; background: transparent; color: var(--text-main);
        padding: 0.6rem 1.2rem; border-radius: var(--radius-md); font-weight: 600;
        font-size: 0.9rem; border: 1px solid var(--border); transition: 0.2s;
      }
      .btn-home:hover { background: var(--card-bg); border-color: #cbd5e1; box-shadow: var(--shadow); }

      /* Notification Dropdown */
      .dropdown-wrapper { position: relative; }
      .btn-notif {
        background: var(--card-bg); border: 1px solid var(--border);
        padding: 0.6rem 1.2rem; border-radius: var(--radius-md);
        font-weight: 600; font-size: 0.9rem; cursor: pointer;
        display: flex; align-items: center; gap: 0.5rem; color: var(--text-main); transition: 0.2s;
      }
      .btn-notif:hover { border-color: var(--accent); }
      .notif-badge { background: var(--danger); color: white; padding: 2px 6px; border-radius: var(--radius-sm); font-size: 0.75rem; }

      .notif-dropdown {
        position: absolute; top: calc(100% + 0.5rem); right: 0; width: 340px;
        background: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius-md);
        box-shadow: var(--shadow-lg); display: none; flex-direction: column; z-index: 100; overflow: hidden;
      }
      .notif-dropdown.show { display: flex; }
      .notif-header { padding: 1rem; border-bottom: 1px solid var(--border); background: var(--bg-main); font-weight: 600; font-size: 0.9rem; color: var(--primary); }
      .notif-list { max-height: 320px; overflow-y: auto; }
      .notif-item { padding: 1rem; border-bottom: 1px solid var(--border); transition: background 0.2s; text-align: left; }
      .notif-item:last-child { border-bottom: none; }
      .notif-item:hover { background: #f8fafc; }
      .notif-item strong { display: block; font-size: 0.85rem; color: var(--accent); margin-bottom: 0.25rem; }
      .notif-item p { font-size: 0.8rem; color: var(--text-muted); margin-bottom: 0.5rem; line-height: 1.4; }
      .notif-item small { font-size: 0.7rem; color: #94a3b8; display: block; }

      .user-profile {
        display: flex; align-items: center; font-weight: 600;
        padding-left: 1.25rem; border-left: 2px solid var(--border); color: var(--primary);
      }

      /* Dashboard Content */
      .dashboard-content { padding: 2.5rem; max-width: 1000px; }

      /* Admin-Style Header Actions */
      .header-actions { display: flex; justify-content: flex-end; margin-bottom: 1.5rem; }
      .btn-back-dashboard {
        text-decoration: none; background: var(--primary); color: white;
        padding: 0.6rem 1.2rem; border-radius: var(--radius-md);
        font-weight: 600; font-size: 0.85rem; transition: 0.3s;
        box-shadow: var(--shadow);
      }
      .btn-back-dashboard:hover { background: var(--sidebar-active); transform: translateY(-1px); }

      .content-box {
        background: var(--card-bg); border-radius: var(--radius-lg); padding: 2.5rem;
        box-shadow: var(--shadow); border: 1px solid var(--border);
      }

      .booking-header {
        display: flex; justify-content: space-between; align-items: flex-start;
        border-bottom: 1px solid var(--border); padding-bottom: 1.5rem; margin-bottom: 1.5rem;
      }
      .booking-title h2 { font-size: 1.5rem; color: var(--primary); margin-bottom: 0.25rem; }
      .booking-title p { font-size: 0.9rem; color: var(--text-muted); font-family: monospace; }

      /* Immersive Plain-Text Status */
      .status-text {
        font-weight: 700; font-size: 1rem; text-transform: uppercase; letter-spacing: 0.05em;
      }

      /* Grid Layout */
      .details-grid {
        display: grid; grid-template-columns: 1fr 1fr; gap: 2.5rem;
      }
      .details-section {
        background: var(--bg-main); padding: 1.75rem; border-radius: var(--radius-md); border: 1px solid var(--border);
      }
      .details-section h3 { font-size: 1.1rem; color: var(--primary); margin-bottom: 1.5rem; font-weight: 700; }

      .detail-row {
        display: flex; justify-content: space-between; margin-bottom: 1.25rem;
        border-bottom: 1px dashed #cbd5e1; padding-bottom: 0.75rem;
      }
      .detail-row:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
      .detail-label { color: var(--text-muted); font-size: 0.9rem; font-weight: 500; }
      .detail-value { font-weight: 600; color: var(--text-main); font-size: 0.95rem; text-align: right;}

      .total-row {
        background: var(--primary); color: white; padding: 1.25rem;
        border-radius: var(--radius-md); margin-top: 1.5rem;
        display: flex; justify-content: space-between; align-items: center;
      }
      .total-row .detail-label { color: #cbd5e1; font-weight: 600; }
      .total-row .detail-value { color: var(--success); font-size: 1.4rem; text-shadow: 0 0 10px rgba(16,185,129,0.3); }

    </style>
  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li><a href="<%= request.getContextPath() %>/userDashboard">Dashboard</a></li>
          <li><a href="<%= request.getContextPath() %>/myBookings" class="active">My Bookings</a></li>
          <li><a href="<%= request.getContextPath() %>/settings">Settings</a></li>
        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout">Logout</a>
    </aside>

    <main>
      <header class="top-navbar">
        <div class="welcome-text">
          <h1>Booking Summary</h1>
          <p>Full breakdown of your reservation details.</p>
        </div>

        <div class="user-actions">
          <a href="<%= request.getContextPath() %>/home" class="btn-home">Return to Home</a>

          <div class="dropdown-wrapper">
            <button class="btn-notif" id="notifBtn">
              Notifications
              <span class="notif-badge"><c:out value="${totalNotification.rows[0].count}" default="0" /></span>
            </button>
            <div class="notif-dropdown" id="notifMenu">
              <div class="notif-header">Recent Broadcasts</div>
              <div class="notif-list">
                <c:forEach var="notif" items="${recentNotifications.rows}">
                  <div class="notif-item">
                    <strong><c:out value="${notif.notification_type}"/></strong>
                    <p><c:out value="${notif.notification_description}"/></p>
                    <small>Date: <c:out value="${notif.notification_date}"/></small>
                  </div>
                </c:forEach>
              </div>
            </div>
          </div>

          <div class="user-profile">
            <span><c:out value="${sessionScope.user.customer_username}" default="Profile" /></span>
          </div>
        </div>
      </header>

      <div class="dashboard-content">

        <div class="header-actions">
          <a href="<%= request.getContextPath() %>/userDashboard" class="btn-back-dashboard">
            Back to Dashboard
          </a>
        </div>

        <section class="content-box">
          <div class="booking-header">
            <div class="booking-title">
              <h2><c:out value="${bookingDetails.vehicleDetails}" /></h2>
              <p>REF ID: #<c:out value="${bookingDetails.bookingId}" /></p>
            </div>

            <div class="status-text"
                 style="color: ${bookingDetails.status == 'On Track' ? '#10b981' : (bookingDetails.status == 'Completed' ? '#64748b' : '#f59e0b')};
                        text-shadow: 0 0 15px ${bookingDetails.status == 'On Track' ? 'rgba(16,185,129,0.2)' : 'transparent'};">
              <c:out value="${bookingDetails.status}" />
            </div>
          </div>

          <div class="details-grid">
            <div class="details-section">
              <h3>Vehicle Info</h3>
              <div class="detail-row">
                <span class="detail-label">Model</span>
                <span class="detail-value"><c:out value="${bookingDetails.vehicleDetails}" /></span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Number Plate</span>
                <span class="detail-value" style="font-family: monospace; letter-spacing: 1px;"><c:out value="${bookingDetails.numberPlate}" /></span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Renter</span>
                <span class="detail-value"><c:out value="${sessionScope.user.first_name} ${sessionScope.user.last_name}" /></span>
              </div>
            </div>

            <div class="details-section">
              <h3>Trip Schedule</h3>
              <div class="detail-row">
                <span class="detail-label">Pickup</span>
                <span class="detail-value"><c:out value="${bookingDetails.startDate}" /></span>
              </div>
              <div class="detail-row">
                <span class="detail-label">Drop-off</span>
                <span class="detail-value"><c:out value="${bookingDetails.endDate}" /></span>
              </div>

              <div class="total-row">
                <span class="detail-label">Grand Total Paid</span>
                <span class="detail-value">₹ <c:out value="${bookingDetails.totalPrice}" /></span>
              </div>
            </div>
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