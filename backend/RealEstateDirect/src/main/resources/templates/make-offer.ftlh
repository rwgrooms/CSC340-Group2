<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Make Offer</title>
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
</head>
<body>
  <div id="root">
    <form class="pure-form" id="offerForm" method="post" action="/api/offers/create">
      <img src="${property.images[0].path}" alt="Property image" />
      <label>Asking Price</label>
      <div class="readonly-field">${property.askingPrice}</div>
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <input type="number" name="userId" value="${currentUser.userId}" hidden />
      <input type="number" name="propertyId" value="${property.propertyId}" hidden />
      <input type="text" name="status" value="Offer" hidden />
      <input type="text" name="AskingPrice" id="askingPrice" value="${property.askingPrice}" hidden />
      <label>Good Faith Deposit</label>
      <input type="text" name="goodFaithDeposit" id="goodFaithDeposit" value="${property.goodFaithDeposit}" placeholder="Good Faith Deposit" />
      <label>Offering Price</label>
      <input type="text" name="offerPrice" id="offerPrice" placeholder="Offering Price" required />
      <button type="submit" class="pure-button pure-button-primary">Submit Offer</button>
    </form>
  </div>
  
  <script>
  
    function sanitizeNumericField(field) {
      if (!field) return;
      let raw = field.value;
      raw = raw.replace(/[^0-9.]/g, ''); // keep only digits and dot
      const parts = raw.split('.');
      if (parts.length > 2) {
        // if multiple dots, keep only first
        raw = parts[0] + '.' + parts.slice(1).join('');
      }
      field.value = raw;
    }

    document.getElementById("offerForm").addEventListener("submit", function () {
      sanitizeNumericField(document.getElementById("askingPrice"));
      sanitizeNumericField(document.getElementById("goodFaithDeposit"));
      sanitizeNumericField(document.getElementById("offerPrice"));
    });
  </script>
</body>
</html>
