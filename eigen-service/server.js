const http = require('http');
const port = Number(process.env.PORT || 8080);
const server = http.createServer((req, res) => {
  if (req.url === '/health') {
    res.writeHead(200, {'content-type':'application/json'});
    res.end(JSON.stringify({ ok: true }));
    return;
  }
  res.writeHead(200, {'content-type':'text/plain'});
  res.end('Hello from cubit on EigenCompute\n');
});
server.listen(port, () => console.log(`listening on ${port}`));
