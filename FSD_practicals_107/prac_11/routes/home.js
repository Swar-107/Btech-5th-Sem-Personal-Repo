// routes/home.js
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <title>Project Dashboard</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/styles.css">
      </head>
      <body>
        <header class="header">
          <h1>Project Dashboard</h1>
        </header>
        <main class="container">
          <h2>Welcome to Your Dashboard</h2>
          <p>This template serves as the foundation for future web applications and team projects.</p>
          <div class="card-grid">
            <div class="card">
              <h3>Data Management</h3>
              <p>Access and organize your project data efficiently with our streamlined interface.</p>
            </div>
            <div class="card">
              <h3>Analytics Overview</h3>
              <p>Monitor key metrics and generate insights to track project progress.</p>
            </div>
            <div class="card">
              <h3>Team Collaboration</h3>
              <p>Manage user accounts and facilitate seamless team communication.</p>
            </div>
          </div>
        </main>
        <footer class="footer">
          <p>© 2025 Development Team</p>
        </footer>
      </body>
    </html>
  `);
});

module.exports = router;
