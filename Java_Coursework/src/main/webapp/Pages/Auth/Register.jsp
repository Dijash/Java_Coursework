
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/RegisterStyle.css">

  </head>

  <body style="background-image: url('<%= request.getContextPath() %>/Assets/Background.jpg'); background-size: cover; background-position: center;">
    <div class="main">
      <div class="top-bar">
        <div class="form-head">
          <h1>Create Account</h1>
          <p>Fill in the details below to get started</p>
        </div>
        <div class="social-row">
          <button class="social-btn" type="button">
            <img
              src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/500px-Google_%22G%22_logo.svg.png"
              alt=""
              style="height: 16px; width: 16px"
            />Google
          </button>
          <button class="social-btn" type="button">
            <img
              src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/500px-Facebook_Logo_%282019%29.png"
              alt=""
              style="height: 16px; width: 16px"
            />Facebook
          </button>
        </div>
      </div>

      <form id="registerForm" method="post" action="<%= request.getContextPath() %>/register">
        <div class="form-body">
          <div class="form-col">
            <div class="section-label">Personal Information</div>

            <div class="field">
              <label>First Name</label>
              <div class="field-inner">
                <input type="text" id="firstName" placeholder="Ram" name="firstName" required />
              </div>
            </div>

            <div class="field">
              <label>Last Name</label>
              <div class="field-inner">
                <input type="text" id="lastName" placeholder="Bhai" name="lastName" required />
              </div>
            </div>

            <div class="field">
              <label>Date of Birth</label>
              <div class="field-inner">
                <input type="date" id="dob" name="dob" required />
              </div>
            </div>

            <div class="field">
              <label>Gender</label>
              <div class="field-inner">
                <select id="gender" name="gender" required>
                  <option value="" disabled selected>Select</option>
                  <option value="male">Male</option>
                  <option value="female">Female</option>
                  <option value="other">Other</option>
                  <option value="prefer_not">Prefer not to say</option>
                </select>
              </div>
            </div>
          </div>

          <div class="col-divider"></div>

          <div class="form-col">
            <div class="section-label">Contact Details</div>

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
              <label>Phone Number</label>
              <div class="field-inner">
                <input
                  type="tel"
                  id="phone"
                  name="phone"
                  placeholder="+977 9800000000"
                  required
                />
              </div>
            </div>

            <div class="field">
              <label>Address</label>
              <div class="field-inner">
                <input
                  type="text"
                  id="address"
                  name="address"
                  placeholder="Street, City"
                  required
                />
              </div>
            </div>

            <div class="field">
              <label>Country</label>
              <div class="field-inner">
                <select id="country" name="country">
                  <option value="" disabled selected>Select country</option>
                  <option value="np">Nepal</option>
                  <option value="in">India</option>
                  <option value="us">United States</option>
                  <option value="gb">United Kingdom</option>
                  <option value="other">Other</option>
                </select>
              </div>
            </div>
          </div>

          <div class="col-divider"></div>

          <div class="form-col">
            <div class="section-label">Security</div>

            <div class="field">
              <label>Username</label>
              <div class="field-inner">
                <input
                  type="text"
                  id="username"
                  name="username"
                  placeholder="Username"
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
                <button
                  type="button"
                  class="eye"
                  onclick=""
                >
                  <img
                    src="https://static.vecteezy.com/system/resources/thumbnails/014/551/056/small/eye-icon-simple-flat-eye-design-vision-care-concept-wear-glasses-for-a-clear-vision-png.png"
                    alt=""
                    style="height: 16px; width: 16px"
                  />
                </button>
              </div>
            </div>

            <div class="field">
              <label>Confirm Password</label>
              <div class="field-inner">
                <input
                  type="password"
                  id="confirmPassword"
                  name="confirmPassword"
                  placeholder="Confirm Password"
                  required
                />
                <button
                  type="button"
                  class="eye"
                  onclick=""
                >
                  <img
                    src="https://static.vecteezy.com/system/resources/thumbnails/014/551/056/small/eye-icon-simple-flat-eye-design-vision-care-concept-wear-glasses-for-a-clear-vision-png.png"
                    alt=""
                    style="height: 16px; width: 16px"
                  />
                </button>
              </div>
            </div>

            <div class="field">
              <label
                >Referral Code
                <span style="color: var(--muted); font-weight: 400"
                  >(optional)</span
                ></label
              >
              <div class="field-inner">
                <input type="text" id="referral" placeholder="Referral Code" name="referral" />
              </div>
            </div>
          </div>
        </div>

        <div class="bottom-bar">
          <div class="form-foot">
            Already have an account? <a href="<%= request.getContextPath() %>/login">Sign in</a>
          </div>
          <button type="submit" class="submit-btn">Create Account</button>
        </div>
      </form>
    </div>

  </body>
</html>
