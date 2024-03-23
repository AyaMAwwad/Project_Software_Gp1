const express = require('express');
const user = require('./routes/userRoute.js');

const app = express();
const port = 3000;

app.use(express.json());

app.use('/tradetryst/user', user);
app.use('/tradetryst/user', user);

app.listen(port, '0.0.0.0', () => {
    console.log(`Server is listening on port ${port}`);
});
