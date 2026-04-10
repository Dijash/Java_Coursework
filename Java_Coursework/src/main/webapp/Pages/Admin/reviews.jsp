<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Reviews</title>
    <style>
      /* Reused Base Styles */
      :root {
        --primary: #0f1011;
        --primary-hover: #273f4b;
        --accent: #c0392b;
        --bg-light: #f4f7f9;
        --text-dark: #2c3e50;
        --text-muted: #7f8c8d;
        --white: #ffffff;
        --shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        --radius: 16px;
        --sidebar-width: 260px;
      }
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      body {
        font-family: "Inter", "Segoe UI", system-ui, sans-serif;
        background: var(--bg-light);
        color: var(--text-dark);
        display: flex;
        min-height: 100vh;
        overflow-x: hidden;
      }

      /* Sidebar */
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
        letter-spacing: -0.5px;
      }
      .sidebar h2 span {
        color: #3498db;
      }
      .sidebar nav {
        flex: 1;
      }
      .sidebar ul {
        list-style: none;
      }
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
      .sidebar a:hover,
      .sidebar a.active {
        background: rgba(255, 255, 255, 0.1);
        transform: translateX(5px);
      }
      .sidebar a.active {
        background: var(--primary-hover);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
      }
      .logout {
        background: var(--accent) !important;
        justify-content: center;
        font-weight: 600;
        margin-top: auto;
      }

      /* Main Content */
      main {
        flex: 1;
        margin-left: var(--sidebar-width);
        padding: 40px;
        max-width: 100%;
      }
      .page-header {
        margin-bottom: 30px;
      }

      /* Content Box & Table */
      .content-box {
        background: var(--white);
        padding: 28px;
        border-radius: var(--radius);
        box-shadow: var(--shadow);
      }
      .table-responsive {
        overflow-x: auto;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        min-width: 1000px;
      }
      table th {
        background: #f8fafc;
        color: var(--text-muted);
        font-weight: 600;
        text-transform: uppercase;
        font-size: 11px;
        padding: 16px;
        text-align: left;
      }
      table td {
        padding: 18px 16px;
        border-bottom: 1px solid #f1f5f9;
        font-size: 14px;
        vertical-align: top;
      }
      table tr:hover td {
        background: #fdfdfd;
      }

      /* Table Specific Formatting */
      .stars {
        color: #f39c12;
        letter-spacing: 2px;
        font-size: 1.1rem;
        white-space: nowrap;
      }
      .review-text-td {
        max-width: 320px;
        line-height: 1.6;
        color: var(--text-dark);
      }

      /* Plain Text Statuses */
      .status-pending {
        color: #f39c12;
        font-weight: 700;
      }
      .status-accepted {
        color: #27ae60;
        font-weight: 700;
      }
      .status-rejected {
        color: #c0392b;
        font-weight: 700;
      }

      /* Action Buttons */
      .action-buttons {
        display: flex;
        gap: 8px;
      }
      .action-btn {
        background: transparent;
        padding: 6px 12px;
        border-radius: 6px;
        cursor: pointer;
        font-size: 12px;
        transition: 0.2s;
        border: 1px solid;
        font-weight: 600;
      }
      .btn-accept {
        color: #27ae60;
        border-color: #27ae60;
      }
      .btn-accept:hover {
        background: #27ae60;
        color: white;
      }
      .btn-reject {
        color: #e74c3c;
        border-color: #e74c3c;
      }
      .btn-reject:hover {
        background: #e74c3c;
        color: white;
      }
    </style>
  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li>
            <a href="dashboard.html"><span>Dashboard</span></a>
          </li>
          <li>
            <a href="bookings.html"><span>Bookings</span></a>
          </li>
          <li>
            <a href="vehicles.html"><span>Manage Vehicles</span></a>
          </li>
          <li>
            <a href="customer.html"><span>Customers</span></a>
          </li>
          <li>
            <a href="reviews.html" class="active"><span>Reviews</span></a>
          </li>
          <li>
            <a href="notifications.html"><span>Notifications</span></a>
          </li>
          <li>
            <a href="reports.html"><span>Reports</span></a>
          </li>
          <li>
            <a href="settings.html"><span>Settings</span></a>
          </li>
        </ul>
      </nav>
      <a href="#" class="logout"><span>Logout</span></a>
    </aside>

    <main>
      <div class="page-header">
        <h2>Customer Reviews</h2>
      </div>

      <div class="content-box">
        <div class="table-responsive">
          <table>
            <thead>
              <tr>
                <th>Customer</th>
                <th>Vehicle</th>
                <th>Date</th>
                <th>Review</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><strong>Mike Ross</strong></td>
                <td>BMW X5 M-Sport</td>
                <td>Mar 28, 2026</td>
                <td class="review-text-td">
                  "Great SUV, handled the mountain roads perfectly. The only
                  issue was the pickup process took a little longer than
                  expected, but otherwise great."
                </td>
                <td class="status-pending">Pending Review</td>
                <td class="action-buttons">
                  <button class="action-btn btn-accept">Accept</button>
                  <button class="action-btn btn-reject">Reject</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </body>
</html>
