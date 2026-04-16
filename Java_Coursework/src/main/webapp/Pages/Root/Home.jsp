<%@ page session="true" %>
<%
    String sessionEmail = (String) session.getAttribute("email");
    String sessionRole  = (String) session.getAttribute("role");
    boolean isLoggedIn  = (sessionEmail != null);
    boolean isAdmin     = "admin".equals(sessionRole);
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll - Car Rental</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/HomeStyle.css">

  </head>
  <body>

    <header>
      <nav>
        <div class="nav_header">
          <div class="nav_logo">
            <a href="#" class="logo"><span>RentAll</span></a>
          </div>
          <div class="nav_menu_btn" id="menu-btn">
            <i class="ri-menu-line"></i>
          </div>
        </div>
        <ul class="nav_links" id="nav-links">
          <li><a href="#about">Services</a></li>
          <li><a href="#deals">Rental Deals</a></li>
          <li><a href="#choose">About</a></li>
          <li><a href="#client">Contact Us</a></li>
        </ul>
        <div class="nav_btns">
          <% if (isLoggedIn) { %>
            <div class="user_avatar_wrap" id="userAvatarWrap" onclick="toggleUserDropdown()" style="position:relative;display:flex;align-items:center;gap:0.6rem;cursor:pointer;">

              <div class="user_avatar">
                <%= sessionEmail.substring(0, 1).toUpperCase() %>
              </div>

              <span class="user_name_nav"><%= sessionEmail.split("@")[0] %></span>
              <i class="ri-arrow-down-s-line" style="color:#64748b;font-size:1rem;"></i>

              <%-- Dropdown menu --%>
              <div class="user_dropdown" id="userDropdown">
                <div class="dropdown_header">
                  <p><%= sessionEmail.split("@")[0] %></p>
                  <span><%= sessionEmail %></span>
                </div>

                <% if (isAdmin) { %>
                  <a href="<%= request.getContextPath() %>/admin" class="dropdown_item">
                    <i class="ri-shield-user-line"></i> Admin Panel
                  </a>
                <% } %>

                <a href="<%= request.getContextPath() %>/userDashboard" class="dropdown_item">
                  <i class="ri-dashboard-line"></i> Dashboard
                </a>

                <a href="<%= request.getContextPath() %>/settings" class="dropdown_item">
                  <i class="ri-user-line"></i> My Profile
                </a>

                <a href="<%= request.getContextPath() %>/myBookings" class="dropdown_item">
                  <i class="ri-car-line"></i> My Bookings
                </a>

                <form action="<%= request.getContextPath() %>/logout" method="post" style="margin:0;">
                  <button type="submit" class="dropdown_item danger">
                    <i class="ri-logout-box-r-line"></i> Log Out
                  </button>
                </form>
              </div>
            </div>

          <% } else { %>

            <%-- ===== GUEST STATE ===== --%>
            <a href="<%= request.getContextPath() %>/login"    class="btn btn--outline">Login</a>
            <a href="<%= request.getContextPath() %>/register" class="btn">Register</a>

          <% } %>
        </div>
      </nav>

      <div class="header_container" id="home">
        <div class="header_image">
          <img src="Assets/header.png" alt="Luxury car rental" />
        </div>
        <div class="header_content">

          <h1>Fast and Easy Way to Rent a Car</h1>
          <p class="section_description">
            Discover a seamless car rental experience with us. Choose from a
            range of premium vehicles to suit your style and needs, and hit the
            road with confidence. Quick, easy, and reliable — rent your ride today!
          </p>

        </div>
      </div>
    </header>

    <!-- ========== SEARCH FORM ========== -->
    <section class="header_form">
      <form action="/">
        <div class="input_group">
          <label for="location">
            <i class="ri-map-pin-line"></i> Pick up Return location
          </label>
          <div class="input_icon">
            <select id="location">
              <option value="">Select a location</option>
              <option value="Kathmandu">Kathmandu</option>
              <option value="Lalitpur">Lalitpur</option>
              <option value="Bhaktapur">Bhaktapur</option>
              <option value="Pokhara">Pokhara</option>
              <option value="Chitwan">Chitwan</option>
            </select>
            <i class="ri-arrow-down-s-line input_arrow"></i>
          </div>
        </div>

        <div class="input_group date-group">
          <label for="start">
            <i class="ri-calendar-line"></i> Pick up date
          </label>
          <div class="input_icon">
            <input type="date" id="start" />
          </div>
        </div>

        <div class="input_group date-group">
          <label for="stop">
            <i class="ri-calendar-line"></i> Return date
          </label>
          <div class="input_icon">
            <input type="date" id="stop" />
          </div>
        </div>

        <button type="submit" class="btn btn--search">
          <i class="ri-search-line"></i> Search
        </button>
      </form>
    </section>

    <!-- ========== HOW IT WORKS ========== -->
    <section class="section_container about_container" id="about">
      <h2 class="section_header">How it works</h2>
      <p class="section_description">
        Renting a car with us is simple! Choose your vehicle, pick your dates,
        and complete your booking. We'll handle the rest, ensuring a smooth
        start to your journey.
      </p>
      <div class="about_grid">
        <div class="about_card">
          <div class="about_icon">
            <i class="ri-map-pin-2-line"></i>
          </div>
          <h4>Choose Location</h4>
          <p>Select from a variety of pick-up locations that best suit your needs.</p>
        </div>
        <div class="about_card">
          <div class="about_icon">
            <i class="ri-calendar-check-line"></i>
          </div>
          <h4>Pick-up Date</h4>
          <p>Choose the exact date and time for your car pick-up.</p>
        </div>
        <div class="about_card">
          <div class="about_icon">
            <i class="ri-car-line"></i>
          </div>
          <h4>Book your Car</h4>
          <p>Complete your booking with just a few clicks.</p>
        </div>
      </div>
    </section>

    <!-- ========== DEALS / TABS ========== -->
    <section class="deals" id="deals">
      <div class="section_container deals_container">
        <h2 class="section_header">Most popular car rental deals</h2>
        <p class="section_description">
          Explore our top car rental deals, handpicked to give you the best value.
        </p>

        <div class="deals_tabs_wrapper">

          <!-- Hidden radio inputs -->
          <input type="radio" name="deal" id="tab-corolla" hidden checked />
          <input type="radio" name="deal" id="tab-noah" hidden />
          <input type="radio" name="deal" id="tab-pajero" hidden />
          <input type="radio" name="deal" id="tab-swift" hidden />

          <!-- Tab Labels -->
          <div class="deals_tabs">
            <label for="tab-corolla" class="deals_tab">
              <i class="ri-car-line"></i> Toyota Corolla
            </label>
            <label for="tab-noah" class="deals_tab">
              <i class="ri-bus-line"></i> Toyota Noah
            </label>
            <label for="tab-pajero" class="deals_tab">
              <i class="ri-truck-line"></i> Mitsubishi Pajero
            </label>
            <label for="tab-swift" class="deals_tab">
              <i class="ri-car-washing-line"></i> Suzuki Swift
            </label>
          </div>

          <!-- Panel: Toyota Corolla -->
          <div class="deal_panel" id="panel-corolla">
            <div class="deal_image">
              <img src="Assets/range-1.jpg" alt="Toyota Corolla" />
            </div>
            <div class="deal_info">
              <h3>Toyota Corolla</h3>
              <p class="deal_tagline">Comfortable sedan — ideal for city  highway</p>
              <div class="deal_specs">
                <div class="spec"><i class="ri-group-line"></i><span>5</span><small>Seats</small></div>
                <div class="spec"><i class="ri-settings-3-line"></i><span>Auto</span><small>Transmission</small></div>
                <div class="spec"><i class="ri-gas-station-line"></i><span>Petrol</span><small>Fuel</small></div>
                <div class="spec"><i class="ri-temp-cold-line"></i><span>AC</span><small>Climate</small></div>
                <div class="spec"><i class="ri-car-door-line"></i><span>4 Doors</span><small>Body</small></div>
                <div class="spec"><i class="ri-calendar-line"></i><span>2022</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 4,500 <small>/ day</small></div>
                <a href="#" class="btn">Book Now <i class="ri-arrow-right-line"></i></a>
              </div>
            </div>
          </div>

          <!-- Panel: Toyota Noah -->
          <div class="deal_panel" id="panel-noah">
            <div class="deal_image">
              <img src="Assets/range-2.jpg" alt="Toyota Noah" />
            </div>
            <div class="deal_info">
              <h3>Toyota Noah</h3>
              <p class="deal_tagline">Spacious MPV — perfect for families  groups</p>
              <div class="deal_specs">
                <div class="spec"><i class="ri-group-line"></i><span>8</span><small>Seats</small></div>
                <div class="spec"><i class="ri-settings-3-line"></i><span>Auto</span><small>Transmission</small></div>
                <div class="spec"><i class="ri-gas-station-line"></i><span>Petrol</span><small>Fuel</small></div>
                <div class="spec"><i class="ri-temp-cold-line"></i><span>Dual AC</span><small>Climate</small></div>
                <div class="spec"><i class="ri-car-door-line"></i><span>Sliding</span><small>Door</small></div>
                <div class="spec"><i class="ri-calendar-line"></i><span>2021</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 7,000 <small>/ day</small></div>
                <a href="#" class="btn">Book Now <i class="ri-arrow-right-line"></i></a>
              </div>
            </div>
          </div>

          <!-- Panel: Mitsubishi Pajero -->
          <div class="deal_panel" id="panel-pajero">
            <div class="deal_image">
              <img src="Assets/range-3.jpg" alt="Mitsubishi Pajero" />
            </div>
            <div class="deal_info">
              <h3>Mitsubishi Pajero</h3>
              <p class="deal_tagline">Rugged 4WD SUV — built for mountain terrain</p>
              <div class="deal_specs">
                <div class="spec"><i class="ri-group-line"></i><span>7</span><small>Seats</small></div>
                <div class="spec"><i class="ri-settings-3-line"></i><span>Manual</span><small>Transmission</small></div>
                <div class="spec"><i class="ri-gas-station-line"></i><span>Diesel</span><small>Fuel</small></div>
                <div class="spec"><i class="ri-roadster-line"></i><span>4WD</span><small>Drive</small></div>
                <div class="spec"><i class="ri-car-door-line"></i><span>SUV</span><small>Body</small></div>
                <div class="spec"><i class="ri-calendar-line"></i><span>2020</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 9,500 <small>/ day</small></div>
                <a href="#" class="btn">Book Now <i class="ri-arrow-right-line"></i></a>
              </div>
            </div>
          </div>

          <!-- Panel: Suzuki Swift -->
          <div class="deal_panel" id="panel-swift">
            <div class="deal_image">
              <img src="Assets/range-4.jpg" alt="Suzuki Swift" />
            </div>
            <div class="deal_info">
              <h3>Suzuki Swift</h3>
              <p class="deal_tagline">Compact hatchback — nimble  fuel efficient</p>
              <div class="deal_specs">
                <div class="spec"><i class="ri-group-line"></i><span>5</span><small>Seats</small></div>
                <div class="spec"><i class="ri-settings-3-line"></i><span>Manual</span><small>Transmission</small></div>
                <div class="spec"><i class="ri-gas-station-line"></i><span>Petrol</span><small>Fuel</small></div>
                <div class="spec"><i class="ri-temp-cold-line"></i><span>AC</span><small>Climate</small></div>
                <div class="spec"><i class="ri-car-door-line"></i><span>Hatchback</span><small>Body</small></div>
                <div class="spec"><i class="ri-calendar-line"></i><span>2023</span><small>Year</small></div>
              </div>

              <div class="deal_price_row">
                <div class="deal_price">NPR 3,500 <small>/ day</small></div>
                <a href="#" class="btn">Book Now <i class="ri-arrow-right-line"></i></a>
              </div>
            </div>
          </div>

        </div>
      </div>
    </section>

    <!-- ========== WHY CHOOSE US ========== -->
    <section class="choose_container" id="choose">
      <div class="choose_image">
        <img src="Assets/why choosed us.jpeg" alt="Happy customer with car" />
      </div>
      <div class="choose_content">
        <h2 class="section_header">Why choose us</h2>
        <p class="section_description">
          Discover the difference with our car rental service. We offer reliable
          vehicles, exceptional customer service, and competitive pricing.
        </p>
        <div class="choose_grid">
          <div class="choose_card">
            <span><i class="ri-customer-service-line"></i></span>
            <div>
              <h4>Customer Support</h4>
              <p>Our dedicated support team is available to assist you 24/7.</p>
            </div>
          </div>
          <div class="choose_card">
            <span><i class="ri-map-pin-line"></i></span>
            <div>
              <h4>Many Locations</h4>
              <p>Convenient pick-up and drop-off locations to suit your travel needs.</p>
            </div>
          </div>
          <div class="choose_card">
            <span><i class="ri-wallet-line"></i></span>
            <div>
              <h4>Best Price</h4>
              <p>Enjoy competitive rates and great value for every rental.</p>
            </div>
          </div>
          <div class="choose_card">
            <span><i class="ri-calendar-close-line"></i></span>
            <div>
              <h4>Free Cancellations</h4>
              <p>Flexible bookings with free cancellation options.</p>
            </div>
        </div>
      </div>
    </section>

    <!-- ========== SUBSCRIBE ========== -->
    <section class="subscribe_container">
      <div class="subscribe_image">
        <img src="Assets/ford-raptor-r-concept-1.jpg" alt="Newsletter car" />
      </div>
      <div class="subscribe_content">
        <h2 class="section_header">Subscribe for the latest car rental updates</h2>
        <p class="section_description">
          Stay in the know! Subscribe to receive the latest car rental deals,
          exclusive offers, and updates right to your inbox.
        </p>
        <form action="/" class="subscribe_form">
          <input type="email" placeholder="Enter your email address" required />
          <button type="submit" class="btn">Subscribe</button>
        </form>
      </div>
    </section>

    <!-- ========== TESTIMONIALS ========== -->
