<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ taglib prefix="sql" uri="jakarta.tags.sql" %>

      <%-- Database Connection --%>
        <sql:setDataSource var="dbConnection" driver="com.mysql.cj.jdbc.Driver"
          url="jdbc:mysql://localhost:3306/java_coursework" user="root" password="" />

        <%-- Fetch Reviews with Customer Names --%>
          <sql:query var="allReviews" dataSource="${dbConnection}">
            SELECT
            r.review_id,
            c.first_name,
            c.last_name,
            r.review_description,
            r.review_date
            FROM
            review r
            JOIN
            customer c ON r.customer_id = c.customer_id
            ORDER BY
            r.review_date DESC;
          </sql:query>

          <!doctype html>
          <html lang="en">

          <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>RentAll | Reviews</title>
            <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/AdminStyle.css">
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
              rel="stylesheet">
            <style>
              /* Page Specific Overrides to ensure table looks good with Poppins */
              body {
                font-family: "Poppins", sans-serif;
              }

              .review-desc {
                line-height: 1.6;
                color: #475569;
                max-width: 500px;
              }

              .customer-name {
                font-weight: 600;
                color: #0f1011;
                display: block;
              }

              .review-date {
                font-size: 12px;
                color: #64748b;
              }

              .btn-delete {
                color: #ef4444;
                background: #fef2f2;
                border: 1px solid #fee2e2;
                padding: 6px 12px;
                border-radius: 6px;
                cursor: pointer;
                font-family: "Poppins", sans-serif;
                font-weight: 600;
                font-size: 12px;
                transition: 0.2s;
              }

              .btn-delete:hover {
                background: #ef4444;
                color: white;
              }
            </style>
          </head>

          <body>
            <input type="checkbox" id="menu-toggle" style="display:none;" />
            <label for="menu-toggle" class="menu-btn" style="display:none;">MENU</label>

            <%-- Consistent Sidebar --%>
              <aside class="sidebar">
                <h2>RentAll</h2>
                <nav>
                  <ul>
                    <li><a href="<%= request.getContextPath() %>/admin"><span>Dashboard</span></a></li>
                    <li><a href="<%= request.getContextPath() %>/manageBooking"><span>Bookings</span></a></li>
                    <li><a href="<%= request.getContextPath() %>/manageVehicles"><span>Manage Vehicles</span></a></li>
                    <li><a href="<%= request.getContextPath() %>/manageCustomers"><span>Customers</span></a></li>
                    <li><a href="<%= request.getContextPath() %>/manageReviews" class="active"><span>Reviews</span></a>
                    </li>
                    <li><a href="<%= request.getContextPath() %>/manageNotification"><span>Notifications</span></a></li>
                    <li><a href="<%= request.getContextPath() %>/report"><span>Reports</span></a></li>

                  </ul>
                </nav>
                <a href="<%= request.getContextPath() %>/logout" class="logout"><span>Logout</span></a>
              </aside>

              <main>
                <div class="page-header">
                  <h2>Customer Feedback</h2>
                </div>

                <div class="content-box">
                  <div class="table-responsive">
                    <table>
                      <thead>
                        <tr>
                          <th>Customer</th>
                          <th>Comment</th>
                          <th>Date Posted</th>
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <c:forEach var="row" items="${allReviews.rows}">
                          <tr>
                            <td>
                              <span class="customer-name">
                                <c:out value="${row.first_name} ${row.last_name}" />
                              </span>
                              <span class="review-date">ID: #
                                <c:out value="${row.review_id}" />
                              </span>
                            </td>
                            <td>
                              <div class="review-desc">"
                                <c:out value="${row.review_description}" />"
                              </div>
                            </td>
                            <td>
                              <c:out value="${row.review_date}" />
                            </td>
                            <td>
                              <form action="deleteReview" method="POST" style="display:inline;">
                                <input type="hidden" name="reviewId" value="${row.review_id}">
                                <button type="submit" class="btn-delete"
                                  onclick="return confirm('Delete this review?');">
                                  Delete
                                </button>
                              </form>
                            </td>
                          </tr>
                        </c:forEach>

                        <c:if test="${empty allReviews.rows}">
                          <tr>
                            <td colspan="4" style="text-align: center; padding: 40px">
                              No reviews found in the database.
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