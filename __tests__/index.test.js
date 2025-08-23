const http = require('http');

const server = http.createServer((req, res) => {
  if (req.url === '/') {
    res.writeHead(200, {'Content-Type': 'text/html'});
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

// <-- Add this line at the very end to export server for testing
module.exports = server;



const request = require('supertest');
const server = require('../index'); // import your server

// Close the server after all tests finish
afterAll(() => {
  server.close();
});

describe('GET /', () => {
  it('should return 200 and contain Hello World', async () => {
    const response = await request(server).get('/');
    expect(response.status).toBe(200);
    expect(response.text).toContain('Hello World');
  });
});

describe('GET /invalid', () => {
  it('should return 404 for invalid route', async () => {
    const response = await request(server).get('/invalid');
    expect(response.status).toBe(404);
    expect(response.text).toBe('Page not found');
  });
});
