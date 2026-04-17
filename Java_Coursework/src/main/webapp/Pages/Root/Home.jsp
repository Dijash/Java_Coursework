<%@ page import="model.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Customer loggedInUser = (Customer) session.getAttribute("user");
    String username = (loggedInUser != null) ? loggedInUser.getCustomer_username() : "User";
    String email    = (loggedInUser != null) ? loggedInUser.getCustomer_email()    : "";
    String fullName = (loggedInUser != null) ? loggedInUser.getFullName()          : "User";
    // Build avatar initials: first letter of first_name + first letter of last_name
    String avatarInitial = username.length() > 0 ? String.valueOf(username.charAt(0)).toUpperCase() : "U";
    if (loggedInUser != null && loggedInUser.getFirst_name() != null && loggedInUser.getLast_name() != null) {
        avatarInitial = String.valueOf(loggedInUser.getFirst_name().charAt(0)).toUpperCase()
                      + String.valueOf(loggedInUser.getLast_name().charAt(0)).toUpperCase();
    }
%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>RentAll - Car Rental</title>
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
.button {
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

.button:hover {
  background-color: #1d4ed8;
  transform: scale(1.02);
}

.button_outline {
  background-color: transparent;
  color: #2563eb;
  border: 2px solid #2563eb;
}

.button_outline:hover {
  background-color: #2563eb;
  color: white;
}

.button_search {
  height: 48px;
  padding: 0 1.8rem;
  border-radius: 8px;
  align-self: flex-end;
}

.icon {
  width: 1em;
  height: 1em;
  display: inline-block;
  vertical-align: middle;
  flex-shrink: 0;
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

.nav_buttons {
  display: flex;
  gap: 0.8rem;
  align-items: center;
}

.nav_menu_button {
  display: none;
  font-size: 1.8rem;
  cursor: pointer;
  color: #1e293b;
  background: none;
  border: none;
  padding: 0;
  line-height: 1;
}

/* ========================================
   USER AVATAR & DROPDOWN
======================================== */
.user_avatar_wrap {
  position: relative;
  display: flex;
  align-items: center;
  gap: 0.6rem;
  cursor: pointer;
  user-select: none;
}

.user_avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: linear-gradient(135deg, #2563eb, #1e40af);
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 0.85rem;
  flex-shrink: 0;
  letter-spacing: 0.5px;
}

.user_name_nav {
  font-size: 0.9rem;
  font-weight: 500;
  color: #1e293b;
}

/* DROPDOWN – HIDDEN BY DEFAULT */
.user_dropdown {
  display: none;
  position: absolute;
  top: calc(100% + 10px);
  right: 0;
  min-width: 220px;
  background: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12);
  z-index: 999;
  overflow: hidden;
}

/* DROPDOWN – VISIBLE WHEN OPEN CLASS IS ADDED */
.user_dropdown.open {
  display: block;
  animation: dropdownFade 0.15s ease;
}

@keyframes dropdownFade {
  from { opacity: 0; transform: translateY(-6px); }
  to   { opacity: 1; transform: translateY(0); }
}

.dropdown_header {
  padding: 0.9rem 1rem;
  border-bottom: 1px solid #f1f5f9;
  background: #f8fafc;
}
.dropdown_header p {
  font-weight: 600;
  font-size: 0.9rem;
  margin: 0 0 2px;
  color: #0f172a;
}
.dropdown_header span {
  font-size: 0.78rem;
  color: #64748b;
}
.dropdown_item {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  padding: 0.7rem 1rem;
  font-size: 0.88rem;
  color: #334155;
  text-decoration: none;
  transition: background 0.15s;
  width: 100%;
  background: none;
  border: none;
  cursor: pointer;
  font-family: inherit;
  text-align: left;
}
.dropdown_item:hover {
  background: #f1f5f9;
  color: #2563eb;
}
.dropdown_item.danger {
  color: #dc2626;
}
.dropdown_item.danger:hover {
  background: #fff1f1;
  color: #b91c1c;
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
  display: flex;
  align-items: center;
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

.about_icon svg {
  width: 28px;
  height: 28px;
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

.deals_tabs_wrapper:has(#tab-corolla:checked) label[for="tab-corolla"],
.deals_tabs_wrapper:has(#tab-noah:checked)    label[for="tab-noah"],
.deals_tabs_wrapper:has(#tab-pajero:checked)  label[for="tab-pajero"],
.deals_tabs_wrapper:has(#tab-swift:checked)   label[for="tab-swift"] {
  background: #1e293b;
  color: #fff;
  border-color: #1e293b;
}

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

.deals_tabs_wrapper:has(#tab-corolla:checked) #panel-corolla,
.deals_tabs_wrapper:has(#tab-noah:checked)    #panel-noah,
.deals_tabs_wrapper:has(#tab-pajero:checked)  #panel-pajero,
.deals_tabs_wrapper:has(#tab-swift:checked)   #panel-swift {
  display: flex;
}

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

.deal_badge_popular {
  background: #2563eb;
}

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

.spec svg {
  width: 1.1rem;
  height: 1.1rem;
  color: #2563eb;
  display: block;
  margin: 0 auto 4px;
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

.choose_card > span {
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

.choose_card > span svg {
  width: 22px;
  height: 22px;
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
  display: flex;
  gap: 2px;
  margin-top: 2px;
}

.client_rating svg {
  width: 16px;
  height: 16px;
}

.star-fill { color: #fbbf24; }
.star-empty { color: #cbd5e1; }

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

.footer_socials a svg {
  width: 18px;
  height: 18px;
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

.footer_links a svg {
  width: 15px;
  height: 15px;
  flex-shrink: 0;
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

  .nav_buttons {
    display: none;
  }

  .nav_menu_button {
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

    <%-- ========== HEADER / NAV ========== --%>
    <header>
      <nav>
        <div class="nav_header">
          <div class="nav_logo">
            <a href="<%= request.getContextPath() %>/home" class="logo"><span>RentAll</span></a>
          </div>
          <%-- Hamburger Menu Icon --%>
          <button class="nav_menu_button" aria-label="Toggle menu">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" width="28" height="28"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
          </button>
        </div>
        <ul class="nav_links" id="nav-links">
          <li><a href="#about">Services</a></li>
          <li><a href="#deals">Rental Deals</a></li>
          <li><a href="#choose">About</a></li>
          <li><a href="#client">Contact Us</a></li>
        </ul>

        <%-- ===== USER AVATAR DROPDOWN (shown when logged in) ===== --%>
        <div class="nav_buttons">
          <div class="user_avatar_wrap" id="userAvatarWrap">
            <div class="user_avatar"><%= avatarInitial %></div>
            <span class="user_name_nav"><%= username %></span>
            <%-- Chevron down --%>
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#64748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>

            <div class="user_dropdown" id="userDropdown">
              <div class="dropdown_header">
                <p><%= fullName %></p>
                <span><%= email %></span>
              </div>
              <a href="<%= request.getContextPath() %>/user" class="dropdown_item">
                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
                Dashboard
              </a>
              <a href="<%= request.getContextPath() %>/user?section=profile" class="dropdown_item">
                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                My Profile
              </a>
              <a href="<%= request.getContextPath() %>/user?section=bookings" class="dropdown_item">
                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
                My Bookings
              </a>
              <a href="<%= request.getContextPath() %>/logout" class="dropdown_item danger">
                <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                Log Out
              </a>
            </div>
          </div>
        </div>
      </nav>

      <div class="header_container" id="home">
        <div class="header_image">
          <img src="<%= request.getContextPath() %>/Assets/header.png" alt="Luxury car rental" />
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

    <%-- ========== SEARCH FORM ========== --%>
    <section class="header_form">
      <form action="<%= request.getContextPath() %>/home">
        <div class="input_group">
          <label for="location">
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
            Pick up &amp; Return location
          </label>
          <div class="input_icon">
            <select id="location" name="location">
              <option value="">Select a location</option>
              <option value="Kathmandu">Kathmandu</option>
              <option value="Lalitpur">Lalitpur</option>
              <option value="Bhaktapur">Bhaktapur</option>
              <option value="Pokhara">Pokhara</option>
              <option value="Chitwan">Chitwan</option>
            </select>
            <span class="input_arrow">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"/></svg>
            </span>
          </div>
        </div>

        <div class="input_group date-group">
          <label for="start">
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
            Pick up date
          </label>
          <div class="input_icon">
            <input type="date" id="start" name="startDate" />
          </div>
        </div>

        <div class="input_group date-group">
          <label for="stop">
            <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
            Return date
          </label>
          <div class="input_icon">
            <input type="date" id="stop" name="endDate" />
          </div>
        </div>

        <button type="submit" class="button button_search">
          <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          Search
        </button>
      </form>
    </section>

    <%-- ========== HOW IT WORKS ========== --%>
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
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
          </div>
          <h4>Choose Location</h4>
          <p>Select from a variety of pick-up locations that best suit your needs.</p>
        </div>
        <div class="about_card">
          <div class="about_icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/><polyline points="9 16 11 18 15 14"/></svg>
          </div>
          <h4>Pick-up Date</h4>
          <p>Choose the exact date and time for your car pick-up.</p>
        </div>
        <div class="about_card">
          <div class="about_icon">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 17H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h1l2-4h10l2 4h1a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2h-2"/><circle cx="7.5" cy="17" r="2.5"/><circle cx="16.5" cy="17" r="2.5"/></svg>
          </div>
          <h4>Book your Car</h4>
          <p>Complete your booking with just a few clicks.</p>
        </div>
      </div>
    </section>

    <%-- ========== DEALS / TABS ========== --%>
    <section class="deals" id="deals">
      <div class="section_container deals_container">
        <h2 class="section_header">Most popular car rental deals</h2>
        <p class="section_description">
          Explore our top car rental deals, handpicked to give you the best value.
        </p>

        <div class="deals_tabs_wrapper">
          <input type="radio" name="deal" id="tab-corolla" hidden checked />
          <input type="radio" name="deal" id="tab-noah" hidden />
          <input type="radio" name="deal" id="tab-pajero" hidden />
          <input type="radio" name="deal" id="tab-swift" hidden />

          <div class="deals_tabs">
            <label for="tab-corolla" class="deals_tab">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 17H3a2 2 0 0 1-2-2V9a2 2 0 0 1 2-2h1l2-4h10l2 4h1a2 2 0 0 1 2 2v6a2 2 0 0 1-2 2h-2"/><circle cx="7.5" cy="17" r="2.5"/><circle cx="16.5" cy="17" r="2.5"/></svg>
              Toyota Corolla
            </label>
            <label for="tab-noah" class="deals_tab">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="3" width="15" height="13" rx="2"/><path d="M16 8h4l3 5v3h-7V8z"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>
              Toyota Noah
            </label>
            <label for="tab-pajero" class="deals_tab">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 3h15v13H1z"/><path d="M16 8h4l3 3v5h-7V8z"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>
              Mitsubishi Pajero
            </label>
            <label for="tab-swift" class="deals_tab">
              <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M7 17H3a2 2 0 0 1-2-2v-4l3-6h12l3 6v4a2 2 0 0 1-2 2h-2"/><circle cx="7" cy="17" r="2"/><circle cx="17" cy="17" r="2"/><path d="M5 9h14"/></svg>
              Suzuki Swift
            </label>
          </div>

          <%-- Panel: Toyota Corolla --%>
          <div class="deal_panel" id="panel-corolla">
            <div class="deal_image">
              <img src="<%= request.getContextPath() %>/Assets/range-1.jpg" alt="Toyota Corolla" />
            </div>
            <div class="deal_info">
              <h3>Toyota Corolla</h3>
              <p class="deal_tagline">Comfortable sedan — ideal for city &amp; highway</p>
              <div class="deal_specs">
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg><span>5</span><small>Seats</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/><path d="M4.93 4.93a10 10 0 0 0 0 14.14"/></svg><span>Auto</span><small>Transmission</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 22V8l9-6 9 6v14"/><path d="M9 22v-6h6v6"/></svg><span>Petrol</span><small>Fuel</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M12 2a10 10 0 0 1 10 10c0 4-2.5 7.4-6 9"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10"/></svg><span>AC</span><small>Climate</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/></svg><span>4 Doors</span><small>Body</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg><span>2022</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 4,500 <small>/ day</small></div>
                <a href="<%= request.getContextPath() %>/user?section=bookings" class="button">Book Now <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a>
              </div>
            </div>
          </div>

          <%-- Panel: Toyota Noah --%>
          <div class="deal_panel" id="panel-noah">
            <div class="deal_image">
              <img src="<%= request.getContextPath() %>/Assets/range-2.jpg" alt="Toyota Noah" />
            </div>
            <div class="deal_info">
              <h3>Toyota Noah</h3>
              <p class="deal_tagline">Spacious MPV — perfect for families &amp; groups</p>
              <div class="deal_specs">
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg><span>8</span><small>Seats</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/><path d="M4.93 4.93a10 10 0 0 0 0 14.14"/></svg><span>Auto</span><small>Transmission</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M3 22V8l9-6 9 6v14"/><path d="M9 22v-6h6v6"/></svg><span>Petrol</span><small>Fuel</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M12 2a10 10 0 0 1 10 10c0 4-2.5 7.4-6 9"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10"/></svg><span>Dual AC</span><small>Climate</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/></svg><span>Sliding</span><small>Door</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg><span>2021</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 7,000 <small>/ day</small></div>
                <a href="<%= request.getContextPath() %>/user?section=bookings" class="button">Book Now <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a>
              </div>
            </div>
          </div>

          <%-- Panel: Mitsubishi Pajero --%>
          <div class="deal_panel" id="panel-pajero">
            <div class="deal_image">
              <img src="<%= request.getContextPath() %>/Assets/range-3.jpg" alt="Mitsubishi Pajero" />
            </div>
            <div class="deal_info">
              <h3>Mitsubishi Pajero</h3>
              <p class="deal_tagline">Rugged 4WD SUV — built for mountain terrain</p>
              <div class="deal_specs">
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg><span>7</span><small>Seats</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/><path d="M4.93 4.93a10 10 0 0 0 0 14.14"/></svg><span>Manual</span><small>Transmission</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M3 22V8l9-6 9 6v14"/><path d="M9 22v-6h6v6"/></svg><span>Diesel</span><small>Fuel</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><circle cx="5" cy="17" r="3"/><circle cx="19" cy="17" r="3"/><path d="M5 14V9l7-5 7 5v5"/></svg><span>4WD</span><small>Drive</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/></svg><span>SUV</span><small>Body</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg><span>2020</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 9,500 <small>/ day</small></div>
                <a href="<%= request.getContextPath() %>/user?section=bookings" class="button">Book Now <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a>
              </div>
            </div>
          </div>

          <%-- Panel: Suzuki Swift --%>
          <div class="deal_panel" id="panel-swift">
            <div class="deal_image">
              <img src="<%= request.getContextPath() %>/Assets/range-4.jpg" alt="Suzuki Swift" />
            </div>
            <div class="deal_info">
              <h3>Suzuki Swift</h3>
              <p class="deal_tagline">Compact hatchback — nimble &amp; fuel efficient</p>
              <div class="deal_specs">
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg><span>5</span><small>Seats</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93a10 10 0 0 1 0 14.14"/><path d="M4.93 4.93a10 10 0 0 0 0 14.14"/></svg><span>Manual</span><small>Transmission</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M3 22V8l9-6 9 6v14"/><path d="M9 22v-6h6v6"/></svg><span>Petrol</span><small>Fuel</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><path d="M12 2a10 10 0 0 1 10 10c0 4-2.5 7.4-6 9"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10"/></svg><span>AC</span><small>Climate</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2"/></svg><span>Hatchback</span><small>Body</small></div>
                <div class="spec"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg><span>2023</span><small>Year</small></div>
              </div>
              <div class="deal_price_row">
                <div class="deal_price">NPR 3,500 <small>/ day</small></div>
                <a href="<%= request.getContextPath() %>/user?section=bookings" class="button">Book Now <svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></a>
              </div>
            </div>
          </div>

        </div>
      </div>
    </section>

    <%-- ========== WHY CHOOSE US ========== --%>
    <section class="choose_container" id="choose">
      <div class="choose_image">
        <img src="<%= request.getContextPath() %>/Assets/why choosed us.jpeg" alt="Happy customer with car" />
      </div>
      <div class="choose_content">
        <h2 class="section_header">Why choose us</h2>
        <p class="section_description">
          Discover the difference with our car rental service. We offer reliable
          vehicles, exceptional customer service, and competitive pricing.
        </p>
        <div class="choose_grid">
          <div class="choose_card">
            <span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 18v-6a9 9 0 0 1 18 0v6"/><path d="M21 19a2 2 0 0 1-2 2h-1a2 2 0 0 1-2-2v-3a2 2 0 0 1 2-2h3z"/><path d="M3 19a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-3a2 2 0 0 0-2-2H3z"/></svg></span>
            <div><h4>Customer Support</h4><p>Our dedicated support team is available to assist you 24/7.</p></div>
          </div>
          <div class="choose_card">
            <span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg></span>
            <div><h4>Many Locations</h4><p>Convenient pick-up and drop-off locations to suit your travel needs.</p></div>
          </div>
          <div class="choose_card">
            <span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="5" width="20" height="14" rx="2"/><line x1="2" y1="10" x2="22" y2="10"/><circle cx="17" cy="15" r="1" fill="#2563eb"/></svg></span>
            <div><h4>Best Price</h4><p>Enjoy competitive rates and great value for every rental.</p></div>
          </div>
          <div class="choose_card">
            <span><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/><line x1="10" y1="15" x2="14" y2="19"/><line x1="14" y1="15" x2="10" y2="19"/></svg></span>
            <div><h4>Free Cancellations</h4><p>Flexible bookings with free cancellation options.</p></div>
          </div>
        </div>
      </div>
    </section>

    <%-- ========== SUBSCRIBE ========== --%>
    <section class="subscribe_container">
      <div class="subscribe_image">
        <img src="<%= request.getContextPath() %>/Assets/ford-raptor-r-concept-1.jpg" alt="Newsletter car" />
      </div>
      <div class="subscribe_content">
        <h2 class="section_header">Subscribe for the latest car rental updates</h2>
        <p class="section_description">
          Stay in the know! Subscribe to receive the latest car rental deals,
          exclusive offers, and updates right to your inbox.
        </p>
        <div class="subscribe_form">
          <input type="email" placeholder="Enter your email address" />
          <button type="button" class="button">Subscribe</button>
        </div>
      </div>
    </section>

    <%-- ========== TESTIMONIALS ========== --%>
    <section class="section_container client_container" id="client">
      <h2 class="section_header">What people say about us</h2>
      <p class="section_description">Discover why our customers love renting with us!</p>
      <div class="client_grid">
        <div class="client_card">
          <div class="client_details">
            <img src="<%= request.getContextPath() %>/Assets/images.jpeg" alt="Kushal Khanal" class="client_avatar" />
            <div>
              <h4>Kushal Khanal</h4>
              <div class="client_rating">
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-empty" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
              </div>
            </div>
          </div>
          <p>Affordable prices and great selection of vehicles! I found exactly what I needed, and the pick-up and drop-off process was seamless.</p>
        </div>
        <div class="client_card">
          <div class="client_details">
            <img src="<%= request.getContextPath() %>/Assets/images.jpeg" alt="Rehan Basnet" class="client_avatar" />
            <div>
              <h4>Rehan Basnet</h4>
              <div class="client_rating">
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-empty" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
              </div>
            </div>
          </div>
          <p>The flexibility of free cancellations made my trip stress-free. Great service overall — will definitely rent again!</p>
        </div>
        <div class="client_card">
          <div class="client_details">
            <img src="<%= request.getContextPath() %>/Assets/images.jpeg" alt="Rojal Shrestha" class="client_avatar" />
            <div>
              <h4>Rojal Shrestha</h4>
              <div class="client_rating">
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                <svg class="star-fill" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
              </div>
            </div>
          </div>
          <p>Excellent vehicles and very professional staff. The booking process was quick and the car was in perfect condition.</p>
        </div>
      </div>
    </section>

    <%-- ========== FOOTER ========== --%>
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
            <a href="#" aria-label="Facebook"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/></svg></a>
            <a href="#" aria-label="Instagram"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"/><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"/><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"/></svg></a>
            <a href="#" aria-label="Twitter / X"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg></a>
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
            <li><a href="tel:+9779818162494"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M6.62 10.79a15.05 15.05 0 0 0 6.59 6.59l2.2-2.2a1 1 0 0 1 1.02-.24 11.44 11.44 0 0 0 3.58.57 1 1 0 0 1 1 1V20a1 1 0 0 1-1 1A17 17 0 0 1 3 4a1 1 0 0 1 1-1h3.5a1 1 0 0 1 1 1c0 1.25.2 2.45.57 3.58a1 1 0 0 1-.25 1.01z"/></svg>+977 9818162494</a></li>
            <li><a href="#"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"/></svg>Kathmandu, Nepal</a></li>
            <li><a href="mailto:kushal@gmail.com"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>kushal@gmail.com</a></li>
          </ul>
        </div>
      </div>
      <div class="footer_bottom">&copy; 2024 RentAll. All rights reserved.</div>
    </footer>

    <script>
      // ── Hamburger menu toggle ──
      const menuBtn = document.querySelector('.nav_menu_button');
      const navLinks = document.getElementById('nav-links');
      if (menuBtn && navLinks) {
        menuBtn.addEventListener('click', () => navLinks.classList.toggle('active'));
      }

      // ── User dropdown toggle ──
      const avatarWrap = document.getElementById('userAvatarWrap');
      const dropdown   = document.getElementById('userDropdown');
      if (avatarWrap && dropdown) {
        avatarWrap.addEventListener('click', function(e) {
          e.stopPropagation();
          dropdown.classList.toggle('open');
        });
        // Close when clicking outside
        document.addEventListener('click', function() {
          dropdown.classList.remove('open');
        });
      }
    </script>

  </body>
</html>
