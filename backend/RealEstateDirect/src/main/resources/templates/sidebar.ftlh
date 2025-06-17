<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://unpkg.com/purecss@3.0.0/build/pure-min.css">
  <style>
    .menu-section {
      margin-bottom: 2em;
    }
    .menu-section h3 {
      font-size: 1.1em;
      border-bottom: 1px solid #ccc;
      padding-bottom: 0.25em;
    }
    .pure-menu a {
      color: #333;
      text-decoration: none;
      display: block;
      padding: 0.3em 0;
    }
    .pure-menu a:hover {
      background-color: #0078e7;
      color: white;
    }
    html, body {
      margin: 0;
      padding: 0;
      height: 100%;
      overflow: hidden;
      font-family: sans-serif;
      background-color: #f2f2f2;
    }
    .sidebar-wrapper {
      display: flex;
      flex-direction: column;
      height: 100%;
      padding: 1em;
      box-sizing: border-box;
    }
  </style>
</head>
<body>
   <div class="sidebar-wrapper" style="display: flex; flex-direction: column; height: 100%;">
    <nav style="flex: 1;">
    <div class="menu-section">
      <h3>Main Menu</h3>
      <ul class="pure-menu-list">
        <li class="pure-menu-item"><a href="/users/register/edituser/${user.userId}" target="mainContent" class="pure-menu-link">Edit Profile</a></li>
        <li class="pure-menu-item"><a href="/api/offers/myoffers/${user.userId}" target="mainContent" class="pure-menu-link">View Offers</a></li>
        <li class="pure-menu-item"><a href="/chat" target="mainContent" class="pure-menu-link">Chat Real Estate</a></li>
    </ul>
    </div>
      <#if user?? && user.role?? && user.role == 2>
        <div class="menu-section">
          <h3>Seller</h3>
          <ul class="pure-menu-list">
            <li class="pure-menu-item"><a href="/api/properties/create/${user.userId}" target="mainContent" class="pure-menu-link">List Property</a></li>
            <li class="pure-menu-item"><a href="/api/properties/listings/${user.userId}" target="mainContent" class="pure-menu-link">View Listings</a></li>
          </ul>
        </div>
    </#if>
      <#if user?? && user.role?? && user.role == 1>
      <div class="menu-section">
        <h3>Buyer</h3>
        <ul class="pure-menu-list">
          <li class="pure-menu-item"><a href="/api/properties/listings/${user.userId}" target="mainContent" class="pure-menu-link">View Listings</a></li>
        </ul>
      </div>
    </#if>
  </nav>
<div class="logout-section" style="padding-top: 1em;">
      <ul class="pure-menu-list">
        <li class="pure-menu-item">
          <form id="logoutForm" method="post" action="/logout" target="_top" style="margin: 0;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="submit" class="pure-menu-link" style="background: none; border: none; padding: 0; text-align: left; width: 100%; cursor: pointer;">
              <strong>Logout</strong>
            </button>
          </form>
        </li>
      </ul>
    </div>
  </div>
</body>
</html>

