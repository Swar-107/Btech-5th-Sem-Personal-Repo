// server.js
const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// Set EJS as the view engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// GET form page
app.get('/', (req, res) => {
  res.render('form', { error: null });
});

// POST handle form submission
app.post('/calculate', (req, res) => {
  const income1 = parseFloat(req.body.income1);
  const income2 = parseFloat(req.body.income2);

  // Validation
  if (isNaN(income1) || isNaN(income2)) {
    return res.render('form', { error: 'Please enter valid numbers for both income fields.' });
  }

  const totalIncome = income1 + income2;
  res.render('result', { income1, income2, totalIncome });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running at http://localhost:${PORT}`));
