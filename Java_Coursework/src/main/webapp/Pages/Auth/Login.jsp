
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/LoginStyle.css">
    <title>Login</title>
  </head>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <script>
        alert("<%= error %>");
    </script>
<%
    }
%>
  <body style="background-image: url('<%= request.getContextPath() %>/Assets/Background.jpg'); background-size: cover; background-position: center;">
    <div class="main">
      <div class="form-head">
        <h1>Sign in</h1>
        <p>Welcome back - login to continue</p>
      </div>

      <div class="social-row">
        <button class="social-btn">
          <img
            src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/500px-Google_%22G%22_logo.svg.png"
            alt=""
            style="height: 18px; width: 18px"
          />Google
        </button>
        <button class="social-btn">
          <img
            src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/500px-Facebook_Logo_%282019%29.png"
            alt=""
            style="height: 18px; width: 18px"
          />Facebook
        </button>
      </div>

      <div class="or-divider">or</div>

      <form id="loginForm" action="<%= request.getContextPath() %>/login" method="post">
        <div class="field">
          <label>Email</label>
          <div class="field-inner">
            <input
              type="email"
              id="email"
              name="email"
              placeholder="example@gmail.com"
              required
            />
          </div>
        </div>

        <div class="field">
          <label>Password</label>
          <div class="field-inner">
            <input
              type="password"
              id="password"
              name="password"
              placeholder="Password"
              required
            />
            <button type="button" class="eye" onclick="togglePassword()">
              <img
                src="https://cdn.imgbin.com/20/20/22/imgbin-encapsulated-postscript-eye-logo-big-eye-23rJ7fppddM5K0vmdwUDewhiR.jpg"
                alt=""
                style="height: 12px; width: 18px"
              />
            </button>
          </div>
        </div>

        <div class="meta-row">
          <label><input type="checkbox" /> Remember Me</label>
          <a href="<%= request.getContextPath() %>/resetPassword">Forgot Password?</a>
        </div>

        <button type="submit" class="submit-btn">Sign In</button>
      </form>

      <div class="form-foot">
        Don't have a account ? <a href="<%= request.getContextPath() %>/register">Create one</a>
      </div>
    </div>
  </body>
</html>
