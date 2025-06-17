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
              <p><strong>Asking Price:</strong> ${offer.property.askingPrice?string(",##0.00")}</p>
              <form class="pure-form" id="offerForm" method="post" action="/api/offers/update">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="number" name="userId" value="${currentUser.userId}" hidden />
                <input type="number" name="propertyId" value="${offer.property.propertyId}" hidden />
                <input type="number" name="offerId" value="${offer.offerId}" hidden />
                
                <#if currentUser?? && currentUser.role?? && currentUser.role == 1> 
                  <#if offer?? && offer.counterOfferPrice??>
                    <p><strong>Counter Offer:</strong> ${offer.counterOfferPrice?string(",##0.00")}</p>
                    <input type="text" name="counterOfferPrice" id="counterOfferPrice" value="${offer.counterOfferPrice?string('#,##0.##')}" hidden />
                  </#if>                                 

                  <label><strong>Good Faith Deposit:</strong></label>
                  <input type="text" name="goodFaithDeposit" id="goodFaithDeposit" value="${offer.goodFaithDeposit?string('#,##0.##')}" placeholder="Good Faith Deposit" <#if offer.status == "Accepted">disabled</#if> />
                  <br>
                  <label><strong>Offering Price:</strong></label>
                  <input type="text" name="offerPrice" id="offerPrice" value="${offer.offerPrice?string('#,##0.##')}" placeholder="Offering Price" <#if offer.status == "Accepted">disabled</#if> required />
                  <input type="text" name="status" value="Offer" hidden />
                  <button type="submit" class="pure-button pure-button-primary" <#if offer.status == "Accepted">disabled</#if>>Update Offer</button>
                  <br><br>
                  <#if offer.status == "Accepted">
                  <label><strong>Accepted Price: ${offer.offerPrice}</strong></label>
                  </#if>
                  <br>
                <#elseif currentUser?? && currentUser.role?? && currentUser.role == 2>
                  <p><strong>Good Faith Deposit:</strong> ${offer.goodFaithDeposit?string("#,##0.##")}</p>
                  <p><strong>Offering Price:</strong> ${offer.offerPrice?string(",##0.##")}</p>
                  <label><strong>Counter Offer:</strong></label>

                  <input type="text" name="goodFaithDeposit" id="goodFaithDeposit" value="${offer.goodFaithDeposit?string('#,##0.##')}" hidden />
                  <input type="text" name="offerPrice" id="offerPrice" value="${offer.offerPrice?string('#,##0.##')}" hidden />

                  <input type="text" name="status" value="Counter" hidden />
                  <input type="text" name="counterOfferPrice" id="counterOfferPrice" value="${(offer.counterOfferPrice!0)?string('#,##0.##')}" placeholder="Counter Offer" <#if offer.status == "Accepted">disabled</#if> />
                  <br><br>
                  <button type="submit" class="pure-button pure-button-primary" <#if offer.status == "Accepted">disabled</#if>>Make Counter Offer</button>
                  <br><br>
                  <a  href="/api/offers/accept/${offer.offerId}" class="pure-button pure-button-primary" <#if offer.status == "Accepted">disabled</#if>>Accept Offer</a>
                  <br><br>
                  <#if offer.status == "Accepted">
                  <label><strong>Accepted Price: ${offer.offerPrice}</strong></label>
                  </#if>
                  <br>
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
      sanitizeNumericField(document.getElementById("counterOfferPrice"));
    });
  </script>
</body>
</html>

