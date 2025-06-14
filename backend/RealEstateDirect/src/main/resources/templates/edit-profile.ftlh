<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Profile</title>
  <link rel="stylesheet" href="https://unpkg.com/purecss@3.0.0/build/pure-min.css">
  <style>
    body {
      font-family: sans-serif;
      padding: 2em;
      margin: 0;
    }

    .pure-form input[type="text"],
    .pure-form input[type="email"],
    .pure-form input[type="tel"],
    .pure-form input[type="number"],
    .pure-form input[type="password"] {
      width: 100%;
    }

    .pure-g > div {
      box-sizing: border-box;
    }

    .radio-group {
      margin-top: 2em;
    }

    .button-group {
      margin-top: 2em;
      text-align: center;
    }

    .pure-button-danger {
      background: #e00;
      color: white;
    }

    .pure-button-danger:hover {
      background: #c00;
    }
  </style>
</head>
<body>

  <h2>Edit Profile</h2>

  <form class="pure-form pure-form-stacked" id="editForm" method="post" action="/users/register/updateuser">
    <div class="pure-g">
      <div class="pure-u-1-2" style="padding-right: 1em;">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input id="userId" name="userId" value="${user.userId}" hidden>
        <label for="firstName">First Name</label>
        <input id="firstName" name="firstName" type="text" value="${user.firstName}" placeholder="First Name" required>

        <label for="phoneNumber">Phone Number</label>
        <input id="phoneNumber" name="phoneNumber" type="tel" value="${user.phoneNumber}" placeholder="123-456-7890" required>

      </div>

      <div class="pure-u-1-2" style="padding-left: 1em;">
        <label for="lastName">Last Name</label>
        <input id="lastName" name="lastName" type="text" value="${user.lastName}" placeholder="Last Name" required>

        <label for="email">Email</label>
        <input id="email" name="email" type="email" value="${user.email}" placeholder="you@example.com" required>
      </div>
    </div>

    <label for="userName" style="margin-top: 1em;">Username</label>
    <input id="userName" name="userName" type="text" value="${user.userName}" placeholder="Choose a username" required>

    <label for="password">Password</label>
    <input id="password" name="password" type="password" placeholder="Create a password" required>

<div class="radio-group">
  <label>I'm registered as:</label>
  <label class="pure-radio"><input type="radio" name="role" value="1" <#if user.role == 1>checked</#if>>Buyer</label>
  <label class="pure-radio"><input type="radio" name="role" value="2" <#if user.role == 2>checked</#if>>Seller</label>
</div>

    <div class="button-group">
      <button type="submit" class="pure-button pure-button-primary">Save</button>
      <a href="/users/register/deleteuser/${user.userId}" class="pure-button pure-button-danger" onclick="return confirm('Are you sure? This will remove your access?');">
        Delete Profile
      </a>
    </div>
  </form>

  
</body>
</html>
