const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');

const app = express();
const port = 3000;

app.use(bodyParser.json());

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '12345678',
  database: 'shoppingdatabse',
});

app.post('/login', (req, res) => {
  const { email, password } = req.body;

  db.query(
    'SELECT email,password FROM user WHERE email = ? AND password = ?',
    [email, password],
    (err, results) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: 'Internal server error' });
      }

      if (results.length === 0) {
        return res.status(401).json({ message: 'Invalid email or password' });
      }

      // Authentication successful
      return res.status(200).json({ message: 'Login successful' });
    }
  );
});

app.post('/signup', (req, res) => {
    console.log(req.body);
    const {firstname,lastname, email, password, address,birthday,phone } = req.body;
    db.query(
      'SELECT * FROM user WHERE email = ? ',
      [email],
      (error, results) => {
        if (error) {
          return res.status(500).json({ message: 'Internal server error' });
  
        }
  
        if (results.length > 0) {
          return res.status(401).json({ message: 'Email already in use' });//return reject('Email or username already in use.');
        }
  
        // Hash the password before storing it
        bcrypt.hash(password, 10, (hashError, hashedPassword) => {
          if (hashError) {
            return res.status(401).json({ message: 'User registration failed.' });//return reject('User registration failed.');
          }
          const birthdayDate = new Date(birthday);
  
         
          db.query(
            'INSERT INTO User (first_name, last_name,email, password, address,birthday,phone_number) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [firstname,lastname, email, password, address,birthday,phone],
            (err, results) => {
              if (err) {
                console.error(err);
                return res.status(500).json({ message: 'Internal server error' });
              }
        
              if (results.length === 0) {
                return res.status(401).json({ message: 'User registration failed' });
              }
        
              // Authentication successful
              return res.status(200).json({ message: 'Signup successful' });
            }
            
            
          );
        });
      },
    );
});

// Uncommented root route handler
app.get('/', (req, res) => {
  res.send('Welcome to my website!');
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Server is listening on port ${port}`);
});