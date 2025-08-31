const http = require('http');

// Create the HTTP server
const server = http.createServer((req, res) => {
  if (req.url === '/') {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(`
      <html>
        <body>
          <h1>Hello World!</h1>
          <button onclick="document.body.style.backgroundColor='yellow'">Change Color</button>
        </body>
      </html>
    `);
  } else {
    res.writeHead(404);
    res.end('Page not found');
  }
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

// Export the server for testing
module.exports = server;
