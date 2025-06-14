<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://unpkg.com/purecss@3.0.0/build/pure-min.css" />
    <style>
    body {
      font-family: sans-serif;
      padding: 2em;
      background-color: #f7f7f7;
    }

    form {
      background-color: #fff;
      border-radius: 8px;
      padding: 1.5em;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      max-width: 500px;
      margin: 0 auto;
    }

    .pure-form label {
      display: block;
      font-weight: bold;
      margin-top: 1em;
      margin-bottom: 0.5em;
    }

    .pure-form input[type="text"],
    .pure-form input[type="number"] {
      display: block;
      width: 100%;
      padding: 0.5em;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    img {
      width: 100%;
      height: auto;
      max-width: 100%;
      border-radius: 4px;
      margin-bottom: 1em;
    }

    .readonly-field {
      display: block;
      padding: 0.5em;
      background-color: #e9e9e9;
      border-radius: 4px;
      margin-bottom: 1em;
    }

    button {
      margin-top: 1.5em;
      padding: 0.75em 1.5em;
      background-color: #1f8dd6;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    button:hover {
      background-color: #106BA3;
    }
  </style>
    <title>Login</title>
</head>
<body>
    

    <#if error??>
        <p style="color:red;">Invalid username or password.</p>
    </#if>

    <form class="pure-form" action="/login" method="post">
        <h2>Real Estate Direct</h2>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div>
            <input type="text" name="username" placeholder="Username" required>
        </div>
        <div>
            <input type="password" name="password" placeholder="Password" required>
        </div>
        <div>
            <button type="submit">Sign in</button>
        </div>
        <p>
            Don't have an account? <a href="/users/register/registeruser">Register here</a>
        </p>
    </form>

</body>
</html>
