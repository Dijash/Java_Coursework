<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll - Car Rental</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet" />
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Poppins', sans-serif;
  background-color: #ffffff;
  color: #1e293b;
  line-height: 1.6;
  overflow-x: hidden;
  scroll-behavior: smooth;
}

.section_container {
  max-width: 1280px;
  margin: auto;
  padding: 4rem 2rem;
}

.section_header {
  font-size: 2.2rem;
  font-weight: 700;
  text-align: center;
  margin-bottom: 1rem;
  color: #0f172a;
}

.section_description {
  text-align: center;
  max-width: 650px;
  margin: 0 auto 2rem auto;
  color: #475569;
  font-size: 1rem;
  line-height: 1.7;
}

/* ========================================
   BUTTONS
======================================== */
.btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  background-color: #2563eb;
  color: white;
  padding: 0.7rem 1.5rem;
  border-radius: 90px;
  font-weight: 600;
  border: none;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
  font-size: 0.9rem;
  font-family: 'Poppins', sans-serif;
}

.btn:hover {
  background-color: #1d4ed8;
  transform: scale(1.02);
}

.btn--outline {
  background-color: transparent;
  color: #2563eb;
  border: 2px solid #2563eb;
}

.btn--outline:hover {
  background-color: #2563eb;
  color: white;
}

.btn--search {
  height: 48px;
  padding: 0 1.8rem;
  border-radius: 8px;
  align-self: flex-end;
}

/* ========================================
   NAVBAR
======================================== */
nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.2rem 2rem;
  max-width: 1280px;
  margin: 0 auto;
  flex-wrap: wrap;
  gap: 1rem;
}

.nav_header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: auto;
}

.nav_logo .logo {
  font-size: 1.8rem;
  font-weight: 800;
  text-decoration: none;
  background: linear-gradient(120deg, #1e40af, #3b82f6);
  background-clip: text;
  -webkit-background-clip: text;
  color: transparent;
}

.nav_links {
  display: flex;
  gap: 2rem;
  list-style: none;
}

.nav_links a {
  text-decoration: none;
  font-weight: 500;
  color: #1e293b;
  transition: color 0.2s;
  font-size: 0.95rem;
}

.nav_links a:hover {
  color: #2563eb;
}

.nav_btns {
  display: flex;
  gap: 0.8rem;
}

.nav_menu_btn {
  display: none;
  font-size: 1.8rem;
  cursor: pointer;
  color: #1e293b;
}

/* ========================================
   HEADER HERO
======================================== */
.header_container {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 2rem;
  padding: 2rem 2rem 3rem;
  max-width: 1280px;
  margin: 0 auto;
}

.header_image {
  flex: 1;
  min-width: 260px;
}

.header_image img {
  width: 100%;
  max-width: 550px;
  height: auto;
  margin: 0 auto;
  border-radius: 1.5rem;
  display: block;
  object-fit: cover;
}

.header_content {
  flex: 1;
  min-width: 280px;
}



.header_content h1 {
  font-size: 2.8rem;
  font-weight: 800;
  line-height: 1.2;
  color: #0f172a;
  margin-bottom: 1rem;
}

.header_content .section_description {
  text-align: left;
  margin: 0 0 1.5rem 0;
}

/* ========================================
   SEARCH FORM
======================================== */
.header_form {
  background: white;
  max-width: 1100px;
  margin: -2rem auto 3rem auto;
  padding: 1.5rem 2rem;
  border-radius: 1.5rem;
  box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.12);
  position: relative;
  z-index: 5;
}

.header_form form {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
  align-items: flex-end;
  justify-content: center;
}

.input_group {
  display: flex;
  flex-direction: column;
  gap: 6px;
  min-width: 200px;
  flex: 1;
}

.input_group label {
  font-size: 0.82rem;
  font-weight: 600;
  color: #475569;
  display: flex;
  align-items: center;
  gap: 5px;
}

.input_group select,
.input_group input[type="date"] {
  width: 100%;
  padding: 12px 16px;
  border: 1.5px solid #e2e8f0;
  border-radius: 8px;
  font-size: 0.9rem;
  font-family: 'Poppins', sans-serif;
  background-color: #f8fafc;
  color: #1e293b;
  appearance: none;
  box-sizing: border-box;
  height: 48px;
  transition: border-color 0.2s;
}

