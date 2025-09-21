const express = require('express');
const router = express.Router();
const path = require('path');

router.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>TechStore - Your Product Destination</title>
      <link rel="stylesheet" href="/styles.css">
    </head>
    <body>
      <header class="header">
        <div class="nav-container">
          <h1 class="logo">TechStore</h1>
          <nav class="nav-menu">
            <a href="#home">Home</a>
            <a href="#products">Products</a>
            <a href="#contact">Contact</a>
          </nav>
        </div>
      </header>

      <main class="main-content">
        <section class="hero-section">
          <div class="container">
            <h2>Welcome to our site</h2>
            <p>Discover amazing products at great prices. This is a basic Express.js proof of concept for our small product site.</p>
            <button class="cta-button" onclick="showProducts()">Browse Products</button>
          </div>
        </section>

        <section class="contact-section" id="contact">
          <div class="container">
            <h3>Get in Touch</h3>
            <form class="contact-form" action="/contact" method="POST">
              <div class="form-group">
                <label for="name">Your Name:</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name" required>
              </div>
              
              <div class="form-group">
                <label for="email">Email Address:</label>
                <input type="email" id="email" name="email" placeholder="your.email@example.com" required>
              </div>
              
              <div class="form-group">
                <label for="product-interest">Product Interest:</label>
                <select id="product-interest" name="product">
                  <option value="">Select a category</option>
                  <option value="electronics">Electronics</option>
                  <option value="clothing">Clothing</option>
                  <option value="books">Books</option>
                  <option value="home">Home & Garden</option>
                </select>
              </div>
              
              <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" name="message" placeholder="Tell us what you're looking for..." rows="4"></textarea>
              </div>
              
              <button type="submit" class="submit-button">Send Message</button>
            </form>
          </div>
        </section>

        <section class="products-section" id="products" style="display: none;">
          <div class="container">
            <h3>Featured Products</h3>
            <div class="product-grid">
              <div class="product-card">
                <h4>Laptop Pro</h4>
                <p>High-performance laptop for professionals</p>
                <span class="price">$999</span>
                <button class="product-btn">View Details</button>
              </div>
              <div class="product-card">
                <h4>Wireless Headphones</h4>
                <p>Premium sound quality with noise cancellation</p>
                <span class="price">$199</span>
                <button class="product-btn">View Details</button>
              </div>
              <div class="product-card">
                <h4>Smart Watch</h4>
                <p>Track your fitness and stay connected</p>
                <span class="price">$299</span>
                <button class="product-btn">View Details</button>
              </div>
            </div>
          </div>
        </section>
      </main>

      <footer class="footer">
        <div class="container">
          <p>&copy; 2025 TechStore. Built with Express.js</p>
        </div>
      </footer>

      <script>
        function showProducts() {
          const productsSection = document.getElementById('products');
          productsSection.style.display = 'block';
          productsSection.scrollIntoView({ behavior: 'smooth' });
        }

        // Form submission handler
        document.querySelector('.contact-form').addEventListener('submit', function(e) {
          e.preventDefault();
          alert('Thank you for your message! We will get back to you soon.');
          this.reset();
        });
      </script>
    </body>
    </html>
  `);
});

// Handle contact form submission
router.post('/contact', (req, res) => {
  const { name, email, product, message } = req.body;
  
  // In a real application, you would save this to a database
  console.log('Contact form submission:', {
    name,
    email,
    product,
    message,
    timestamp: new Date().toISOString()
  });
  
  res.json({
    success: true,
    message: 'Thank you for your message! We will get back to you soon.'
  });
});

module.exports = router;
