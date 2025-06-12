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

    .pure-form input[type="text"] {
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
    <form class="pure-form" id="offerForm" method="post" action="/api/offers/create/${property.propertyId}">
      <img src="images/front.png" alt="Property Image" />
      <label>Asking Price</label>
      <div class="readonly-field">${property.askingPrice}</div>
      <input type="number" name="userId" value="${currentUser.userId}" hidden />
      <input type="number" name="propertyId" value="${property.propertyId}" hidden />
      <input type="number" name="AskingPrice" value="${property.askingPrice}" hidden />
      <label>Good Faith Deposit</label>
      <input type="text" name="goodFaithDeposit" value="${property.goodFaithDeposit}" placeholder="Good Faith Deposit" />
      <label>Offering Price</label>
      <input type="number" name="offerPrice" placeholder="Offering Price" required />
      <button type="submit" class="pure-button pure-button-primary">Submit Offer</button>
    </form>
  </div>

</body>
</html>
