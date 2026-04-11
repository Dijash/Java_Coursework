<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Booking Details</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
      :root {
        --primary: #0f1011;
        --primary-hover: #273f4b;
        --accent: #ef4444;
        --bg-light: #f4f7f9;
        --text-dark: #1e293b;
        --text-muted: #64748b;
        --white: #ffffff;
        --shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        --radius-lg: 16px;
        --radius-md: 12px;
        --sidebar-width: 260px;
        --border: #e2e8f0;
      }

      * { margin: 0; padding: 0; box-sizing: border-box; }

      body {
        font-family: 'Poppins', sans-serif;
        background: var(--bg-light);
        color: var(--text-dark);
        display: flex;
        min-height: 100vh;
      }

      /* Sidebar Navigation (Matches previous pages) */
      .sidebar {
        width: var(--sidebar-width);
        background: var(--primary);
        color: white;
        padding: 30px 20px;
        display: flex;
        flex-direction: column;
        position: fixed;
        height: 100vh;
        z-index: 1000;
      }

      .sidebar h2 { font-size: 1.6rem; margin-bottom: 2.5rem; text-align: center; font-weight: 700; }
      .sidebar nav { flex: 1; }
      .sidebar ul { list-style: none; }
      .sidebar a {
        text-decoration: none;
        color: #ffffff;
        padding: 14px 18px;
        margin-bottom: 6px;
        display: flex;
        align-items: center;
        border-radius: 12px;
        font-size: 0.95rem;
        transition: all 0.2s ease;
      }
      .sidebar a:hover, .sidebar a.active {
        background: rgba(255, 255, 255, 0.1);
        transform: translateX(5px);
      }
      .sidebar a.active { background: var(--primary-hover); }

      .logout {
        background: var(--accent) !important;
        justify-content: center;
        font-weight: 600;
        margin-top: auto;
      }

      /* Main Content Area */
      main {
        flex: 1;
        margin-left: var(--sidebar-width);
        padding: 40px;
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      .page-container {
        width: 100%;
        max-width: 900px;
      }

      .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
      }

      .page-header h2 { font-size: 1.5rem; font-weight: 700; color: var(--primary); }

      .btn-back {
        text-decoration: none;
        color: var(--text-muted);
        font-weight: 500;
        font-size: 0.9rem;
        padding: 10px 20px;
        background: white;
        border-radius: 10px;
        border: 1px solid var(--border);
        transition: 0.2s;
      }
      .btn-back:hover { background: #f8fafc; color: var(--primary); }

      /* Details Box */
      .content-box {
        background: var(--white);
        padding: 40px;
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        border: 1px solid var(--border);
      }

      .booking-top {
        display: flex;
        align-items: center;
        gap: 25px;
        padding-bottom: 30px;
        margin-bottom: 30px;
        border-bottom: 2px solid var(--bg-light);
      }

      .booking-icon {
        width: 70px;
        height: 70px;
        background: #e1f0fa;
        color: #2980b9;
        border-radius: var(--radius-md);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        font-weight: 700;
      }

      .booking-info-main { flex: 1; }
      .booking-info-main h1 { font-size: 1.6rem; color: var(--primary); margin-bottom: 5px; }
      .booking-info-main p { color: var(--text-muted); font-size: 0.95rem; }

      .status-badge {
        padding: 8px 16px;
        border-radius: 30px;
        font-weight: 700;
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        background: #3498db;
        color: white;
      }

      /* Details Grid */
      .detail-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
      }

      .detail-card {
        background: var(--bg-light);
        padding: 20px;
        border-radius: var(--radius-md);
        border: 1px solid var(--border);
        transition: 0.2s;
      }

      .detail-card:hover {
        background: white;
        border-color: #cbd5e1;
        transform: translateY(-2px);
      }

      .label {
        font-size: 0.75rem;
        color: var(--text-muted);
        text-transform: uppercase;
        font-weight: 700;
        display: block;
        margin-bottom: 8px;
        letter-spacing: 0.5px;
      }

      .value {
        font-weight: 500;
        font-size: 1rem;
        color: var(--text-dark);
      }

      .price-tag {
        color: #10b981;
        font-weight: 700;
        font-size: 1.2rem;
      }

      @media (max-width: 768px) {
        .detail-grid { grid-template-columns: 1fr; }
        .sidebar { display: none; }
        main { margin-left: 0; }
        .booking-top { flex-direction: column; text-align: center; }
      }
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
      <div class="page-container">
        <div class="page-header">
          <h2>Booking Record</h2>
          <div style="display: flex; gap: 10px;">
              <a href="<%= request.getContextPath() %>/manageBooking" class="btn-back">Back to List</a>
              <a href="<%= request.getContextPath() %>/editBooking?id=${booking.bookingId}" class="btn-back" style="background: var(--primary); color: white;">Edit Status</a>
          </div>
        </div>

        <div class="content-box">
          <div class="booking-top">
            <div class="booking-icon">BK</div>
            <div class="booking-info-main">
              <h1>Booking #${booking.bookingId}</h1>
              <p>Requested by <strong>${booking.customerName}</strong></p>
            </div>
            <span class="status-badge" style="background:
                <c:choose>
                    <c:when test="${booking.status == 'On Track'}">#3498db</c:when>
                    <c:when test="${booking.status == 'Completed'}">#10b981</c:when>
                    <c:otherwise>#ef4444</c:otherwise>
                </c:choose>;">
                ${booking.status}
            </span>
          </div>

          <div class="detail-grid">
            <div class="detail-card">
              <span class="label">Customer Name</span>
              <div class="value">${booking.customerName}</div>
            </div>

            <div class="detail-card">
              <span class="label">Assigned Vehicle</span>
              <div class="value">${booking.vehicleDetails}</div>
            </div>

            <div class="detail-card">
              <span class="label">License Plate</span>
              <div class="value">${booking.numberPlate}</div>
            </div>

            <div class="detail-card">
              <span class="label">Rental Period</span>
              <div class="value">${booking.startDate} &mdash; ${booking.endDate}</div>
            </div>

            <div class="detail-card" style="grid-column: span 2;">
              <span class="label">Financial Summary</span>
              <div class="value price-tag">₹${booking.totalPrice}</div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </body>
</html>