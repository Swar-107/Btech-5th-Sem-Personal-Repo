const express = require('express');
const fs = require('fs');
const path = require('path');

const app = express();
app.use(express.static(path.join(__dirname, 'public')));

// List all log files in the "logs" directory
app.get('/', (req, res) => {
  const logsDir = path.join(__dirname, 'logs');
  fs.readdir(logsDir, (err, files) => {
    if (err) {
      return res.status(500).send(`
        <html><body><h1>Error</h1><p>Cannot read logs directory.</p></body></html>
      `);
    }

    const logLinks = files
      .map(f => `<li><a href="/view?file=${encodeURIComponent(f)}">${f}</a></li>`)
      .join('');

    res.send(`
      <!DOCTYPE html>
      <html>
        <head>
          <title>Log Viewer</title>
          <link rel="stylesheet" href="/styles.css">
        </head>
        <body>
          <div class="container">
            <h1>Available Logs</h1>
            <ul class="log-list">${logLinks}</ul>
          </div>
        </body>
      </html>
    `);
  });
});

// View a specific log file
app.get('/view', (req, res) => {
  const fileName = req.query.file;
  if (!fileName) return res.status(400).send('Missing file parameter');

  const logFilePath = path.join(__dirname, 'logs', fileName);

  // Security check: ensure file is inside logs folder
  if (!logFilePath.startsWith(path.join(__dirname, 'logs'))) {
    return res.status(403).send('Forbidden');
  }

  fs.readFile(logFilePath, 'utf8', (err, data) => {
    if (err) {
      return res.status(500).send(`
        <!DOCTYPE html>
        <html>
          <head>
            <title>Error</title>
            <link rel="stylesheet" href="/styles.css">
          </head>
          <body>
            <div class="container">
              <h1>Error Reading File</h1>
              <p>File may be missing or inaccessible.</p>
              <a href="/">Go back</a>
            </div>
          </body>
        </html>
      `);
    }

    res.send(`
      <!DOCTYPE html>
      <html>
        <head>
          <title>Viewing ${fileName}</title>
          <link rel="stylesheet" href="/styles.css">
        </head>
        <body>
          <div class="container">
            <h1>Viewing ${fileName}</h1>
            <pre class="logs">${data}</pre>
            <div class="buttons">
              <a class="btn" href="/download?file=${encodeURIComponent(fileName)}">Download</a>
              <a class="btn danger" href="/clear?file=${encodeURIComponent(fileName)}" onclick="return confirm('Clear this log file?');">Clear Log</a>
              <a class="btn back" href="/">Back to List</a>
            </div>
          </div>
        </body>
      </html>
    `);
  });
});

// Download a log file
app.get('/download', (req, res) => {
  const fileName = req.query.file;
  const logFilePath = path.join(__dirname, 'logs', fileName);

  if (!logFilePath.startsWith(path.join(__dirname, 'logs'))) {
    return res.status(403).send('Forbidden');
  }

  res.download(logFilePath, fileName);
});

// Clear a log file
app.get('/clear', (req, res) => {
  const fileName = req.query.file;
  const logFilePath = path.join(__dirname, 'logs', fileName);

  if (!logFilePath.startsWith(path.join(__dirname, 'logs'))) {
    return res.status(403).send('Forbidden');
  }

  fs.writeFile(logFilePath, '', (err) => {
    if (err) return res.status(500).send('Error clearing log');
    res.redirect(`/view?file=${encodeURIComponent(fileName)}`);
  });
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Log Viewer running at http://localhost:${PORT}`);
});
