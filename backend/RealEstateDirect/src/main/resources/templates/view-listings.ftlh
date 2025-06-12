<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Listings</title>
  <link rel="stylesheet" href="https://unpkg.com/purecss@3.0.0/build/pure-min.css">
  <style>
    body {
      font-family: sans-serif;
      padding: 2em;
      margin: 0;
    }

    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
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

    input {
      margin-bottom: 1.5em;
      padding: 0.5em;
      width: 100%;
      max-width: 300px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }

    strong {
      display: inline-block;
      min-width: 130px;
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
    
    .empty-message {
      text-align: center;
      padding: 2em;
      grid-column: 1 / -1;
      color: #666;
    }
    
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1em;
    }
  </style>
</head>
<body>
  <div>
    <div class="header">
      <h1 class="text-2xl font-bold mb-4">Property Listings</h1>
    </div>
    
    <input type="text" id="zipFilter" placeholder="Filter by ZIP code" />
    
    <div id="listings" class="grid">
      <#if properties?? && properties?size gt 0>
        <#list properties as property>
          <div class="card" data-zipcode="${property.zipCode!''}" data-city="${property.city!''}" 
               data-state="${property.state!''}">
            <#if property.images?? && property.images?size gt 0>
              <img src="${property.images[0].path}" alt="Property image" />
            <#else>
              <div class="no-image">No image available</div>
            </#if>
            
            <p><strong>Location:</strong> ${property.city!''}, ${property.state!''}</p>
            <p><strong>ZIP Code:</strong> ${property.zipCode!''}</p>
            <p><strong>Asking Price:</strong> $${property.askingPrice?string(",##0.00")}</p>
            <p><strong>Good Faith Deposit:</strong> $${property.goodFaithDeposit?string(",##0.00")}</p>
            
            <div style="display: flex; flex-direction: column; gap: 10px;">
              <a href="/api/properties/${property.propertyId}" class="pure-button">View Details</a>
              <#if currentUser?? && currentUser.role?? && currentUser.role == 1> <!-- Assuming role 1 is for buyers -->
                <a href="/api/offers/create/${property.propertyId}?userId=${currentUser.userId}" class="pure-button pure-button-primary">Make Offer</a>
              </#if>
            </div>
          </div>
        </#list>
      <#else>
        <div class="empty-message">
          <p>No properties available at this time.</p>
        </div>
      </#if>
    </div>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const zipFilter = document.getElementById('zipFilter');
      const cards = document.querySelectorAll('.card');
      
      zipFilter.addEventListener('input', function() {
        const filterVal = this.value.toLowerCase();
        
        cards.forEach(card => {
          const zipCode = card.dataset.zipcode.toLowerCase();
          const city = card.dataset.city.toLowerCase();
          const state = card.dataset.state.toLowerCase();
          
          if (zipCode.includes(filterVal) || city.includes(filterVal) || state.includes(filterVal)) {
            card.style.display = '';
          } else {
            card.style.display = 'none';
          }
        });
      });
    });
  </script>
</body>
</html>