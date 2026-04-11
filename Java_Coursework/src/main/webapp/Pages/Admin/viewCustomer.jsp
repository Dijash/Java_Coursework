<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | View Customer</title>
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

      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

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

      .sidebar h2 {
        font-size: 1.6rem;
        margin-bottom: 2.5rem;
        text-align: center;
        font-weight: 700;
      }

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

      .page-header h2 {
        font-size: 1.5rem;
        font-weight: 700;
      }

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

      /* Profile Content Box */
      .content-box {
        background: var(--white);
        padding: 40px;
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        border: 1px solid var(--border);
      }

      .profile-top {
        display: flex;
        align-items: center;
        gap: 25px;
        padding-bottom: 30px;
        margin-bottom: 30px;
        border-bottom: 2px solid var(--bg-light);
      }

      /* Initials Avatar */
      .avatar-circle {
        width: 85px;
        height: 85px;
        background: #eef2ff;
        color: #4f46e5;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        font-weight: 700;
        border: 2px solid #e0e7ff;
      }

      .user-info-main { flex: 1; }
      .user-info-main h1 { font-size: 1.8rem; color: var(--primary); margin-bottom: 5px; }
      .user-info-main p { color: var(--text-muted); font-size: 0.95rem; }
      .username-badge { color: #3b82f6; font-weight: 600; }

      /* Delete Button Style */
      .delete-btn {
        background: #fff1f2;
        color: #be123c;
        border: 1px solid #fecdd3;
        padding: 12px 24px;
        border-radius: 12px;
        font-weight: 600;
        font-family: 'Poppins', sans-serif;
        cursor: pointer;
        transition: all 0.2s;
      }

      .delete-btn:hover { background: #be123c; color: white; transform: translateY(-2px); }

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
        margin-bottom: 6px;
        letter-spacing: 0.5px;
      }

      .value {
        font-weight: 500;
        font-size: 1rem;
        color: var(--text-dark);
      }

      @media (max-width: 768px) {
        .detail-grid { grid-template-columns: 1fr; }
        .profile-top { flex-direction: column; text-align: center; }
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
          <li><a href="<%= request.getContextPath() %>/admin">Dashboard</a></li>
          <li><a href="<%= request.getContextPath() %>/manageBooking">Bookings</a></li>
          <li><a href="<%= request.getContextPath() %>/manageVehicles">Manage Vehicles</a></li>
          <li><a href="<%= request.getContextPath() %>/manageCustomers" class="active">Customers</a></li>
          <li><a href="<%= request.getContextPath() %>/manageReviews">Reviews</a></li>
          <li><a href="<%= request.getContextPath() %>/report">Reports</a></li>
          <li><a href="<%= request.getContextPath() %>/settings">Settings</a></li>
        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout">Logout</a>
    </aside>

    <main>
      <div class="page-container">
        <div class="page-header">
          <h2>Customer Details</h2>
          <a href="<%= request.getContextPath() %>/manageCustomers" class="btn-back">Back to Database</a>
        </div>

        <div class="content-box">
          <div class="profile-top">
            <div class="avatar-circle">
               ${customer.first_name.substring(0,1)}${customer.last_name.substring(0,1)}
            </div>
            <div class="user-info-main">
              <h1><c:out value="${customer.fullName}" /></h1>
              <p>User ID: <strong>#${customer.customer_id}</strong> | <span class="username-badge">@${customer.customer_username}</span></p>
            </div>

            <form action="<%= request.getContextPath() %>/deleteCustomer" method="POST" onsubmit="return confirm('This will permanently delete this customer. Proceed?');">
              <input type="hidden" name="customer_id" value="${customer.customer_id}">
              <button type="submit" class="delete-btn">Delete Account</button>
            </form>
          </div>

          <div class="detail-grid">
            <div class="detail-card">
              <span class="label">Gender</span>
              <div class="value">${customer.gender}</div>
            </div>

            <div class="detail-card">
              <span class="label">Email Address</span>
              <div class="value">${customer.customer_email}</div>
            </div>

            <div class="detail-card">
              <span class="label">Phone Number</span>
              <div class="value">${customer.customer_phoneNo}</div>
            </div>

            <div class="detail-card">
              <span class="label">Date of Birth</span>
              <div class="value">${customer.customer_dob}</div>
            </div>

            <div class="detail-card">
              <span class="label">Full Address</span>
              <div class="value">${customer.customer_address}, ${customer.customer_country}</div>
            </div>

            <div class="detail-card">
              <span class="label">License Number</span>
              <div class="value">${customer.customer_license}</div>
            </div>

            <div class="detail-card">
              <span class="label">Registration Date</span>
              <div class="value">${customer.created_at}</div>
            </div>

            <div class="detail-card">
              <span class="label">Referral Code</span>
              <div class="value" style="color: #10b981; font-weight: 700;">${customer.referral_code}</div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </body>
</html>