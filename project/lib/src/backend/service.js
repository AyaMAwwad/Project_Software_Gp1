

const express = require('express');
const user = require('./routes/userRoute.js');
const product = require('./routes/productRoute.js');
const app = express();
const bodyParser = require('body-parser');
const port = 3000;
// Increase maximum payload size limit to 50MB
//app.use(bodyParser.json({ limit: '50mb' }));
//app.use(bodyParser.urlencoded({ limit: '50mb', extended: true }));


app.use(express.json());

app.use('/tradetryst/user', user);
//app.use('/tradetryst/user', user);
app.use('/tradetryst/home', product);
app.use('/tradetryst/product', product); 
app.use('/tradetryst/edit', user);
app.use('/tradetryst/productnew', product); 
app.use('/tradetryst/Product',product);


//app.use('/tradetryst/user',user);
//app.use('/tradetryst/user',user);
app.use('/tradetryst/getNameOfUser',user);
app.use('/tradetryst/Product',product);
app.use('/tradetryst/shoppingcart',product);
// newwwwwwwww
app.use('/tradetryst/search',product);



app.listen(port, '0.0.0.0', () => {
    console.log(`Server is listening on port ${port}`);
});



/*const express = require('express');
const user = require('./routes/userRoute.js');
const product = require('./routes/productRoute.js');
const app = express();
const port = 3000;


/////////
/*
const { Server } = require('socket.io');
const http = require('http');


const server = http.createServer(app);
const io = new Server(server);
const sessionConfig = require('./middlewares/sessionConfig'); // Import the session configuration module

app.use(sessionConfig);

const {
    addUserSocket,
    notifyUser,
    removeUserSocket,
  } = require('./services/SocketService');
  */
////////////////////////////////
/*
app.use(express.json());
app.use('/tradetryst/user', user);
app.use('/tradetryst/user', user);
app.use('/tradetryst/home', product);
app.use('/tradetryst/Product',product);


/*io.on('connection', (socket) => {
    console.log('A user connected');
    socket.on('login', (data) => {
      addUserSocket(data, socket);
      notifyUser(data, 'test notify');
    });
  
    socket.on('disconnect', () => {
      console.log('User disconnected');
      removeUserSocket(socket);
    });
  });*/

/*  app.listen(port, '0.0.0.0', () => {
    console.log(`Server is listening on port ${port}`);
});


*/