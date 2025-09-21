// server.js
const express = require('express');
const path = require('path');

const app = express();

// Serve static files (CSS, images, etc.)
app.use(express.static(path.join(__dirname, 'public')));

// Import routes
const homeRoute = require('./routes/home');
app.use('/home', homeRoute);

// Default route (optional)
app.get('/', (req, res) => {
  res.send('<h1>Welcome! Go to <a href="/home">/home</a> to see the dashboard.</h1>');
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
