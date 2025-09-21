// server.js
const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// Serve the calculator form
app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <title>Simple Calculator</title>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" href="/styles.css">
    </head>
    <body>
      <div class="container">
        <h1>Simple Calculator</h1>
        <form action="/calculate" method="post">
          <input type="text" name="num1" placeholder="Enter first number" required>
          <select name="operation">
            <option value="add">Addition (+)</option>
            <option value="subtract">Subtraction (-)</option>
            <option value="multiply">Multiplication (×)</option>
            <option value="divide">Division (÷)</option>
          </select>
          <input type="text" name="num2" placeholder="Enter second number" required>
          <button type="submit">Calculate</button>
        </form>
        <div class="result">
          ${req.query.result || 'Enter numbers above and click Calculate'}
        </div>
      </div>
    </body>
    </html>
  `);
});

// Handle calculation
app.post('/calculate', (req, res) => {
  let num1 = parseFloat(req.body.num1);
  let num2 = parseFloat(req.body.num2);
  let operation = req.body.operation;

  // Validation
  if (isNaN(num1) || isNaN(num2)) {
    return res.redirect('/?result=' + encodeURIComponent('Error: Please enter valid numbers.'));
  }

  let result;
  let operationSymbol;
  
  switch (operation) {
    case 'add':
      result = num1 + num2;
      operationSymbol = '+';
      break;
    case 'subtract':
      result = num1 - num2;
      operationSymbol = '-';
      break;
    case 'multiply':
      result = num1 * num2;
      operationSymbol = '×';
      break;
    case 'divide':
      if (num2 === 0) {
        return res.redirect('/?result=' + encodeURIComponent('Error: Cannot divide by zero.'));
      }
      result = (num1 / num2).toFixed(2);
      operationSymbol = '÷';
      break;
    default:
      return res.redirect('/?result=' + encodeURIComponent('Error: Invalid operation.'));
  }

  res.redirect('/?result=' + encodeURIComponent(`${num1} ${operationSymbol} ${num2} = ${result}`));
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
