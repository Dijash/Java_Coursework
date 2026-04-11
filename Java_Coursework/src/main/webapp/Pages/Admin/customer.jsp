<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll | Customers</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/AdminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
      /* Page-specific overrides to match the professional table look */
      body { font-family: "Poppins", sans-serif; }

      .search-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
      }

      .search-bar {
        padding: 12px 18px;
        width: 320px;
        border-radius: 10px;
        border: 1px solid #e2e8f0;
        outline: none;
        font-family: inherit;
        background-color: #ffffff;
        box-shadow: 0 2px 5px rgba(0,0,0,0.02);
      }

      .user-details strong { display: block; color: #1e293b; font-weight: 600; }
      .user-details span { font-size: 13px; color: #64748b; }

      .action-btn {
        text-decoration: none;
        background-color: #f1f5f9;
        color: #0f172a;
        padding: 8px 16px;
        border-radius: 8px;
        font-size: 13px;
        font-weight: 600;
        transition: 0.2s;
        border: 1px solid #e2e8f0;
      }

      .action-btn:hover {
        background-color: #0f172a;
        color: #ffffff;
      }

      /* Custom status indicator for Country column */
      .country-text {
        font-weight: 500;
        color: #334155;
      }
      .not-provided {
        color: #94a3b8;
        font-style: italic;
        font-size: 0.85rem;
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
          <li><a href="<%= request.getContextPath() %>/manageVehicles"><span>Manage Vehicles</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageCustomers" class="active"><span>Customers</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageReviews"><span>Reviews</span></a></li>
          <li><a href="<%= request.getContextPath() %>/manageNotification"><span>Notifications</span></a></li>
          <li><a href="<%= request.getContextPath() %>/report"><span>Reports</span></a></li>
        </ul>
      </nav>
      <a href="<%= request.getContextPath() %>/logout" class="logout"><span>Logout</span></a>
    </aside>

    <main>
      <div class="search-container">
        <h2 style="font-weight: 700; color: #0f172a;">Customer Database</h2>
        <input type="text" class="search-bar" placeholder="Search customers..." />
      </div>

      <div class="content-box">
        <div class="table-responsive">
          <table>
            <thead>
              <tr>
                <th>Customer</th>
                <th>Phone Number</th>
                <th>Country</th>
                <th>Member Since</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="customer" items="${customers}">
                <tr>
                  <td>
                    <div class="user-details">
                      <strong><c:out value="${customer.fullName}" /></strong>
                      <span><c:out value="${customer.customer_email}" /></span>
                    </div>
                  </td>
                  <td><c:out value="${customer.customer_phoneNo}" /></td>
                  <td>
                    <c:choose>
                      <c:when test="${not empty customer.customer_country}">
                        <span class="country-text"><c:out value="${customer.customer_country}" /></span>
                      </c:when>
                      <c:otherwise>
                        <span class="not-provided">Not Provided</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td style="color: #64748b;"><c:out value="${customer.created_at}" /></td>
                  <td>
                    <a href="<%= request.getContextPath() %>/viewCustomer?id=${customer.customer_id}"
                       class="action-btn">View Profile</a>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty customers}">
                <tr>
                  <td colspan="5" style="text-align: center; padding: 50px; color: #94a3b8;">
                    No customer records found in the database.
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