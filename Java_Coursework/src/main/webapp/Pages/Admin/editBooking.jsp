<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Edit Booking</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
      :root {
        --primary: #0f1011;
        --primary-hover: #273f4b;
        --accent: #ef4444;
        --success: #10b981;
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

      /* Sidebar Navigation */
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
        max-width: 600px;
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

      /* Form Card */
      .content-box {
        background: var(--white);
        padding: 40px;
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        border: 1px solid var(--border);
      }

      .form-group { margin-bottom: 25px; }

      .form-label {
        font-size: 0.75rem;
        color: var(--text-muted);
        text-transform: uppercase;
        font-weight: 700;
        display: block;
        margin-bottom: 10px;
        letter-spacing: 0.5px;
      }

      .booking-summary {
        background: var(--bg-light);
        padding: 15px;
        border-radius: var(--radius-md);
        margin-bottom: 25px;
        border-left: 4px solid var(--primary-hover);
      }

      .booking-summary p { font-size: 0.9rem; margin-bottom: 5px; }

      select {
        width: 100%;
        padding: 14px;
        border-radius: var(--radius-md);
        border: 1px solid var(--border);
        font-family: 'Poppins', sans-serif;
        font-size: 1rem;
        color: var(--text-dark);
        background: #f8fafc;
        outline: none;
        cursor: pointer;
        transition: 0.2s;
      }

      select:focus { border-color: var(--primary-hover); box-shadow: 0 0 0 3px rgba(39, 63, 75, 0.1); }

      .save-btn {
        width: 100%;
        background: var(--primary);
        color: white;
        border: none;
        padding: 16px;
        border-radius: var(--radius-md);
        font-weight: 600;
        font-size: 1rem;
        font-family: 'Poppins', sans-serif;
        cursor: pointer;
        transition: all 0.2s ease;
      }

      .save-btn:hover { background: var(--primary-hover); transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }

      @media (max-width: 768px) {
        .sidebar { display: none; }
        main { margin-left: 0; }
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
            <li><a href="<%= request.getContextPath() %>/report"><span>Reports</span></a></li>

        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout"><span>Logout</span></a>
    </aside>

    <main>
      <div class="page-container">
        <div class="page-header">
          <h2>Edit Booking</h2>
          <a href="<%= request.getContextPath() %>/manageBooking" class="btn-back">Cancel</a>
        </div>

        <div class="content-box">
          <div class="booking-summary">
            <p><strong>Booking ID:</strong> #${booking.bookingId}</p>
            <p><strong>Customer:</strong> ${booking.customerName}</p>
            <p><strong>Vehicle:</strong> ${booking.vehicleDetails}</p>
          </div>

          <form action="<%= request.getContextPath() %>/updateBooking" method="POST">
            <input type="hidden" name="booking_id" value="${booking.bookingId}">

            <div class="form-group">
              <label class="form-label">Update Booking Status</label>
              <select name="status">
                <option value="On Track" ${booking.status == 'On Track' ? 'selected' : ''}>On Track</option>
                <option value="Completed" ${booking.status == 'Completed' ? 'selected' : ''}>Completed</option>
                <option value="Cancelled" ${booking.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                <option value="Extended" ${booking.status == 'Extended' ? 'selected' : ''}>Extended</option>
              </select>
            </div>

            <button type="submit" class="save-btn">Save Changes</button>
          </form>
        </div>
      </div>
    </main>
  </body>
</html>