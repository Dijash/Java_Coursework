<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/java_coursework"
                   user="root" password=""/>

<sql:query var="allVehicles" dataSource="${dbConnection}">
    SELECT
        vehicle_id, vehicle_brand, vehicle_type, vehicle_color,
        vehicle_numberPlate, vehicle_condition, vehicle_status,
        vehicle_image FROM vehicle ORDER BY vehicle_id DESC;
</sql:query>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Manage Vehicles</title>
    <style>
      :root {
        --primary: #0f1011;
        --primary-hover: #273f4b;
        --accent: #c0392b;
        --bg-light: #f4f7f9;
        --text-dark: #1e293b;
        --text-muted: #64748b;
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

      main {
        flex: 1;
        margin-left: var(--sidebar-width);
        padding: 40px;
        max-width: 100%;
      }
      .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
      }
      .btn-primary {
        background: var(--primary);
        color: white;
        padding: 10px 20px;
        border-radius: 8px;
        text-decoration: none;
        font-size: 0.9rem;
        font-weight: 600;
        transition: 0.2s;
        border: none;
        cursor: pointer;
      }

      .content-box {
        background: var(--white);
        padding: 28px;
        border-radius: var(--radius);
        box-shadow: var(--shadow);
      }

      /* --- FIXED TABLE CSS START --- */
      .table-responsive {
        overflow-x: auto;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        min-width: 900px; /* Slightly wider to accommodate everything */
      }
      table th {
        background: #f8fafc;
        color: var(--text-muted);
        font-weight: 600;
        text-transform: uppercase;
        font-size: 11px;
        letter-spacing: 0.5px;
        padding: 16px;
        text-align: left;
        border-bottom: 2px solid #e2e8f0; /* Stronger header border */
      }
      table td {
        padding: 16px;
        border-bottom: 1px solid #f1f5f9;
        font-size: 14px;
        vertical-align: middle;
        color: #334155;
      }
      table tr:hover td {
        background: #fdfdfd;
      }

      /* Prevent the image and action columns from squishing */
      table th:first-child, table td:first-child { width: 100px; }
      table th:last-child, table td:last-child { width: 220px; white-space: nowrap; }

      .vehicle-thumb {
        width: 80px;
        height: 50px;
        border-radius: 6px;
        background-color: #e2e8f0;
        display: inline-block;
        background-size: cover;
        background-position: center;
        box-shadow: inset 0 0 0 1px rgba(0,0,0,0.1); /* Nice inner border for photos */
      }
      /* --- FIXED TABLE CSS END --- */

      /* --- ACTION BUTTON CSS START --- */
      .action-buttons {
        display: flex;
        gap: 8px;
        align-items: center;
      }

      .action-btn {
        border: none;
        padding: 0 16px;
        height: 34px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        transition: all 0.2s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-family: inherit;
        box-sizing: border-box;
      }

      .action-btn:active { transform: scale(0.95); }
      .action-btn-view { background-color: #e1f0fa; color: #2980b9; }
      .action-btn-view:hover { background-color: #3498db; color: white; box-shadow: 0 4px 10px rgba(52, 152, 219, 0.3); }
      .action-btn-edit { background-color: #fdf3e1; color: #d68910; }
      .action-btn-edit:hover { background-color: #f39c12; color: white; box-shadow: 0 4px 10px rgba(243, 156, 18, 0.3); }
      .action-btn-delete { background-color: #fceceb; color: #c0392b; }
      .action-btn-delete:hover { background-color: #e74c3c; color: white; box-shadow: 0 4px 10px rgba(231, 76, 60, 0.3); }
      /* --- ACTION BUTTON CSS END --- */

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
        <h2>Fleet Management</h2>
       <a href="<%= request.getContextPath() %>/addVehicle" class="btn-primary">+ Add Vehicle</a>
      </div>

      <div class="content-box">
        <div class="table-responsive">
          <table>
            <thead>
              <tr>
                <th>Image</th>
                <th>Brand</th>
                <th>Type</th>
                <th>Color</th>
                <th>Number Plate</th>
                <th>Condition</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="car" items="${allVehicles.rows}">
                <tr>
                  <td>
                    <div class="vehicle-thumb" style="background-image: url('<%= request.getContextPath() %>/Assets/${car.vehicle_image}')"></div>
                  </td>
                  <td><strong><c:out value="${car.vehicle_brand}" /></strong></td>
                  <td><c:out value="${car.vehicle_type}" /></td>
                  <td style="text-transform: capitalize;"><c:out value="${car.vehicle_color}" /></td>
                  <td><c:out value="${car.vehicle_numberPlate}" /></td>
                  <td><c:out value="${car.vehicle_condition}" /></td>

                  <td style="font-weight: 600; color:
                      <c:choose>
                          <c:when test="${car.vehicle_status == 'Available'}">#27ae60</c:when>
                          <c:when test="${car.vehicle_status == 'Maintenance'}">#f39c12</c:when>
                          <c:otherwise>#e74c3c</c:otherwise>
                      </c:choose>;">
                      <c:out value="${car.vehicle_status}" />
                  </td>

                  <td>
                    <div class="action-buttons">
                        <a href="<%= request.getContextPath() %>/viewVehicle?id=${car.vehicle_id}" class="action-btn action-btn-view">View</a>

                        <a href="<%= request.getContextPath() %>/editVehicle?id=${car.vehicle_id}" class="action-btn action-btn-edit">Edit</a>

                        <form action="<%= request.getContextPath() %>/deleteVehicle" method="POST" style="display: contents;">
                            <input type="hidden" name="vehicle_id" value="${car.vehicle_id}">
                            <button type="submit" class="action-btn action-btn-delete" onclick="return confirm('Are you sure you want to delete this vehicle?');">Delete</button>
                        </form>
                    </div>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty allVehicles.rows}">
                 <tr>
                    <td colspan="8" style="text-align: center; color: #7f8c8d; padding: 40px;">No vehicles found in the fleet.</td>
                 </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </body>
</html>