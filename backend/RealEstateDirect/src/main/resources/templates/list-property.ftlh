<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>List Property</title>
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
      transition: all 0.3s ease;
    }

    .drop-area:hover {
      border-color: #0078e7;
      background-color: #f0f8ff;
    }

    .drop-area.drag-over {
      border-color: #0078e7;
      background-color: #e1f5fe;
    }

    .preview {
      display: flex;
      flex-wrap: wrap;
      gap: 1em;
      margin-top: 1em;
    }

    .preview-item {
      position: relative;
      width: 100px;
      height: 100px;
      border-radius: 6px;
      overflow: hidden;
    }

    .preview-item img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .remove-image {
      position: absolute;
      top: 5px;
      right: 5px;
      width: 20px;
      height: 20px;
      background-color: rgba(255, 255, 255, 0.7);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      font-weight: bold;
      color: #ff3b30;
    }
  </style>
</head>
<body>
  <div>
    <h1 class="text-2xl">List Property</h1>
    <form class="pure-form pure-form-stacked" action="/api/properties/create/${sellerId}" method="post" enctype="multipart/form-data">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <label for="addressLine1">Address Line 1</label>
      <input type="text" id="addressLine1" name="addressLine1" placeholder="Street address" required />

      <label for="addressLine2">Address Line 2</label>
      <input type="text" id="addressLine2" name="addressLine2" placeholder="Apt, Suite, etc." />

      <label for="city">City</label>
      <input type="text" id="city" name="city" placeholder="City" required />

      <label for="state">State</label>
      <input type="text" id="state" name="state" placeholder="State" required />

      <label for="zipCode">ZIP Code</label>
      <input type="text" id="zipCode" name="zipCode" placeholder="ZIP code" required />

      <label for="description">Description</label>
      <textarea id="description" name="description" placeholder="Enter property description..." rows="5" required></textarea>

      <label for="askingPrice">Asking Price</label>
      <input type="number" id="askingPrice" name="askingPrice" placeholder="Asking Price ($)" required />

      <label for="goodFaithDeposit">Good Faith Deposit</label>
      <input type="number" id="goodFaithDeposit" name="goodFaithDeposit" placeholder="Good Faith Deposit ($)" required />

      <label>Property Images</label>
      <div class="drop-area" id="dropArea">
        <p>Drag & drop images here or click to select</p>
        <input type="file" id="imageFiles" name="imageFiles" multiple accept="image/*" style="display: none;"/>
        <div class="preview" id="imagePreview"></div>
      </div>

      <button type="submit" class="pure-button pure-button-primary" style="margin-top: 1em;">
        Submit Listing
      </button>
    </form>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const dropArea = document.getElementById('dropArea');
      const fileInput = document.getElementById('imageFiles');
      const preview = document.getElementById('imagePreview');
      
      // Handle clicking on drop area to select files
      dropArea.addEventListener('click', function(e) {
        if (e.target.className !== 'remove-image') {
          fileInput.click();
        }
      });
      
      // Prevent default drag behaviors
      ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropArea.addEventListener(eventName, preventDefaults, false);
      });
      
      function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
      }
      
      // Highlight drop area when dragging over it
      ['dragenter', 'dragover'].forEach(eventName => {
        dropArea.addEventListener(eventName, highlight, false);
      });
      
      ['dragleave', 'drop'].forEach(eventName => {
        dropArea.addEventListener(eventName, unhighlight, false);
      });
      
      function highlight() {
        dropArea.classList.add('drag-over');
      }
      
      function unhighlight() {
        dropArea.classList.remove('drag-over');
      }
      
      // Handle dropped files
      dropArea.addEventListener('drop', handleDrop, false);
      
      function handleDrop(e) {
        const dt = e.dataTransfer;
        const files = dt.files;
        handleFiles(files);
      }
      
      // Handle files from input selection
      fileInput.addEventListener('change', function() {
        handleFiles(this.files);
      });
      
      function handleFiles(files) {
        files = [...files].filter(file => file.type.startsWith('image/'));
        files.forEach(previewFile);
      }
      
      function previewFile(file) {
        const reader = new FileReader();
        reader.readAsDataURL(file);
        
        reader.onload = function() {
          const previewItem = document.createElement('div');
          previewItem.className = 'preview-item';
          
          const img = document.createElement('img');
          img.src = reader.result;
          img.alt = file.name;
          previewItem.appendChild(img);
          
          const removeBtn = document.createElement('span');
          removeBtn.className = 'remove-image';
          removeBtn.innerHTML = '×';
          removeBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            previewItem.remove();
            updateFileInput();
          });
          
          previewItem.appendChild(removeBtn);
          preview.appendChild(previewItem);
        };
      }
      
      function updateFileInput() {
        // This is a simplified approach - we can't easily remove files from the FileList
        // In a production app, you would want to track selected files separately
        // For now, we just note that removal is handled client-side for preview only
        console.log("Note: File removal only affects preview, not the actual submission");
      }
    });
  </script>
</body>
</html>