<section class="section_container client_container" id="client">
  <h2 class="section_header">What people say about us</h2>
  <p class="section_description">
    Discover why our customers love renting with us!
  </p>

  <div class="client_grid">

    <div class="client_card">
      <div class="client_details">

        <!-- IMAGE ONLY -->
        <img src="Assets/client-kushal.jpg" alt="Kushal Khanal" class="client_avatar" />

        <div>
          <h4>Kushal Khanal</h4>
          <div class="client_rating">
            <i class="ri-star-fill"></i><i class="ri-star-fill"></i>
            <i class="ri-star-fill"></i><i class="ri-star-fill"></i>
            <i class="ri-star-line"></i>
          </div>
        </div>

      </div>
      <p>
        Affordable prices and great selection of vehicles! I found
        exactly what I needed, and the pick-up and drop-off process was seamless.
      </p>
    </div>

    <div class="client_card">
      <div class="client_details">

        <img src="Assets/client-rehan.jpg" alt="Rehan Basnet" class="client_avatar" />

        <div>
          <h4>Rehan Basnet</h4>
          <div class="client_rating">
            <i class="ri-star-fill"></i><i class="ri-star-fill"></i>
            <i class="ri-star-fill"></i><i class="ri-star-fill"></i>
            <i class="ri-star-line"></i>
          </div>
        </div>

      </div>
      <p>
        The flexibility of free cancellations made my trip stress-free.
        Great service overall — will definitely rent again!
      </p>
    </div>

    <div class="client_card">
      <div class="client_details">

        <img src="Assets/client-rehan.jpg" alt="Sita Rai" class="client_avatar" />

        <div>
          <h4>Rojal Shrestha</h4>
          <div class="client_rating">
            <i class="ri-star-fill"></i><i class="ri-star-fill"></i>
            <i class="ri-star-fill"></i><i class="ri-star-fill"></i>
            <i class="ri-star-fill"></i>
          </div>
        </div>

      </div>
      <p>
        Excellent vehicles and very professional staff. The booking
        process was quick and the car was in perfect condition.
      </p>
    </div>

  </div>