.input_group select:focus,
.input_group input[type="date"]:focus {
  outline: none;
  border-color: #2563eb;
  background: white;
}

.input_icon {
  position: relative;
}

.input_arrow {
  position: absolute;
  right: 12px;
  top: 50%;
  transform: translateY(-50%);
  color: #94a3b8;
  pointer-events: none;
  font-size: 1rem;
}

/* ========================================
   HOW IT WORKS
======================================== */
.about_container {
  background: #f8fafc;
}

.about_grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.about_card {
  text-align: center;
  padding: 2rem 1.5rem;
  background: white;
  border-radius: 1.5rem;
  border: 1px solid #e2e8f0;
  transition: transform 0.2s, box-shadow 0.2s;
}

.about_card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 28px rgba(0, 0, 0, 0.07);
}

.about_icon {
  width: 60px;
  height: 60px;
  background: #eff6ff;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1rem auto;
  font-size: 1.6rem;
  color: #2563eb;
}

.about_card h4 {
  font-size: 1.1rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
  color: #0f172a;
}

.about_card p {
  color: #64748b;
  font-size: 0.92rem;
}

/* ========================================
   DEALS / TABS
======================================== */
.deals {
  padding: 4rem 1rem;
  background: #f1f5f9;
}

.deals_container {
  max-width: 1200px;
  margin: auto;
  text-align: center;
  padding: 0 1rem;
}

.deals_tabs_wrapper {
  margin-top: 2rem;
}

.deals_tabs {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 2rem;
  justify-content: center;
}

.deals_tab {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 10px 22px;
  border: 1.5px solid #cbd5e1;
  border-radius: 8px;
  font-size: 0.88rem;
  font-family: 'Poppins', sans-serif;
  font-weight: 500;
  cursor: pointer;
  color: #64748b;
  background: white;
  transition: all 0.2s;
}

.deals_tab:hover {
  border-color: #2563eb;
  color: #2563eb;
}

