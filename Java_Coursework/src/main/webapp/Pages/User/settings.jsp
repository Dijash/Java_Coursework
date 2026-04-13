<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

<%-- Database Connection --%>
<sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/java_coursework"
                   user="root" password=""/>

<%-- Fetch Total Notification Count --%>
<sql:query var="totalNotification" dataSource="${dbConnection}">
  SELECT COUNT(*) as count FROM notification;
</sql:query>

<%-- Fetch Recent Notifications --%>
<sql:query var="recentNotifications" dataSource="${dbConnection}">
  SELECT notification_type, notification_description, notification_date
  FROM notification ORDER BY notification_date DESC LIMIT 5;
</sql:query>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Profile Settings</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <style>
      :root {
        --primary: #0f172a;
        --sidebar-active: #334155;
        --accent: #3b82f6;
        --bg-main: #f8fafc;
        --card-bg: #ffffff;
        --text-main: #1e293b;
        --text-muted: #64748b;
        --border: #e2e8f0;
        --radius-lg: 12px;
        --radius-md: 8px;
        --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
      }

      * { margin: 0; padding: 0; box-sizing: border-box; }
      body { font-family: "Poppins", sans-serif; background-color: var(--bg-main); display: flex; min-height: 100vh; }

      /* Sidebar */
      .sidebar { width: 260px; background: var(--primary); color: white; padding: 2rem 1.5rem; position: fixed; height: 100vh; display: flex; flex-direction: column; }
      .sidebar h2 { font-size: 1.5rem; font-weight: 700; margin-bottom: 2.5rem; }
      .sidebar nav a { text-decoration: none; color: #94a3b8; padding: 0.8rem 1rem; display: flex; border-radius: var(--radius-md); margin-bottom: 0.5rem; font-weight: 500; transition: 0.3s; }
      .sidebar nav a:hover,
            .sidebar nav a.active {
              background: var(--sidebar-active);
              color: white;
            }
      .logout { margin-top: auto; background: #ef4444; color: white !important; text-align: center; justify-content: center; padding: 0.8rem; border-radius: var(--radius-md); text-decoration: none; }

      /* Main Area */
      main { flex: 1; margin-left: 260px; }
      .top-navbar { display: flex; justify-content: space-between; align-items: center; padding: 1.5rem 2.5rem; background: var(--bg-main); border-bottom: 1px solid var(--border); }

      /* Profile Layout */
      .dashboard-content { padding: 2.5rem; max-width: 900px; }
      .profile-card { background: var(--card-bg); border-radius: var(--radius-lg); border: 1px solid var(--border); box-shadow: var(--shadow); overflow: hidden; }
      .profile-header { background: var(--primary); color: white; padding: 2rem; }
      .profile-header h2 { font-size: 1.5rem; }
      .profile-header p { opacity: 0.8; font-size: 0.9rem; }

      .profile-body { padding: 2rem; display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; }
      .form-group { margin-bottom: 1.5rem; }
      label { display: block; font-size: 0.85rem; font-weight: 600; color: var(--text-muted); margin-bottom: 0.5rem; text-transform: uppercase; }
      .info-box { background: var(--bg-main); padding: 0.75rem 1rem; border-radius: var(--radius-sm); border: 1px solid var(--border); color: var(--text-main); font-weight: 500; font-size: 0.95rem; }

      .license-tag { display: inline-block; background: #e0f2fe; color: #0369a1; padding: 0.25rem 0.75rem; border-radius: 4px; font-family: monospace; font-weight: 700; }

      .full-width { grid-column: span 2; }
      .section-title { grid-column: span 2; border-bottom: 1px solid var(--border); padding-bottom: 0.5rem; margin-top: 1rem; color: var(--primary); font-weight: 700; }

      /* Notification Dropdown (Copied from Dashboard) */
      .dropdown-wrapper { position: relative; }
      .btn-notif { background: var(--card-bg); border: 1px solid var(--border); padding: 0.6rem 1.2rem; border-radius: var(--radius-md); font-weight: 600; cursor: pointer; display: flex; gap: 0.5rem; }
      .notif-badge { background: #ef4444; color: white; padding: 2px 6px; border-radius: 4px; font-size: 0.75rem; }
      .notif-dropdown { position: absolute; top: 110%; right: 0; width: 300px; background: white; border: 1px solid var(--border); box-shadow: var(--shadow); display: none; z-index: 100; border-radius: var(--radius-md); }
      .notif-dropdown.show { display: block; }
      .notif-item { padding: 1rem; border-bottom: 1px solid var(--border); font-size: 0.8rem; }
      .save-btn {
              text-decoration: none; background: var(--primary); color: white;
              padding: 0.6rem 1.2rem; border-radius: var(--radius-md);
              font-weight: 600; font-size: 0.85rem; transition: 0.3s;
              box-shadow: var(--shadow);
            }
            .save-btn:hover { background: var(--sidebar-active); transform: translateY(-1px); }
    </style>
  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <a href="<%= request.getContextPath() %>/userDashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/myBookings">My Bookings</a>
        <a href="<%= request.getContextPath() %>/settings" class="active">Settings</a>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout">Logout</a>
    </aside>

    <main>
      <header class="top-navbar">
        <div class="welcome-text">
          <h1>Account Settings</h1>
          <p>Manage your personal information.</p>
        </div>
        <div class="user-actions" style="display:flex; gap:1rem; align-items:center;">
          <a href="<%= request.getContextPath() %>/home" style="text-decoration:none; color:var(--text-main); font-weight:600; font-size:0.9rem;">Return to Home</a>
          <div class="dropdown-wrapper">
            <button class="btn-notif" id="notifBtn">Notifications <span class="notif-badge">${totalNotification.rows[0].count}</span></button>
            <div class="notif-dropdown" id="notifMenu">
              <c:forEach var="n" items="${recentNotifications.rows}">
                <div class="notif-item"><strong>${n.notification_type}</strong><br>${n.notification_description}</div>
              </c:forEach>
            </div>
          </div>
        </div>
      </header>

      <div class="dashboard-content">
        <c:if test="${param.success == 'true'}">
          <div style="background:#dcfce7; color:#166534; padding:1rem; border-radius:8px; margin-bottom:1rem;">
            Profile updated successfully!
          </div>
        </c:if>

        <form action="<%= request.getContextPath() %>/updateProfile" method="POST" class="profile-card">
          <div class="profile-header">
            <h2>Edit Profile</h2>
            <p>Update your credentials and documentation.</p>
          </div>

          <div class="profile-body">
            <h3 class="section-title">Account Credentials</h3>
            <div class="form-group">
              <label>Username</label>
              <input type="text" name="username" class="info-box" value="${sessionScope.user.customer_username}" required>
            </div>
            <div class="form-group">
              <label>New Password (Leave blank to keep current)</label>
              <input type="password" name="password" class="info-box" placeholder="********">
            </div>

            <h3 class="section-title">Legal & Contact</h3>
            <div class="form-group">
              <label>Driver's License Number</label>
              <input type="text" name="license" class="info-box" value="${sessionScope.user.customer_license}" required>
            </div>
            <div class="form-group">
              <label>Phone Number</label>
              <input type="text" name="phone" class="info-box" value="${sessionScope.user.customer_phoneNo}" required>
            </div>

            <h3 class="section-title">Location</h3>
            <div class="form-group full-width">
              <label>Residential Address</label>
              <input type="text" name="address" class="info-box" value="${sessionScope.user.customer_address}" required>
            </div>

            <div class="full-width" style="margin-top:1rem;">
              <button type="submit" class="save-btn">
                Save Changes
              </button>
            </div>
          </div>
        </form>
      </div>
    </main>

    <script>
      const btn = document.getElementById('notifBtn');
      const menu = document.getElementById('notifMenu');
      btn.addEventListener('click', (e) => { e.stopPropagation(); menu.classList.toggle('show'); });
      window.addEventListener('click', () => menu.classList.remove('show'));
    </script>
  </body>
</html>