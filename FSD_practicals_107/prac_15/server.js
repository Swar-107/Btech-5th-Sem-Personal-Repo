// server.js
const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Session setup
app.use(session({
  secret: 'library_secret_key', // change for production
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 600000 } // 10 minutes
}));

// GET login page
app.get('/', (req, res) => {
  res.render('login', { error: null });
});

// POST login
app.post('/login', (req, res) => {
  const { name } = req.body;

  if (!name || name.trim() === '') {
    return res.render('login', { error: 'Please enter your name to continue.' });
  }

  // Validate name length
  if (name.trim().length < 2) {
    return res.render('login', { error: 'Please enter a valid name (at least 2 characters).' });
  }

  // Save session data
  req.session.user = {
    name: name.trim(),
    loginTime: new Date().toLocaleString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    })
  };

  res.redirect('/profile');
});

// GET profile (protected)
app.get('/profile', (req, res) => {
  if (!req.session.user) {
    return res.redirect('/');
  }
  res.render('profile', { user: req.session.user });
});

// Logout
app.get('/logout', (req, res) => {
  req.session.destroy(err => {
    if (err) {
      console.log(err);
    }
    res.redirect('/');
  });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running at http://localhost:${PORT}`));
