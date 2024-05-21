const express = require('express');
const http = require('http');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from app1!');
});

const connectToApp2 = () => {
  http.get('http://app2:5000', (resp) => {
    let data = '';

    // Una parte de los datos ha sido recibida.
    resp.on('data', (chunk) => {
      data += chunk;
    });

    // Toda la respuesta ha sido recibida.
    resp.on('end', () => {
      console.log(data);
    });

  }).on("error", (err) => {
    console.log("Error: " + err.message);
    console.log("Retrying in 5 seconds...");
    setTimeout(connectToApp2, 5000);
  });
};

connectToApp2();

app.listen(3000, () => {
  console.log('App1 listening on port 3000');
});
