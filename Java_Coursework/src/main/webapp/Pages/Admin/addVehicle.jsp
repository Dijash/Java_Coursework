<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Add Vehicle</title>
    <style>
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
        font-family: "Poppins", sans-serif;
        background: var(--bg-light);
        color: var(--text-dark);
        display: flex;
        min-height: 100vh;
        overflow-x: hidden;
      }

      /* Sidebar Styles */
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

      /* Main Content Styles */
      main {
        flex: 1;
        margin-left: var(--sidebar-width);
        padding: 40px;
        max-width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
      }
      .page-header {
        width: 100%;
        max-width: 800px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
      }

      .content-box {
        background: var(--white);
        padding: 32px 40px;
        border-radius: var(--radius);
        box-shadow: var(--shadow);
        width: 100%;
        max-width: 800px;
      }

      /* Form Styles */
      .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
      }
      .form-group {
        margin-bottom: 20px;
      }
      .form-group.full-width {
        grid-column: 1 / -1;
      }
      .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        font-size: 13px;
        color: var(--text-dark);
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }
      .form-control {
        width: 100%;
        padding: 14px 16px;
        border: 1px solid #cbd5e1;
        border-radius: 8px;
        font-size: 14px;
        color: var(--text-dark);
        outline: none;
        transition: 0.2s;
        background-color: #f8fafc;
      }
      .form-control:focus {
        border-color: #3498db;
        background-color: #ffffff;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.15);
      }
      select.form-control {
        cursor: pointer;

      }

      .btn-primary {
        background: #0f1011;
        color: white;
        padding: 14px 24px;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        transition: 0.2s;
        border: none;
        cursor: pointer;
        width: 100%;
        margin-top: 10px;
      }
      .btn-primary:hover {
        background: #273f4b;
        transform: translateY(-2px);
      }
      .btn-secondary {
        background: #0f1011;
        color: var(--white);
        padding: 10px 20px;
        border-radius: 8px;
        text-decoration: none;
        font-size: 0.9rem;
        font-weight: 600;
        transition: 0.2s;
      }
      .btn-secondary:hover {
        background: #273f4b;
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
          <li><a href="<%= request.getContextPath() %>/manageNotification"><span>Notifications</span></a></li>
          <li><a href="<%= request.getContextPath() %>/report"><span>Reports</span></a></li>

        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout"><span>Logout</span></a>
    </aside>

    <main>
      <div class="page-header">
        <h2>Add New Vehicle</h2>
        <a href="<%= request.getContextPath() %>/manageVehicles" class="btn-secondary">Back to Fleet</a>
      </div>

      <div class="content-box">
        <form action="<%= request.getContextPath() %>/addVehicleData" method="POST" enctype="multipart/form-data">

          <div class="form-grid">
            <div class="form-group">
              <label for="vehicle_brand">Vehicle Brand & Model</label>
              <input type="text" id="vehicle_brand" name="vehicle_brand" class="form-control" placeholder="e.g. Alto 800" required>
            </div>

            <div class="form-group">
              <label for="vehicle_type">Vehicle Type / Category</label>
              <select id="vehicle_type" name="vehicle_type" class="form-control" required>
                <option value="" disabled selected>Select Category</option>
                <option value="SUV">SUV</option>
                <option value="Sedan">Sedan</option>
                <option value="Hatchback">Hatchback</option>
                <option value="Two-Wheeler">Two-Wheeler</option>
                <option value="Electric">Electric (EV)</option>
                <option value="Luxury">Luxury / Premium</option>
              </select>
            </div>

            <div class="form-group">
              <label for="vehicle_color">Vehicle Color</label>
              <input type="text" id="vehicle_color" name="vehicle_color" class="form-control" placeholder="e.g. Matte Black" required>
            </div>

            <div class="form-group">
              <label for="vehicle_numberPlate">Number Plate</label>
              <input type="text" id="vehicle_numberPlate" name="vehicle_numberPlate" class="form-control" placeholder=" Bagmati 01-001-Pa 1234" required>
            </div>

            <div class="form-group">
              <label for="vehicle_condition">Vehicle Condition</label>
              <select id="vehicle_condition" name="vehicle_condition" class="form-control" required>
                <option value="Excellent">Excellent</option>
                <option value="Good">Good</option>
                <option value="Fair">Fair</option>
                <option value="Needs Servicing">Needs Servicing</option>
              </select>
            </div>

            <div class="form-group">
              <label for="vehicle_status">Initial Status</label>
              <select id="vehicle_status" name="vehicle_status" class="form-control" required>
                <option value="Available">Available</option>
                <option value="Maintenance">Maintenance</option>
              </select>
            </div>

            <div class="form-group full-width">
              <label for="vehicle_image">Vehicle Photo</label>
              <input type="file" id="vehicle_image" name="vehicle_image" class="form-control" accept="image/png, image/jpeg, image/jpg" style="padding: 10px 16px; cursor: pointer;">
              <small style="color: var(--text-muted); display: block; margin-top: 6px;">Accepted formats: JPG, PNG. Max size: 10MB. (Optional: defaults to standard image if left blank).</small>
            </div>
          </div>

          <div class="form-group full-width" style="margin-top: 20px;">
            <button type="submit" class="btn-primary">Save Vehicle to Fleet</button>
          </div>

        </form>
      </div>
    </main>
  </body>
</html>