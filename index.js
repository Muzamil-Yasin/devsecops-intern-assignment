const http = require('http');

// Create the HTTP server
const server = http.createServer((req, res) => {
  if (req.url === '/') {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(`
      <html>
        <body>
          <h1>Hello World!</h1>
          <button id="colorBtn">Change Color</button>

          <script>
            document.getElementById("colorBtn").addEventListener("click", () => {
              const randomColor = "#" + Math.floor(Math.random() * 16777215).toString(16);
              document.body.style.backgroundColor = randomColor;
            });
          </script>
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