/* Active tab via :has() */
.deals_tabs_wrapper:has(#tab-corolla:checked) label[for="tab-corolla"],
.deals_tabs_wrapper:has(#tab-noah:checked)    label[for="tab-noah"],
.deals_tabs_wrapper:has(#tab-pajero:checked)  label[for="tab-pajero"],
.deals_tabs_wrapper:has(#tab-swift:checked)   label[for="tab-swift"] {
  background: #1e293b;
  color: #fff;
  border-color: #1e293b;
}

/* All panels hidden by default */
.deal_panel {
  display: none;
  gap: 2.5rem;
  align-items: stretch;
  flex-wrap: wrap;
  background: white;
  border-radius: 1.5rem;
  padding: 2rem;
  border: 1px solid #e2e8f0;
  text-align: left;
}

/* Show active panel */
.deals_tabs_wrapper:has(#tab-corolla:checked) #panel-corolla,
.deals_tabs_wrapper:has(#tab-noah:checked)    #panel-noah,
.deals_tabs_wrapper:has(#tab-pajero:checked)  #panel-pajero,
.deals_tabs_wrapper:has(#tab-swift:checked)   #panel-swift {
  display: flex;
}

/* Deal image */
.deal_image {
  flex: 0 0 380px;
  max-width: 100%;
  border-radius: 1rem;
  overflow: hidden;
  background: #f1f5f9;
  position: relative;
  min-height: 260px;
}

.deal_image img {
  width: 100%;
  height: 100%;
  min-height: 260px;
  object-fit: cover;
  display: block;
}

.deal_badge {
  position: absolute;
  top: 14px;
  left: 14px;
  background: #1e293b;
  color: white;
  font-size: 0.75rem;
  font-weight: 600;
  padding: 4px 12px;
  border-radius: 90px;
}

.deal_badge--popular {
  background: #2563eb;
}

/* Deal info */
.deal_info {
  flex: 1;
  min-width: 260px;
  display: flex;
  flex-direction: column;
}

.deal_info h3 {
  font-size: 1.6rem;
  font-weight: 700;
  color: #0f172a;
  margin: 0 0 4px;
}

.deal_tagline {
  color: #64748b;
  font-size: 0.92rem;
  margin: 0 0 1.5rem;
}

/* Specs grid */
.deal_specs {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
  margin-bottom: 1.2rem;
}

.spec {
  background: #f8fafc;
  border: 1px solid #e2e8f0;
  border-radius: 10px;
  padding: 10px 8px;
  text-align: center;
}

.spec i {
  font-size: 1.1rem;
  color: #2563eb;
  display: block;
  margin-bottom: 4px;
}

.spec span {
  display: block;
  font-size: 0.88rem;
  font-weight: 600;
  color: #0f172a;
}

.spec small {
  font-size: 0.72rem;
  color: #94a3b8;
  display: block;
  margin-top: 2px;
}


/* Price & book row */
.deal_price_row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 1rem;
  margin-top: auto;
  padding-top: 1rem;
  border-top: 1px solid #f1f5f9;
}

.deal_price {
  font-size: 1.8rem;
  font-weight: 700;
  color: #0f172a;
}

.deal_price small {
  font-size: 0.85rem;
  font-weight: 400;
  color: #94a3b8;
}

/* ========================================
   WHY CHOOSE US
======================================== */
.choose_container {
  display: flex;
  flex-wrap: wrap;
  gap: 3rem;
  align-items: center;
  padding: 4rem 2rem;
  max-width: 1280px;
  margin: 0 auto;
}

.choose_image {
  flex: 1;
  min-width: 260px;
}

.choose_image img {
  width: 100%;
  max-height: 500px;
  object-fit: cover;
  border-radius: 1.5rem;
  display: block;
}

.choose_content {
  flex: 1;
  min-width: 280px;
}

.choose_content .section_header,
.choose_content .section_description {
  text-align: left;
  margin-left: 0;
}

.choose_grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 1.2rem;
  margin-top: 1.5rem;
}

.choose_card {
  display: flex;
  gap: 1rem;
  align-items: flex-start;
  padding: 1rem;
  border-radius: 1rem;
  transition: background 0.2s;
}

.choose_card:hover {
  background: #f8fafc;
}

.choose_card span {
  font-size: 1.6rem;
  color: #2563eb;
  flex-shrink: 0;
  width: 44px;
  height: 44px;
  background: #eff6ff;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.choose_card h4 {
  font-size: 0.95rem;
  font-weight: 600;
  color: #0f172a;
  margin-bottom: 3px;
}

.choose_card p {
  font-size: 0.85rem;
  color: #64748b;
}

/* ========================================
   SUBSCRIBE
======================================== */
.subscribe_container {
  display: flex;
  flex-wrap: wrap;
  background: #eff6ff;
  border-radius: 2rem;
  margin: 0 auto 4rem auto;
  max-width: 1200px;
  overflow: hidden;
  border: 1px solid #bfdbfe;
}

.subscribe_image {
  flex: 1;
  min-width: 320px;
  max-height: 500px;
  overflow: hidden;
}

.subscribe_image img {
  width: 100%;
  max-height: 450px;
  object-fit: cover;
  display: block;
  justify-content: left;

}

.subscribe_content {
  flex: 1;
  padding: 3rem 2rem;
  min-width: 280px;
}

.subscribe_content .section_header,
.subscribe_content .section_description {
  text-align: left;
  margin-left: 0;
}

.subscribe_form {
  display: flex;
  gap: 0.8rem;
  margin-top: 1.5rem;
  flex-wrap: wrap;
}

.subscribe_form input {
  flex: 2;
  min-width: 200px;
  padding: 0.8rem 1.2rem;
  border-radius: 90px;
  border: 1.5px solid #bfdbfe;
  outline: none;
  font-family: 'Poppins', sans-serif;
  font-size: 0.9rem;
  background: white;
  transition: border-color 0.2s;
}

.subscribe_form input:focus {
  border-color: #2563eb;
}

/* ========================================
   TESTIMONIALS
======================================== */
.client_container {
  background: #f8fafc;
  padding: 2rem 0;
}

.client_grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 1.5rem;
  margin-top: 2rem;
}

.client_card {
  background: #fff;
  padding: 1.5rem;
  border-radius: 12px;
  border: 1px solid #e2e8f0;
  transition: 0.2s ease;
}

.client_card:hover {
  transform: translateY(-4px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
}

.client_details {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1rem;
}

.client_avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
}

.client_details h4 {
  font-size: 1rem;
  margin: 0;
  color: #0f172a;
}

.client_rating {
  color: #fbbf24;
  font-size: 0.9rem;
  margin-top: 2px;
}

.client_card p {
  font-size: 0.9rem;
  color: #475569;
  line-height: 1.6;
}
/* ========================================
   FOOTER
======================================== */
.footer {
  background: #0f172a;
  color: #cbd5e1;
}

.footer_container {
  display: flex;
  flex-wrap: wrap;
  gap: 2rem;
  justify-content: space-between;
  padding: 4rem 2rem 2rem;
  max-width: 1280px;
  margin: auto;
}

.footer_col {
  flex: 1;
  min-width: 180px;
}

.footer_logo .logo {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  text-decoration: none;
  font-size: 1.5rem;
  font-weight: 800;
  color: white;
  margin-bottom: 1rem;
}

.footer_logo img {
  width: 36px;
  height: 36px;
  object-fit: contain;
  filter: brightness(0) invert(1);
}

.footer_col > p {
  font-size: 0.88rem;
  line-height: 1.7;
  color: #94a3b8;
  margin-bottom: 1.2rem;
}

.footer_socials {
  display: flex;
  gap: 0.8rem;
  margin-top: 0.5rem;
}

.footer_socials a {
  width: 36px;
  height: 36px;
  background: #1e293b;
  color: #cbd5e1;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1rem;
  text-decoration: none;
  transition: background 0.2s, color 0.2s;
}

.footer_socials a:hover {
  background: #2563eb;
  color: white;
}

.footer_col h4 {
  font-size: 0.95rem;
  font-weight: 600;
  color: white;
  margin-bottom: 1rem;
}

.footer_links {
  list-style: none;
}

.footer_links li {
  margin-bottom: 0.6rem;
}

.footer_links a {
  text-decoration: none;
  color: #94a3b8;
  font-size: 0.88rem;
  transition: color 0.2s;
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
}

.footer_links a:hover {
  color: white;
}

.footer_bottom {
  border-top: 1px solid #1e293b;
  text-align: center;
  padding: 1.2rem 2rem;
  font-size: 0.82rem;
  color: #475569;
}

/* ========================================
   RESPONSIVE
======================================== */
@media (max-width: 1048px) {
  .nav_links {
    display: none;
    width: 100%;
    flex-direction: column;
    align-items: center;
    padding: 1rem 0;
    gap: 1rem;
    order: 3;
  }

  .nav_links.active {
    display: flex;
  }

  .nav_btns {
    display: none;
  }

  .nav_menu_btn {
    display: block;
  }

  nav {
    flex-wrap: wrap;
  }
}

@media (max-width: 768px) {
  .section_header {
    font-size: 1.7rem;
  }

  .header_content h1 {
    font-size: 2rem;
  }

  .deal_image {
    flex: 0 0 100%;
  }

  .deal_panel {
    padding: 1.2rem;
  }

  .deal_specs {
    grid-template-columns: repeat(2, 1fr);
  }

  .choose_content .section_header,
  .choose_content .section_description {
    text-align: center;
    margin: 0 auto 1rem auto;
  }

  .subscribe_content .section_header,
  .subscribe_content .section_description {
    text-align: center;
    margin: 0 auto 1rem auto;
  }
}

@media (max-width: 500px) {
  .header_form {
    margin: 1rem auto 2rem auto;
    padding: 1.2rem;
  }

  .header_stats {
    gap: 1rem;
  }

  .deal_price_row {
    flex-direction: column;
    align-items: flex-start;
  }

  .section_container {
    padding: 3rem 1rem;
  }
}

    </style>
  </head>
  <body>

    <!-- ========== HEADER / NAV ========== -->
    <header>
      <nav>
        <div class="nav_header">
          <div class="nav_logo">
            <a href="<%= request.getContextPath() %>/"class="logo"><span>RentAll</span></a>
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
          <a href="<%= request.getContextPath() %>/login" class="btn btn--outline">Login</a>
          <a href="<%= request.getContextPath() %>/register" class="btn">Register</a>
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
>
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
  </body>
</html>