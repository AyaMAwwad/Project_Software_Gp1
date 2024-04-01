const mysql = require('mysql2');
const bcrypt = require('bcrypt');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '12345678',
  database: 'shoppingdatabse',
});

class UserRepository {

  registerUser(req, res) {
    const { firstname,lastname, email, password,address,birthday,phone } = req.body;

    return new Promise((resolve, reject) => {
      // Check if the user already exists (Checking the email)
      db.query(
        'SELECT * FROM User WHERE email = ? ',
        [email],
        (error, results) => {
          if (error) {
            return reject('Internal server error.');
          }

          if (results.length > 0) {
            return reject('Email or username already in use.');
          }

          // Hash the password before storing it
          bcrypt.hash(password, 10, (hashError, hashedPassword) => {
            if (hashError) {
              return reject('User registration failed.');
            }
            const birthdayDate = new Date(birthday);

           
            db.query(
              'INSERT INTO user (first_name, last_name,email, password, address,birthday,phone_number) VALUES (?, ?, ?, ?, ?, ?, ?)',
              [firstname,lastname, email, hashedPassword, address,birthdayDate,phone],
              
              (insertError) => {
                if (insertError) {
                  console.log(password);

                  return reject('User registration failed.');
                }

                return resolve('User registered successfully.');
              },
            );
          });
        },
      );
    });
  }

  loginUser(req, res) {
    const { email, password } = req.body;

  db.query(
    'SELECT email,password FROM user WHERE email = ? ',
    [email],
    (err, results) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ message: 'Internal server error' });
      }

      if (results.length === 0) {
        return res.status(401).json({ message: 'Invalid email or password' });
      }

      const user = results[0];
      bcrypt.compare(
        password,
        user.password,
        (compareError, passwordMatch) => {
          if (compareError) {
            return res
              .status(500)
              .json({ message: 'Internal server error.' });
          }
          if (!passwordMatch) {
            return res.status(401).json({ message: 'Invalid data.' });
          }
          return res.json({ message: 'Login successful.' });
          
         
        },
      );
    },
  );
      
        
      
    
  }

  /// product home page 


}
module.exports = UserRepository;