const request = require('supertest');
const server = require('../index'); // import server

describe('Basic Node.js HTTP Server', () => {
  afterAll(() => {
    server.close(); // close server after tests
  });

  test('GET / should return Hello World page with button', async () => {
    const res = await request(server).get('/');

    expect(res.status).toBe(200);
    expect(res.headers['content-type']).toMatch(/html/);

    // check if HTML contains the Hello World header
    expect(res.text).toContain('<h1>Hello World!</h1>');
    expect(res.text).toContain('document.body.style.backgroundColor = "yellow";');

  });

  test('GET /non-existing should return 404', async () => {
    const res = await request(server).get('/not-found');

    expect(res.status).toBe(404);
    expect(res.text).toBe('Page not found');
  });
});
