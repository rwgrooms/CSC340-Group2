<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Property Details</title>
  <link rel="stylesheet" href="https://unpkg.com/purecss@3.0.0/build/pure-min.css" />
  <style>
    body {
      font-family: sans-serif;
      padding: 2em;
      max-width: 1200px;
      margin: 0 auto;
    }
    
    .property-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1.5em;
      border-bottom: 1px solid #eee;
      padding-bottom: 1em;
    }
    
    .property-header h1 {
      margin: 0;
      font-size: 1.8em;
    }
    
    .property-price {
      font-size: 1.5em;
      font-weight: bold;
      color: #0078e7;
    }
    
    .property-layout {
      display: grid;
      grid-template-columns: 60% 40%;
      gap: 2em;
    }
    
    .image-gallery {
      margin-bottom: 2em;
    }
    
    .main-image {
      width: 100%;
      height: 400px;
      object-fit: cover;
      border-radius: 8px;
      margin-bottom: 1em;
    }
    
    .thumbnail-container {
      display: flex;
      gap: 1em;
      overflow-x: auto;
      padding-bottom: 1em;
    }
    
    .thumbnail {
      width: 100px;
      height: 100px;
      object-fit: cover;
      border-radius: 4px;
      cursor: pointer;
      border: 2px solid transparent;
    }
    
    .thumbnail:hover {
      border-color: #0078e7;
    }
    
    .property-details {
      display: flex;
      flex-direction: column;
      gap: 1em;
    }
    
    .detail-section {
      margin-bottom: 1.5em;
    }
    
    .detail-section h3 {
      margin-top: 0;
      margin-bottom: 0.5em;
      border-bottom: 1px solid #eee;
      padding-bottom: 0.5em;
    }
    
    .address-block {
      margin-bottom: 1em;
    }
    
    .description {
      line-height: 1.6;
      white-space: pre-line;
    }
    
    .seller-info {
      background-color: #f8f8f8;
      padding: 1em;
      border-radius: 6px;
    }
    
    .action-buttons {
      display: flex;
      gap: 1em;
      margin-top: 2em;
    }
    
    @media (max-width: 768px) {
      .property-layout {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
  <div class="property-container">
    <div class="property-header">
      <h1>Property Details</h1>
      <div class="property-price">$${property.askingPrice?string(',##0.00')}</div>
    </div>
    
    <div class="property-layout">
      <div class="image-section">
        <div class="image-gallery">
          <#if property.images?? && property.images?size gt 0>
            <img id="mainImage" class="main-image" src="${property.images[0].path}" alt="Property image">
            <div class="thumbnail-container">
              <#list property.images as image>
                <img class="thumbnail" src="${image.path}" alt="Property thumbnail" 
                     onclick="document.getElementById('mainImage').src='${image.path}'">
              </#list>
            </div>
          <#else>
            <div class="main-image" style="background-color: #eee; display: flex; align-items: center; justify-content: center;">
              <p>No images available</p>
            </div>
          </#if>
        </div>
        
        <div class="detail-section">
          <h3>Description</h3>
          <p class="description">${property.description}</p>
        </div>
      </div>
      
      <div class="property-details">
        <div class="detail-section">
          <h3>Location</h3>
          <div class="address-block">
            <p>${property.addressLine1}</p>
            <#if property.addressLine2?? && property.addressLine2 != "">
              <p>${property.addressLine2}</p>
            </#if>
            <p>${property.city}, ${property.state} ${property.zipCode}</p>
          </div>
        </div>
        
        <div class="detail-section">
          <h3>Financial Details</h3>
          <table class="pure-table pure-table-striped" style="width: 100%;">
            <tbody>
              <tr>
                <td>Asking Price</td>
                <td>$${property.askingPrice?string(',##0.00')}</td>
              </tr>
              <#if property.goodFaithDeposit??>
              <tr>
                <td>Good Faith Deposit</td>
                <td>$${property.goodFaithDeposit?string(',##0.00')}</td>
              </tr>
              </#if>
            </tbody>
          </table>
        </div>
        
        <div class="detail-section">
          <h3>Seller Information</h3>
          <div class="seller-info">
            <#if property.seller??>
              <p><strong>Name:</strong> ${property.seller.firstName!''} ${property.seller.lastName!''}</p>
              <p><strong>Contact:</strong> ${property.seller.email!''}</p>
            <#else>
              <p>Seller information not available</p>
            </#if>
          </div>
        </div>
        
        <!-- Action Buttons -->
        <div class="action-buttons">
          <a href="/properties" class="pure-button">Back to Listings</a>
          <!-- Additional buttons would go here based on user role:
               - Make Offer (for buyers)
               - Edit/Delete (for sellers or admins) -->
          <a href="/api/properties/edit/${property.propertyId}" class="pure-button pure-button-primary">Edit Property</a>
          <a href="/api/properties/delete/${property.propertyId}" class="pure-button" 
             onclick="return confirm('Are you sure you want to delete this property?');"
             style="background-color: #e74c3c; color: white;">Delete</a>
        </div>
      </div>
    </div>
  </div>
  
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // Image gallery functionality can be added here
      const thumbnails = document.querySelectorAll('.thumbnail');
      const mainImage = document.getElementById('mainImage');
      
      thumbnails.forEach(thumbnail => {
        thumbnail.addEventListener('click', function() {
          mainImage.src = this.src;
        });
      });
    });
  </script>
</body>
</html>