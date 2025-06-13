<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://unpkg.com/purecss@3.0.0/build/pure-min.css">
  <style>
    body {
      margin: 0;
      padding: 1em;
      font-family: sans-serif;
      background-color: #f2f2f2;
    }

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
  </style>
</head>
<body>

  <nav>
    <div class="menu-section">
      <h3>Main Menu</h3>
      <ul class="pure-menu-list">
        <li class="pure-menu-item"><a href="/users/register/edituser/${user.userId}" target="mainContent" class="pure-menu-link">Edit Profile</a></li>
        <li class="pure-menu-item"><a href="/api/offers/${user.userId}" target="mainContent" class="pure-menu-link">View Offers</a></li>
    </ul>
    </div>
    <#if user?? && user.role?? && user.role == 2> <!-- Assuming role 2 is for seller -->
        <div class="menu-section">
          <h3>Seller</h3>
          <ul class="pure-menu-list">
            <li class="pure-menu-item"><a href="/api/properties/create/${user.userId}" target="mainContent" class="pure-menu-link">List Property</a></li>
            <li class="pure-menu-item"><a href="/api/properties/listings/${user.userId}" target="mainContent" class="pure-menu-link">View Listings</a></li>
          </ul>
        </div>
    </#if>
    <#if user?? && user.role?? && user.role == 1> <!-- Assuming role 1 is for buyer -->
      <div class="menu-section">
        <h3>Buyer</h3>
        <ul class="pure-menu-list">
          <li class="pure-menu-item"><a href="/api/properties/listings/${user.userId}" target="mainContent" class="pure-menu-link">View Listings</a></li>
        </ul>
      </div>
    </#if>
  </nav>

</body>
</html>
