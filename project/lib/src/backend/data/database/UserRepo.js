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
    'SELECT email,password, first_name, last_name , address, phone_number, user_id , birthday FROM user WHERE email = ? ',
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

          console.log('First Name:', user.first_name);
          
          const userData = {
            email: user.email,
            first_name: user.first_name,
            last_name: user.last_name,
            address: user.address,
            phone_number: user.phone_number,
            user_id: user.user_id,
            birthday: user.birthday,
        };
          return res.json({ message: 'Login successful.', user: userData });
          
         
        },
      );
    },
  );
      
        
      
    
  }
  userName(email) {
    return new Promise((resolve, reject) => {
      //console.log('YYYYYYYYYYY'+email);
      db.query('SELECT first_name, last_name , user_id FROM user WHERE email = ?', [email], (error, results) => {
        if (error) {
          console.error(error);
          reject('User not found');
        } else {
        //  console.log({results});
          resolve(results);
        }
      });
    });
  }
//sellarChat
sellarChat(productName) {
  return new Promise((resolve, reject) => {
    console.log('YYYYYYYYYYY'+productName);
    db.query('SELECT user_id FROM product WHERE name = ?', [productName], (error, results) => {
      if (error) {
        console.error(error);
        reject(' not found');
      } 
      const userid=results[0].user_id;
    db.query('SELECT first_name, last_name,email  FROM user WHERE user_id = ?', [userid], (error, results) => {
      if (error) {
        console.error(error);
        reject('User not found');
      } else {
       //console.log({results});
     
        resolve(results);
      }
    });
  });
  });
}
//AllUserName
AllUserName(req, res) {


  return new Promise((resolve, reject) => {
    // Check if the user already exists (Checking the email)
    db.query(
      'SELECT first_name, last_name,email FROM user ',
   
      (error, results) => {
        if (error) {
          return reject('Internal server error.');
        }

        return resolve(results);

      
        
     
      },
    );
  });


}
  
  // update 
  Editprofile(id, firstName, lastName, email, address, phoneNumber , gender) {
    return new Promise((resolve, reject) => {
      // SQL query to update the user's profile in the database
      db.query(
        'UPDATE user SET first_name = ?, last_name = ?, email = ?, address = ?, phone_number = ?, birthday = ? WHERE user_id = ?',
        [firstName, lastName, email, address, phoneNumber, gender , id],
        (error, results) => {
          if (error) {
            console.error('Error updating profile:', error);
            return reject('Failed to update profile');
          }
          return resolve('Profile updated successfully');
        }
      );
    });
  }
  

  /// product home page 

























































  /// product home page 


}
module.exports = UserRepository;