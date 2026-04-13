<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="jakarta.tags.core" %> <%@
taglib prefix="sql" uri="jakarta.tags.sql" %> <%-- Database Connection --%>
<sql:setDataSource
  var="dbConnection"
  driver="com.mysql.cj.jdbc.Driver"
  url="jdbc:mysql://localhost:3306/java_coursework"
  user="root"
  password=""
/>

<sql:query var="notifHistory" dataSource="${dbConnection}">
  SELECT * FROM notification ORDER BY notification_date DESC;
</sql:query>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>RentAll | Manage Notifications</title>
    <link
      rel="stylesheet"
      type="text/css"
      href="<%= request.getContextPath() %>/CSS/AdminStyle.css"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <style>
      body {
        font-family: "Poppins", sans-serif;
      }

      /* Form Styling */
      .send-box {
        background: #ffffff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        margin-bottom: 30px;
        border: 1px solid #e2e8f0;
      }
      .form-group {
        margin-bottom: 15px;
      }
      .form-group label {
        display: block;
        font-weight: 600;
        margin-bottom: 8px;
        font-size: 0.9rem;
        color: #1e293b;
      }
      .form-control {
        width: 100%;
        padding: 12px;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        font-family: inherit;
        outline: none;
      }
      .form-control:focus {
        border-color: #3b82f6;
      }
      .btn-send {
        background: #0f172a;
        color: white;
        border: none;
        padding: 12px 24px;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: 0.2s;
      }
      .btn-send:hover {
        background: #334155;
      }

      /* Table Specifics */
      .notif-msg {
        color: #64748b;
        font-size: 0.85rem;
        max-width: 400px;
      }

      /* Delete Button Styling */
      .btn-delete {
        background: #ef4444;
        color: white;
        padding: 6px 12px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 0.8rem;
        font-weight: 600;
        transition: 0.2s;
        display: inline-block;
      }
      .btn-delete:hover {
        background: #dc2626;
        transform: translateY(-1px);
      }
    </style>
  </head>
  <body>
    <aside class="sidebar">
      <h2>RentAll</h2>
      <nav>
        <ul>
          <li>
            <a href="<%= request.getContextPath() %>/admin"
              ><span>Dashboard</span></a
            >
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/manageBooking"
              ><span>Bookings</span></a
            >
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/manageVehicles"
              ><span>Manage Vehicles</span></a
            >
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/manageCustomers"
              ><span>Customers</span></a
            >
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/manageReviews"
              ><span>Reviews</span></a
            >
          </li>
          <li>
            <a
              href="<%= request.getContextPath() %>/manageNotification"
              class="active"
              ><span>Notifications</span></a
            >
          </li>
          <li>
            <a href="<%= request.getContextPath() %>/report"
              ><span>Reports</span></a
            >
          </li>
        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout"
        ><span>Logout</span></a
      >
    </aside>

    <main>
      <div class="page-header" style="margin-bottom: 2rem">
        <h2 style="font-weight: 700; color: #0f172a">Broadcast Notification</h2>
      </div>

      <div class="send-box">
        <form
          action="<%= request.getContextPath() %>/sendNotification"
          method="POST"
        >
          <div class="form-group">
            <label>Subject</label>
            <input
              type="text"
              name="subject"
              class="form-control"
              placeholder="e.g., Weekend Discount!"
              required
            />
          </div>
          <div class="form-group">
            <label>Message Content</label>
            <textarea
              name="message"
              class="form-control"
              rows="3"
              placeholder="Write your message to all users..."
              required
            ></textarea>
          </div>
          <button type="submit" class="btn-send">Send to All Users</button>
        </form>
      </div>

      <div
        class="content-box"
        style="
          background: white;
          border-radius: 12px;
          border: 1px solid #e2e8f0;
          box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1);
        "
      >
        <h3
          style="
            padding: 20px;
            font-size: 1.1rem;
            border-bottom: 1px solid #f1f5f9;
            color: #0f172a;
          "
        >
          Sent History
        </h3>
        <div class="table-responsive">
          <table style="width: 100%; border-collapse: collapse">
            <thead>
              <tr
                style="
                  background: #f8fafc;
                  text-align: left;
                  color: #64748b;
                  font-size: 0.85rem;
                  text-transform: uppercase;
                "
              >
                <th style="padding: 15px">Subject</th>
                <th style="padding: 15px">Message</th>
                <th style="padding: 15px">Date Sent</th>
                <th style="padding: 15px; text-align: center">Action</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="row" items="${notifHistory.rows}">
                <tr style="border-bottom: 1px solid #f1f5f9">
                  <td style="padding: 15px; color: #1e293b">
                    <strong><c:out value="${row.notification_type}" /></strong>
                  </td>
                  <td style="padding: 15px">
                    <div class="notif-msg">
                      <c:out value="${row.notification_description}" />
                    </div>
                  </td>
                  <td style="padding: 15px; font-size: 0.8rem; color: #94a3b8">
                    ${row.notification_date}
                  </td>

                  <td style="padding: 15px; text-align: center">
                    <a
                      href="<%= request.getContextPath() %>/deleteNotification?id=${row.notification_id}"
                      class="btn-delete"
                      onclick="
                        return confirm(
                          'Are you sure you want to delete this notification?',
                        );
                      "
                    >
                      Delete
                    </a>
                  </td>
                </tr>
              </c:forEach>
              <c:if test="${empty notifHistory.rows}">
                <tr>
                  <td
                    colspan="4"
                    style="text-align: center; padding: 30px; color: #94a3b8"
                  >
                    No notifications sent yet.
                  </td>
                </tr>
              </c:if>
            </tbody>
          </table>
        </div>
      </div>
    </main>
  </body>
</html>
