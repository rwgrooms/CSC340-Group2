<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Register</title>
  <link rel="stylesheet" href="https://unpkg.com/purecss@3.0.0/build/pure-min.css">
  <style>
    body {
      padding: 2em;
      max-width: 800px;
      margin: auto;
    }
    h2 {
      text-align: center;
    }
    .pure-form input[type="text"],
    .pure-form input[type="email"],
    .pure-form input[type="tel"],
    .pure-form input[type="number"],
    .pure-form input[type="password"] {
      width: 100%;
    }
    .radio-group {
      margin-top: 2em;
    }
    .pure-g > div {
      box-sizing: border-box;
    }
  </style>
</head>
<body>

  <h2>Register</h2>

<form class="pure-form pure-form-stacked" method="post" action="/users/register/createuser">
    <div class="pure-g">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <!-- Left Column -->
      <div class="pure-u-1-2" style="padding-right: 1em;">
        <label for="firstName">First Name</label>
      <input id="firstName" name="firstName" type="text" placeholder="First Name" required>

        <label for="phoneNumber">Phone Number</label>
      <input id="phoneNumber" name="phoneNumber" type="tel" placeholder="123-456-7890" required>

      </div>

      <!-- Right Column -->
      <div class="pure-u-1-2" style="padding-left: 1em;">
        <label for="lastName">Last Name</label>
      <input id="lastName" name="lastName" type="text" placeholder="Last Name" required>

        <label for="email">Email</label>
      <input id="email" name="email" type="email" placeholder="you@example.com" required>

      </div>

    </div>

    <!-- Full-width fields, outside of column division -->
    <label for="userName" style="margin-top: 1em;">Username</label>
  <input id="userName" name="userName" type="text" placeholder="Choose a username" required>

    <label for="password">Password</label>
  <input id="password" name="password" type="password" placeholder="Create a password" required>

    <div class="radio-group">
    <label>I&apos;m registering as:</label>
      <label class="pure-radio"><input type="radio" name="role" value="1" required> Buyer</label>
      <label class="pure-radio"><input type="radio" name="role" value="2"> Seller</label>
    </div>

    <div style="margin-top: 1.5em;">
    <button type="submit" class="pure-button pure-button-primary">Register</button>
    <a href="/login.html" class="pure-button">Back to Login</a>
    </div>
  </form>

</body>
</html>

