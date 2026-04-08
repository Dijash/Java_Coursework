<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>404 - Page Not Found</title>
    <style>
      body {
        margin: 0;
        padding: 0;
        font-family: Poppins, sans-serif;
        background-color: #f5f6fa;
        color: #2f3640;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
      }
      .container {
        text-align: center;
      }
      h1 {
        font-size: 80px;
        margin: 0;
        color: #e84118;
      }
      h2 {
        font-size: 22px;
        margin: 10px 0;
        font-weight: normal;
      }
      p {
        color: #718093;
        margin-bottom: 25px;
      }
      .btn {
        text-decoration: none;
        padding: 10px 20px;
        background-color: #273c75;
        color: #ffffff;
        border-radius: 4px;
        font-size: 14px;
        transition: background 0.3s ease;
      }
      .btn:hover {
        background-color: #192a56;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>404</h1>
      <h2>Page Not Found</h2>
      <p>The page you are looking for does not exist or has been moved.</p>
      <a href="<%= request.getContextPath() %>/" class="btn">Go to Home</a>
    </div>
  </body>
</html>