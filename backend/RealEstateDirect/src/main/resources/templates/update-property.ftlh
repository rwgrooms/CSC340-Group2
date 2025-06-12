<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Update Property</title>
  <link rel="stylesheet" href="https://unpkg.com/purecss@3.0.0/build/pure-min.css" />
  <style>
    body {
      font-family: sans-serif;
      padding: 2em;
    }

    input, .drop-area {
      width: 100%;
      padding: 0.5em;
      margin-bottom: 1em;
      box-sizing: border-box;
    }

    textarea {
      width: 100%;
    }

    .drop-area {
      border: 2px dashed #ccc;
      border-radius: 5px;
      text-align: center;
      padding: 1em;
      cursor: pointer;
      background-color: #fafafa;
    }

    .drop-area:hover {
      border-color: #0078e7;
      background-color: #f0f8ff;
    }

    .preview {
      display: flex;
      flex-wrap: wrap;
      gap: 1em;
      margin-top: 1em;
    }

    .preview img {
      width: 100px;
      height: 100px;
      object-fit: cover;
      border-radius: 6px;
      border: 1px solid #ccc;
    }
    
    .existing-images {
      margin-bottom: 1em;
    }
    
    .existing-images h3 {
      margin-bottom: 0.5em;
    }
    
    .existing-image {
      position: relative;
      display: inline-block;
      margin-right: 1em;
      margin-bottom: 1em;
    }
    
    .existing-image img {
      width: 120px;
      height: 120px;
      object-fit: cover;
      border-radius: 6px;
      border: 1px solid #ddd;
    }
  </style>
</head>
<body>
  <div>
    <h1>Update Property Listing</h1>
    
    <form class="pure-form pure-form-stacked" action="/api/properties/update" method="post" enctype="multipart/form-data">
      <!-- Hidden fields for IDs -->
      <input type="hidden" id="propertyId" name="propertyId" value="${property.propertyId}">
      <input type="hidden" id="seller.userId" name="seller.userId" value="${property.seller.userId}">
      
      <label for="addressLine1">Address Line 1</label>
      <input type="text" id="addressLine1" name="addressLine1" value="${property.addressLine1!''}" placeholder="Street address" required />

      <label for="addressLine2">Address Line 2</label>
      <input type="text" id="addressLine2" name="addressLine2" value="${property.addressLine2!''}" placeholder="Apt, Suite, etc." />

      <label for="city">City</label>
      <input type="text" id="city" name="city" value="${property.city!''}" placeholder="City" required />

      <label for="state">State</label>
      <input type="text" id="state" name="state" value="${property.state!''}" placeholder="State" required />

      <label for="zipCode">ZIP Code</label>
      <input type="text" id="zipCode" name="zipCode" value="${property.zipCode!''}" placeholder="ZIP code" required />

      <label for="description">Description</label>
      <textarea id="description" name="description" placeholder="Enter property description..." rows="5" required>${property.description!''}</textarea>

      <label for="askingPrice">Asking Price</label>
      <input type="number" id="askingPrice" name="askingPrice" value="${property.askingPrice!''}" placeholder="Asking Price ($)" required />

      <label for="goodFaithDeposit">Good Faith Deposit</label>
      <input type="number" id="goodFaithDeposit" name="goodFaithDeposit" value="${property.goodFaithDeposit!''}" placeholder="Good Faith Deposit ($)" required />

      <!-- Display existing images -->
      <div class="existing-images">
        <h3>Current Images</h3>
        <#if property.images?? && property.images?size gt 0>
          <#list property.images as image>
            <div class="existing-image">
              <img src="${image.path}" alt="Property image">
            </div>
          </#list>
        <#else>
          <p>No images currently associated with this property.</p>
        </#if>
      </div>

      <h3>Add New Images</h3>
      <div class="drop-area">
        <p>Drag & drop images here or click to select</p>
        <input type="file" id="imageFiles" name="imageFiles" multiple accept="image/*" style="display: none;"/>
        <div class="preview"></div>
      </div>

      <div style="margin-top: 2em; display: flex; gap: 1em;">
        <button type="submit" class="pure-button pure-button-primary">
          Update Property
        </button>
        <a href="/api/properties/${property.propertyId}" class="pure-button">Cancel</a>
      </div>
    </form>
  </div>
  
  <script type="text/javascript">
    function setupImageHandling() {
      const fileInput = document.getElementById("imageFiles");
      const dropArea = document.querySelector(".drop-area");
      const filesContainer = document.querySelector(".preview");
      
      // Trigger file input when clicking on drop area
      dropArea.addEventListener("click", function() {
        fileInput.click();
      });
      
      const handleFiles = (files) => {
        Array.from(files).forEach(file => {
          if (!file.type.startsWith('image/')) return;
          
          const img = document.createElement("img");
          img.src = URL.createObjectURL(file);
          img.alt = `preview-${file.name}`;
          filesContainer.appendChild(img);
        });
      };
      
      const handleDrop = (e) => {
        e.preventDefault();
        const newFiles = [...e.dataTransfer.files].filter(file => file.type.startsWith('image/'));
        
        // Add files to the file input
        const dt = new DataTransfer();
        const existingFiles = fileInput.files;
        
        if (existingFiles) {
          for (let i = 0; i < existingFiles.length; i++) {
            dt.items.add(existingFiles[i]);
          }
        }
        
        newFiles.forEach(file => dt.items.add(file));
        fileInput.files = dt.files;
        
        handleFiles(newFiles);
      };

      const handleDragOver = (e) => e.preventDefault();

      dropArea.addEventListener("drop", handleDrop);
      dropArea.addEventListener("dragover", handleDragOver);
      
      fileInput.addEventListener("change", function() {
        handleFiles(this.files);
      });
    }

    document.addEventListener("DOMContentLoaded", setupImageHandling);
  </script>
</body>
</html>