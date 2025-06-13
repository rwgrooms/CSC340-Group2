<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Offers</title>
  <link rel="stylesheet" href="https://unpkg.com/purecss@3.0.0/build/pure-min.css">
  <style>
    body {
      font-family: sans-serif;
      padding: 2em;
    }

     .grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
      gap: 1.5em;
    }

   .card {
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      min-height: 400px; /* or whatever fits your layout */
      padding: 1em;
      border: 1px solid #ddd;
      border-radius: 6px;
      background: #fff;
    }


    .card img {
      width: 100%;
      height: 160px;
      object-fit: cover;
      border-radius: 4px;
      margin-bottom: 0.75em;
    }

    strong {
      display: inline-block;
      min-width: 150px;
    }

    
    .no-image {
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: #f5f5f5;
      color: #888;
      height: 160px;
      font-style: italic;
    }
  </style>
</head>
<body>
  <div>
    <div class="header">
      <h1 class="text-2xl font-bold mb-4">View Offers</h1>
    </div>
    
    <div id="listings" class="grid">
        <#list offers as offer>
          <div class="card">
            <#if offer.property.images?? && offer.property.images?size gt 0>
              <img src="${offer.property.images[0].path}" alt="Property image" />
            <#else>
              <div class="no-image">No image available</div>
            </#if>
              <p><strong>Location:</strong> ${offer.property.city!''}, ${offer.property.state!''}</p>
              <p><strong>ZIP Code:</strong> ${offer.property.zipCode!''}</p>
              <p><strong>Asking Price:</strong> $${offer.property.askingPrice?string(",##0.00")}</p>
              <form class="pure-form" id="offerForm" method="post" action="/api/offers/update">
                <input type="number" name="userId" value="${currentUser.userId}" hidden />
                <input type="number" name="propertyId" value="${offer.property.propertyId}" hidden />
                <input type="number" name="offerId" value="${offer.offerId}" hidden />
                <label><strong>Good Faith Deposit:</strong></label>
                <input type="text" name="goodFaithDeposit" id="goodFaithDeposit" value="${offer.goodFaithDeposit}" placeholder="Good Faith Deposit" />
                <br>
                <label><strong>Offering Price:</strong></label>
                <input type="text" name="offerPrice" id="offerPrice" value="${offer.offerPrice}" placeholder="Offering Price" required />
                <#if currentUser?? && currentUser.role?? && currentUser.role == 1> <!-- Assuming role 1 is for buyers -->
                          <button type="submit" class="pure-button pure-button-primary">Update Offer</button>
                </#if>
              </form>
          </div>
        </#list>
    </div>
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
      sanitizeNumericField(document.getElementById("goodFaithDeposit"));
      sanitizeNumericField(document.getElementById("offerPrice"));
    });
  </script>
</body>
</html>

