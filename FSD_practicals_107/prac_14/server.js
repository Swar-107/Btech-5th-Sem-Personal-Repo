// server.js
const express = require('express');
const fileUpload = require('express-fileupload');
const path = require('path');
const fs = require('fs');

const app = express();
app.use(express.static(path.join(__dirname, 'public')));

// Enable file upload
app.use(fileUpload());

// Create uploads folder if not exists
const uploadDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir);
}

// Serve upload form
app.get('/', (req, res) => {
  const message = req.query.message || '';
  const messageClass = message.includes('successfully') ? 'success' : (message ? 'error' : '');
  
  res.send(`
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <title>Resume Upload Portal</title>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" href="/styles.css">
    </head>
    <body>
      <div class="container">
        <h1>Resume Upload Portal</h1>
        <div class="upload-info">
          <p><strong>Upload Requirements:</strong></p>
          <p>• File format: PDF only</p>
          <p>• Maximum size: 2MB</p>
          <p>• Ensure your resume is professional and up-to-date</p>
        </div>
        <form action="/upload" method="post" enctype="multipart/form-data">
          <div class="file-input-wrapper">
            <input type="file" name="resume" accept=".pdf" required>
          </div>
          <button type="submit">Upload Resume</button>
        </form>
        ${message ? `<div class="message ${messageClass}">${message}</div>` : ''}
      </div>
    </body>
    </html>
  `);
});

// Handle upload (PDF + size ≤2MB)
app.post('/upload', (req, res) => {
  if (!req.files || !req.files.resume) {
    return res.redirect('/?message=' + encodeURIComponent('Error: No file was selected for upload.'));
  }

  const resume = req.files.resume;

  // Check MIME type and extension
  const allowedMime = 'application/pdf';
  if (resume.mimetype !== allowedMime || path.extname(resume.name).toLowerCase() !== '.pdf') {
    return res.redirect('/?message=' + encodeURIComponent('Error: Only PDF files are allowed. Please select a PDF file.'));
  }

  // Check file size (<=2MB)
  if (resume.size > 2 * 1024 * 1024) {
    const fileSizeMB = (resume.size / (1024 * 1024)).toFixed(2);
    return res.redirect('/?message=' + encodeURIComponent(`Error: File size (${fileSizeMB}MB) exceeds the 2MB limit.`));
  }

  // Save file with timestamp prefix
  const timestamp = Date.now();
  const sanitizedName = resume.name.replace(/[^a-zA-Z0-9.-]/g, '_');
  const savePath = path.join(uploadDir, `${timestamp}-${sanitizedName}`);
  
  resume.mv(savePath, (err) => {
    if (err) {
      console.error('Upload error:', err);
      return res.redirect('/?message=' + encodeURIComponent('Error: Failed to save the uploaded file. Please try again.'));
    }
    res.redirect('/?message=' + encodeURIComponent('Resume uploaded successfully! Your file has been received and stored securely.'));
  });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running at http://localhost:${PORT}`));
