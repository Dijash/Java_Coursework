<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Vehicle Details</title>
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
        max-width: 900px;
      }

      .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
      }

      .page-header h2 { font-size: 1.5rem; font-weight: 700; color: var(--primary); }

      .btn-group { display: flex; gap: 12px; }

      .btn {
        padding: 10px 20px;
        border-radius: 10px;
        text-decoration: none;
        font-size: 0.9rem;
        font-weight: 600;
        transition: 0.2s;
        border: 1px solid transparent;
        cursor: pointer;
        font-family: 'Poppins', sans-serif;
      }

      .btn-secondary { background: white; color: var(--text-muted); border-color: var(--border); }
      .btn-secondary:hover { background: #f8fafc; color: var(--primary); }

      .btn-primary { background: var(--primary); color: white; }
      .btn-primary:hover { background: var(--primary-hover); transform: translateY(-1px); }

      /* Vehicle Card */
      .content-box {
        background: var(--white);
        padding: 40px;
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow);
        border: 1px solid var(--border);
      }

      .vehicle-hero {
        width: 100%;
        height: 320px;
        border-radius: var(--radius-md);
        margin-bottom: 35px;
        background-color: #f1f5f9;
        background-size: cover;
        background-position: center;
        border: 1px solid var(--border);
        display: flex;
        align-items: flex-end;
        padding: 25px;
      }

      .status-badge {
        background: rgba(255, 255, 255, 0.9);
        padding: 8px 16px;
        border-radius: 30px;
        font-weight: 700;
        font-size: 0.8rem;
        color: var(--primary);
        text-transform: uppercase;
        backdrop-filter: blur(5px);
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      }

      /* Details Grid */
      .detail-grid {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 25px;
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
        font-size: 1.05rem;
        color: var(--text-dark);
      }

      @media (max-width: 768px) {
        .detail-grid { grid-template-columns: 1fr; }
        .sidebar { display: none; }
        main { margin-left: 0; }
        .vehicle-hero { height: 200px; }
      }
    </style>
  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
            <li><a href="<%= request.getContextPath() %>/admin"><span>Dashboard</span></a></li>
            <li><a href="<%= request.getContextPath() %>/manageBooking"><span>Bookings</span></a></li>
            <li><a href="<%= request.getContextPath() %>/manageVehicles" class="active"><span>Manage Vehicles</span></a></li>
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
          <h2>Vehicle Profile</h2>
          <div class="btn-group">
              <a href="<%= request.getContextPath() %>/manageVehicles" class="btn btn-secondary">Back to Fleet</a>
              <a href="<%= request.getContextPath() %>/editVehicle?id=${vehicle.vehicle_id}" class="btn btn-primary">Edit Details</a>
          </div>
        </div>

        <div class="content-box">
          <div class="vehicle-hero" style="background-image: linear-gradient(to bottom, transparent, rgba(0,0,0,0.3)), url('<%= request.getContextPath() %>/Assets/${vehicle.vehicle_image}');">
             <span class="status-badge">
                <c:out value="${vehicle.vehicle_status}" default="Unknown Status" />
             </span>
          </div>

          <div class="detail-grid">
            <div class="detail-card">
              <span class="label">Brand & Model</span>
              <div class="value"><c:out value="${vehicle.vehicle_brand}" default="N/A" /></div>
            </div>

            <div class="detail-card">
              <span class="label">Vehicle Category</span>
              <div class="value"><c:out value="${vehicle.vehicle_type}" default="N/A" /></div>
            </div>

            <div class="detail-card">
              <span class="label">Exterior Color</span>
              <div class="value" style="text-transform: capitalize;"><c:out value="${vehicle.vehicle_color}" default="N/A" /></div>
            </div>

            <div class="detail-card">
              <span class="label">License Number Plate</span>
              <div class="value"><c:out value="${vehicle.vehicle_numberPlate}" default="N/A" /></div>
            </div>

            <div class="detail-card">
              <span class="label">Mechanical Condition</span>
              <div class="value"><c:out value="${vehicle.vehicle_condition}" default="N/A" /></div>
            </div>

            <div class="detail-card">
              <span class="label">Availability Status</span>
              <div class="value"><c:out value="${vehicle.vehicle_status}" default="N/A" /></div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </body>
</html>