

const express = require('express');
const user = require('./routes/userRoute.js');
const product = require('./routes/productRoute.js');
const payment = require('./routes/paymentRoute.js');
const app = express();
const bodyParser = require('body-parser');
const port = 3000;
// Increase maximum payload size limit to 50MB
//app.use(bodyParser.json({ limit: '50mb' }));
//app.use(bodyParser.urlencoded({ limit: '50mb', extended: true }));


app.use(express.json());

app.use('/tradetryst/user', user);

app.use('/tradetryst/home', product);
app.use('/tradetryst/product', product); 
app.use('/tradetryst/edit', user);
app.use('/tradetryst/productnew', product); 

app.use('/tradetryst/productused', product); 

app.use('/tradetryst/Product',product);


app.use('/tradetryst/getNameOfUser',user);
//app.use('/tradetryst/Product',product);
app.use('/tradetryst/shoppingcart',product);

app.use('/tradetryst/search',product);

// delete account 
app.use('/tradetryst/deleteaccount',user);
//app.use('/tradetryst/user',user);
app.use('/tradetryst/old',user);
// 8_MAY 
app.use('/tradetryst/payment',payment);


// ibtisam 
app.use('/tradetryst/usermanage',user);
app.use('/tradetryst/useradmin',user);


app.listen(port, '0.0.0.0', () => {
    console.log(`Server is listening on port ${port}`);
});