</section>

    <!-- ========== FOOTER ========== -->
    <footer class="footer">
      <div class="section_container footer_container">
        <div class="footer_col">
          <div class="footer_logo">
            <a href="#" class="logo">
              <img src="https://placehold.co/60x60/ffffff/0f172a?text=R" alt="RentAll logo" />
              <span>RentAll</span>
            </a>
          </div>
          <p>We're here to provide you with the best vehicles and a seamless rental experience.</p>
          <div class="footer_socials">
            <a href="#"><i class="ri-facebook-fill"></i></a>
            <a href="#"><i class="ri-instagram-line"></i></a>
            <a href="#"><i class="ri-twitter-x-line"></i></a>
          </div>
        </div>
        <div class="footer_col">
          <h4>Our Services</h4>
          <ul class="footer_links">
            <li><a href="#">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Rental Deals</a></li>
            <li><a href="#">Why Choose Us</a></li>
            <li><a href="#">Testimonials</a></li>
          </ul>
        </div>
        <div class="footer_col">
          <h4>Vehicle Models</h4>
          <ul class="footer_links">
            <li><a href="#">Toyota Corolla</a></li>
            <li><a href="#">Toyota Noah</a></li>
            <li><a href="#">Mitsubishi Pajero</a></li>
            <li><a href="#">Suzuki Swift</a></li>
          </ul>
        </div>
        <div class="footer_col">
          <h4>Contact</h4>
          <ul class="footer_links">
            <li><a href="tel:+9779818162494"><i class="ri-phone-fill"></i> +977 9818162494</a></li>
            <li><a href="#"><i class="ri-map-pin-fill"></i> Kathmandu, Nepal</a></li>
            <li><a href="mailto:kushal@gmail.com"><i class="ri-mail-fill"></i> kushal@gmail.com</a></li>
          </ul>
        </div>
      </div>
    </footer>
    <script>
      /* Mobile menu toggle */
      document.getElementById('menu-btn').addEventListener('click', function () {
        document.getElementById('nav-links').classList.toggle('active');
      });

      /* User avatar dropdown toggle */
      function toggleUserDropdown() {
        var dd = document.getElementById('userDropdown');
        if (dd) dd.classList.toggle('open');
      }

      /* Close dropdown when clicking outside */
      document.addEventListener('click', function (e) {
        var wrap = document.getElementById('userAvatarWrap');
        var dd   = document.getElementById('userDropdown');
        if (wrap && dd && !wrap.contains(e.target)) {
          dd.classList.remove('open');
        }
      });
    </script>
  </body>
</html>