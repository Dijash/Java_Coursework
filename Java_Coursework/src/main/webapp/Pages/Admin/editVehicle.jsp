<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Edit Vehicle</title>
    <style>
      :root {
        --primary: #0f1011;
        --primary-hover: #273f4b;
        --accent: #c0392b;
        --bg-light: #f4f7f9;
        --text-dark: #1e293b;
        --text-muted: #64748b;
        --white: #ffffff;
        --shadow-sm: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
        --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.05), 0 10px 10px -5px rgba(0, 0, 0, 0.02);
        --radius: 16px;
        --sidebar-width: 260px;
      }

      * { margin: 0; padding: 0; box-sizing: border-box; }
      body { font-family: "Poppins", sans-serif; background: var(--bg-light); color: var(--text-dark); display: flex; min-height: 100vh; overflow-x: hidden; }

      .sidebar { width: var(--sidebar-width); background: var(--primary); color: white; padding: 30px 20px; display: flex; flex-direction: column; position: fixed; height: 100vh; z-index: 1000; }
      .sidebar h2 { font-size: 1.6rem; margin-bottom: 2.5rem; text-align: center; font-weight: 700; letter-spacing: -0.5px; }
      .sidebar h2 span { color: #3498db; }
      .sidebar nav { flex: 1; }
      .sidebar ul { list-style: none; }
      .sidebar a { text-decoration: none; color: #ffffff; padding: 14px 18px; margin-bottom: 6px; display: flex; align-items: center; border-radius: 12px; font-size: 0.95rem; transition: all 0.2s ease; }
      .sidebar a:hover, .sidebar a.active { background: rgba(255, 255, 255, 0.1); transform: translateX(5px); }
      .sidebar a.active { background: var(--primary-hover); box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); }
      .logout { background: var(--accent) !important; justify-content: center; font-weight: 600; margin-top: auto; }

      main { flex: 1; margin-left: var(--sidebar-width); padding: 50px 40px; display: flex; flex-direction: column; align-items: center; }
      .page-header { width: 100%; max-width: 850px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
      .page-header h2 { font-size: 1.8rem; font-weight: 700; color: var(--text-dark); letter-spacing: -0.5px; }

      .content-box { background: var(--white); padding: 40px 50px; border-radius: var(--radius); box-shadow: var(--shadow-lg); width: 100%; max-width: 850px; border: 1px solid rgba(226, 232, 240, 0.8); }

      .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 28px; }
      .form-group { margin-bottom: 8px; }
      .form-group.full-width { grid-column: 1 / -1; margin-top: 10px; }
      .form-group label { display: block; margin-bottom: 10px; font-weight: 600; font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.8px; }

      .form-control { width: 100%; padding: 14px 18px; border: 2px solid #e2e8f0; border-radius: 10px; font-size: 0.95rem; font-weight: 500; color: var(--text-dark); outline: none; transition: all 0.3s ease; background-color: #f8fafc; }
      .form-control:hover { border-color: #cbd5e1; }
      .form-control:focus { border-color: #3498db; background-color: #ffffff; box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.15); }
      select.form-control { cursor: pointer; appearance: none; background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%2364748b' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e"); background-repeat: no-repeat; background-position: right 1.2rem center; background-size: 1.2em; }

      .btn-primary {
        background: #0f1011;
        color: white;
        padding: 16px 24px;
        border-radius: 10px;
        font-size: 1rem;
        font-weight: 600;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
        width: 100%;
        box-shadow: 0 4px 6px rgba(15, 16, 17, 0.2);
      }

      .btn-primary:hover {
        background: #273f4b;
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(39, 63, 75, 0.3);
      }

      .btn-primary:active { transform: translateY(0); }
      .btn-secondary { background: #f1f5f9; color: var(--text-dark); padding: 10px 22px; border-radius: 8px; text-decoration: none; font-size: 0.9rem; font-weight: 600; transition: all 0.2s ease; border: 1px solid #e2e8f0; }
      .btn-secondary:hover { background: #e2e8f0; color: #0f1011; }
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
        <h2>Edit Vehicle</h2>
        <a href="<%= request.getContextPath() %>/manageVehicles" class="btn-secondary">Cancel</a>
      </div>

      <div class="content-box">
        <form action="<%= request.getContextPath() %>/updateVehicle" method="POST" enctype="multipart/form-data">

          <input type="hidden" name="vehicle_id" value="${vehicle.vehicle_id}">
          <input type="hidden" name="existing_image" value="${vehicle.vehicle_image}">

          <div class="form-grid">
            <div class="form-group">
              <label for="vehicle_brand">Vehicle Brand & Model</label>
              <input type="text" id="vehicle_brand" name="vehicle_brand" class="form-control" value="<c:out value='${vehicle.vehicle_brand}'/>" required>
            </div>

            <div class="form-group">
              <label for="vehicle_type">Vehicle Type / Category</label>
              <select id="vehicle_type" name="vehicle_type" class="form-control" required>
                <option value="SUV" ${vehicle.vehicle_type == 'SUV' ? 'selected' : ''}>SUV</option>
                <option value="Sedan" ${vehicle.vehicle_type == 'Sedan' ? 'selected' : ''}>Sedan</option>
                <option value="Hatchback" ${vehicle.vehicle_type == 'Hatchback' ? 'selected' : ''}>Hatchback</option>
                <option value="Two-Wheeler" ${vehicle.vehicle_type == 'Two-Wheeler' ? 'selected' : ''}>Two-Wheeler</option>
                <option value="Electric" ${vehicle.vehicle_type == 'Electric' ? 'selected' : ''}>Electric (EV)</option>
                <option value="Luxury" ${vehicle.vehicle_type == 'Luxury' ? 'selected' : ''}>Luxury / Premium</option>
              </select>
            </div>

            <div class="form-group">
              <label for="vehicle_color">Vehicle Color</label>
              <input type="text" id="vehicle_color" name="vehicle_color" class="form-control" value="<c:out value='${vehicle.vehicle_color}'/>" required>
            </div>

            <div class="form-group">
              <label for="vehicle_numberPlate">Number Plate</label>
              <input type="text" id="vehicle_numberPlate" name="vehicle_numberPlate" class="form-control" value="<c:out value='${vehicle.vehicle_numberPlate}'/>" required>
            </div>

            <div class="form-group">
              <label for="vehicle_condition">Vehicle Condition</label>
              <select id="vehicle_condition" name="vehicle_condition" class="form-control" required>
                <option value="Excellent" ${vehicle.vehicle_condition == 'Excellent' ? 'selected' : ''}>Excellent</option>
                <option value="Good" ${vehicle.vehicle_condition == 'Good' ? 'selected' : ''}>Good</option>
                <option value="Fair" ${vehicle.vehicle_condition == 'Fair' ? 'selected' : ''}>Fair</option>
                <option value="Needs Servicing" ${vehicle.vehicle_condition == 'Needs Servicing' ? 'selected' : ''}>Needs Servicing</option>
              </select>
            </div>

            <div class="form-group">
              <label for="vehicle_status">Current Status</label>
              <select id="vehicle_status" name="vehicle_status" class="form-control" required>
                <option value="Available" ${vehicle.vehicle_status == 'Available' ? 'selected' : ''}>Available</option>
                <option value="Maintenance" ${vehicle.vehicle_status == 'Maintenance' ? 'selected' : ''}>Maintenance</option>
              </select>
            </div>

            <div class="form-group full-width">
              <label for="vehicle_image">Update Vehicle Photo (Optional)</label>
              <input type="file" id="vehicle_image" name="vehicle_image" class="form-control" accept="image/png, image/jpeg, image/jpg" style="padding: 10px 16px; cursor: pointer;">
              <small style="color: var(--text-muted); display: block; margin-top: 6px;">Accepted formats: JPG, PNG. Max size: 10MB. Leave blank to keep current photo.</small>
            </div>
          </div>

          <div class="form-group full-width">
            <button type="submit" class="btn-primary">Update Details</button>
          </div>

        </form>
      </div>
    </main>
  </body>
</html>