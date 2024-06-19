const mysql = require('mysql2');
const bcrypt = require('bcrypt');
// yoyo
const path = require('path');
const fs = require('fs');
// yoyo
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

// ibtisam adduserfromadmin
adduserfromadmin(req, res) {
  const { first_name,last_name, email, user_type,password,phone_number,address,  birthday} = req.body;

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
            'INSERT INTO user (first_name, last_name,email, password, address,birthday,phone_number, user_type) VALUES (?, ?, ?, ?, ?, ?, ?,?)',
            [first_name,last_name, email, hashedPassword, address,birthday,phone_number, user_type],
            
            (insertError) => {
              if (insertError) {
                console.log(password);

                return reject('User registration failed.please try again');
              }

              return resolve('User registered successfully.');
            },
          );
        });
      },
    );
  });
}











  // new ibtisam end 
// admin 
  loginUser(req, res) {
    const { email, password } = req.body;

  db.query(
    'SELECT email,password, first_name, last_name , address, phone_number, user_id , birthday, user_type FROM user WHERE email = ? ',
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
            user_type: user.user_type,  // admin 
  
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
    console.log('YYYYYYYYYYY'+ productName);
    db.query('SELECT user_id FROM product WHERE name = ?', [productName], (error, results) => {
      if (error || results.length==0) {
        console.error(error);
        console.log('aya');
        reject(' not found');
      } 
      else{
      const userid=results[0].user_id;
      // yoyo  --->  add user_id
    db.query('SELECT first_name, last_name,email,user_id  FROM user WHERE user_id = ?', [userid], (error, results) => {
      if (error) {
        console.error(error);
        reject('User not found');
      } else {
       //console.log({results});
     
        resolve(results);
      }
    });}
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

  // delete acount user 
/*

  deleteacountt(userId) {
    console.log('deleteacountt function called with userId:', userId);
    return new Promise((resolve, reject) => {
      // SQL query to delete the user account from the database
      db.query(
        'DELETE FROM user WHERE user_id = ?',
        [userId],
        (error, results) => {
          if (error) {
            console.error('Error deleting account:', error);
            return reject('Failed to delete account');
          }
          if (results.affectedRows === 0) {
            // No rows affected, meaning no user with the specified ID found
            return reject('User not found');
          }
          console.log('Account deleted successfully');
          return resolve('Account deleted successfully');
        }
      );

    });
  }
  
*/

/*
deleteacountt(userId) {
  console.log('deleteacountt function called with userId:', userId);
  return new Promise((resolve, reject) => {
    // SQL query to delete records from the new_product table where product_id is associated with the user
    db.query(
      'DELETE FROM new_product WHERE product_id IN (SELECT product_id FROM product WHERE user_id = ?)',
      [userId],
      (error, results) => {
        if (error) {
          console.error('Error deleting new_product records:', error);
          return reject('Failed to delete account');
        }
        
        // SQL query to delete records from the used_product table where product_id is associated with the user
        db.query(
          'DELETE FROM used_product WHERE product_id IN (SELECT product_id FROM product WHERE user_id = ?)',
          [userId],
          (error, results) => {
            if (error) {
              console.error('Error deleting used_product records:', error);
              return reject('Failed to delete account');
            }
            
            // SQL query to delete the products associated with the user
            db.query(
              'DELETE FROM shopping_cart WHERE user_id = ?',
              [userId],
              (error, results) => {
                if (error) {
                  console.error('Error deleting products:', error);
                  return reject('Failed to delete account');
                }
                
                // SQL query to delete records from the shoppingcart table
                db.query( //DELETE FROM product WHERE user_id = ?
                  'DELETE FROM product WHERE user_id = ?',
                  [userId],
                  (error, results) => {
                    if (error) {
                      console.error('Error deleting shoppingcart:', error);
                      return reject('Failed to delete account');
                    }
                    
                    // SQL query to delete the user account
                    db.query(
                      'DELETE FROM user WHERE user_id = ?',
                      [userId],
                      (error, results) => {
                        if (error) {
                          console.error('Error deleting account:', error);
                          return reject('Failed to delete account');
                        }
                        
                        if (results.affectedRows === 0) {
                          // No rows affected, meaning no user with the specified ID found
                          return reject('User not found');
                        }
                        
                        console.log('Account deleted successfully');
                        return resolve('Account deleted successfully');
                      }
                    );
                  }
                );
              }
            );
          }
        );
      }
    );
  });
}

*/

deleteacountt(userId) {
  console.log('deleteacountt function called with userId:', userId);
  return new Promise((resolve, reject) => {
    // SQL query to delete records from the new_product table where product_id is associated with the user
    db.query(
      'DELETE FROM new_product WHERE product_id IN (SELECT product_id FROM product WHERE user_id = ?)',
      [userId],
      (error, results) => {
        if (error) {
          console.error('Error deleting new_product records:', error);
          return reject('Failed to delete account');
        }
        
        // SQL query to delete records from the used_product table where product_id is associated with the user
        db.query(
          'DELETE FROM used_product WHERE product_id IN (SELECT product_id FROM product WHERE user_id = ?)',
          [userId],
          (error, results) => {
            if (error) {
              console.error('Error deleting used_product records:', error);
              return reject('Failed to delete account');
            }
            
            // SQL query to delete records from the productimage table where product_id is associated with the user
            db.query(
              'DELETE FROM productimage WHERE product_id IN (SELECT product_id FROM product WHERE user_id = ?)',
              [userId],
              (error, results) => {
                if (error) {
                  console.error('Error deleting productimage records:', error);
                  return reject('Failed to delete account');
                }
               
                
                db.query(
                  'DELETE FROM shopping_cart WHERE user_id = ?',
                  [userId],
                  (error, results) => {
                    if (error) {
                      console.error('Error deleting shopping_cart records:', error);
                      return reject('Failed to delete account');
                    }
                    
                  
                    db.query(
                      'DELETE FROM product WHERE user_id = ?',
                      [userId],
                      (error, results) => {
                        if (error) {
                          console.error('Error deleting product records:', error);
                          return reject('Failed to delete account');
                        }
                        
                        
                        db.query(
                          'DELETE FROM pay WHERE user_id = ?',
                          [userId],
                          (error, results) => {
                            if (error) {
                              console.error('Error deleting pay records:', error);
                              return reject('Failed to delete account');
                            }

                            // SQL query to delete the user account
                            db.query(
                              'DELETE FROM user WHERE user_id = ?',
                              [userId],
                              (error, results) => {
                                if (error) {
                                  console.error('Error deleting account:', error);
                                  return reject('Failed to delete account');
                                }

                                if (results.affectedRows === 0) {
                                  // No rows affected, meaning no user with the specified ID found
                                  return reject('User not found');
                                }

                                console.log('Account deleted successfully');
                                return resolve('Account deleted successfully');
                              }
                            );
                          }
                        );
                      }
                    );
                  }
                );
              }
            );
          }
        );
      }
    );
  });
}



/*
deleteacountt(userId) {
  console.log('deleteacountt function called with userId:', userId);
  return new Promise((resolve, reject) => {
    // SQL query to delete records from the new_product table where product_id is associated with the user
    db.query(
      'DELETE FROM new_product WHERE product_id IN (SELECT product_id FROM product WHERE user_id = ?)',
      [userId],
      (error, results) => {
        if (error) {
          console.error('Error deleting new_product records:', error);
          return reject('Failed to delete account');
        }
        
        // SQL query to delete records from the used_product table where product_id is associated with the user
        db.query(
          'DELETE FROM used_product WHERE product_id IN (SELECT product_id FROM product WHERE user_id = ?)',
          [userId],
          (error, results) => {
            if (error) {
              console.error('Error deleting used_product records:', error);
              return reject('Failed to delete account');
            }
            
            // SQL query to delete records from the productimage table where product_id is associated with the user
            db.query(
              'DELETE FROM productimage WHERE product_id IN (SELECT product_id FROM product WHERE user_id = ?)',
              [userId],
              (error, results) => {
                if (error) {
                  console.error('Error deleting productimage records:', error);
                  return reject('Failed to delete account');
                }
                
                // SQL query to delete the products associated with the user
                db.query(
                  'DELETE FROM shopping_cart WHERE user_id = ?',
                  [userId],
                  (error, results) => {
                    if (error) {
                      console.error('Error deleting products:', error);
                      return reject('Failed to delete account');
                    }
                    
                    // SQL query to delete records from the shoppingcart table
                    db.query(
                      'DELETE FROM product WHERE user_id = ?',
                      [userId],
                      (error, results) => {
                        if (error) {
                          console.error('Error deleting shoppingcart:', error);
                          return reject('Failed to delete account');
                        }
                        
                        // SQL query to delete the user account
                        db.query(
                          'DELETE FROM user WHERE user_id = ?',
                          [userId],
                          (error, results) => {
                            if (error) {
                              console.error('Error deleting account:', error);
                              return reject('Failed to delete account');
                            }
                            
                            if (results.affectedRows === 0) {
                              // No rows affected, meaning no user with the specified ID found
                              return reject('User not found');
                            }
                            
                            console.log('Account deleted successfully');
                            return resolve('Account deleted successfully');
                          }
                        );
                      }
                    );
                  }
                );
              }
            );
          }
        );
      }
    );
  });
}
*/
  /// product home page 


  UpdatePass(req, res) {
    const { email, newPassword } = req.body;
    console.log(email, newPassword);
    return new Promise((resolve, reject) => {
      console.log('aaaaaaaaaa');
      bcrypt.hash(newPassword, 10, async (hashError, hashedPassword) => {
        if (hashError) {
          console.error('Error hashing the password:', hashError);
          return res.status(500).json({
            status: 'error',
            message: 'Error hashing the password',
          });
        }

        let newPass = hashedPassword;
        console.log(newPass);
        db.query(
          'UPDATE User SET password = ? WHERE email = ?',
          [newPass, email],
          (error, results) => {
              if (error) {
                  reject('Failed to update password');
              } else {
                  resolve('Password updated successfully');
              }
          }
      );

      });

    });
}


//
//oldpasswordcheck
oldpassword(email, oldPassword) {
  return new Promise((resolve, reject) => {
    console.log(email);
    console.log(oldPassword);
    // Query to fetch the user's stored password from the database based on their email
    db.query(
      'SELECT password FROM user WHERE email = ?',
      [email],
      (error, results) => {
        if (error) {
          console.error('Error checking old password:', error);
          return reject('Internal server error.');
        }

        // Check if the user exists
        if (results.length === 0) {
          console.log(results.length);
          console.log('\n \n ');
          return reject('User not found.');
        }

        const storedPassword = results[0].password;

        // Compare the provided old password with the stored password
        bcrypt.compare(
          oldPassword,
          storedPassword,
          (compareError, passwordMatch) => {
            if (compareError) {
              console.error('Error comparing passwords:', compareError);
              return reject('Internal server error.');
            }

            if (passwordMatch) {
              // Old password matches the stored password
              console.log('Old password matches the stored password');
              resolve(true);
            } else {
              console.log('New password not matches the stored password');
              // Old password does not match the stored password
              resolve(false);
            }
          }
        );
      }
    );
  });
}


// ibtisam 

getdatauser(req, res){
  
  return new Promise((resolve, reject) => {
    // Check if the user already exists (Checking the email)
    db.query(
      'SELECT first_name, last_name,email, user_type , user_id  FROM user ',  // change alsooooo 
   
      (error, results) => {
        if (error) {
          return reject('Internal server error.');
        }

        return resolve(results);

      
        
     
      },
    );
  });
}

updateadminofuser(req, res) {
  const { first_name, last_name, email, user_type } = req.body;

  db.query(
    'UPDATE user SET first_name = ?, last_name = ?, user_type = ? WHERE email = ?',
    [first_name, last_name, user_type, email],
    (err, result) => {
      if (err) {
        res.status(500).send({ error: 'Failed to update user' });
      } else {
        res.status(201).send();
      }
    }
  );

  /*
  const { first_name, last_name, email, user_type } = req.body;
  db.query('UPDATE user  SET first_name = ?, last_name = ?, user_type = ? WHERE email = ?',
  [first_name, last_name, email, user_type ],
    (error, results) => {
    if (error) {
      return reject('Internal server error.');
    }
    return resolve(results);
  },
  );*/
}


// aya newwww
userInteraction(req, res) {
  let { productId, userId, view, addToCart, purchased } = req.body;
  
  return new Promise((resolve, reject) => {
    db.query(
      'SELECT * FROM user_interaction WHERE product_id = ? AND user_id = ?', [productId, userId],
      (error, results) => {
        if (error) {
          console.log(error);
          return reject('Failed to select user interaction');
        } else {
          if (results.length == 0) {
            db.query(
              'INSERT INTO user_interaction (product_id, user_id, viewed, added_to_cart, purchased) VALUES (?, ?, ?, ?, ?)',
              [productId, userId, view, addToCart, purchased],
              (error1, results1) => {
                if (error1) {
                  console.log(error1);
                  return reject('Failed to insert user interaction');
                } else {
              
                  db.query(
                    'SELECT * FROM user_interaction WHERE user_id = ? ORDER BY created_at ASC',
                    [userId],
                    (error2, results2) => {
                      if (error2) {
                        console.log(error2);
                        return reject('Failed to fetch user interactions');
                      } else if (results2.length > 5) {
                        const oldestInteractionId = results2[0].interaction_id;
                        db.query(
                          'DELETE FROM user_interaction WHERE interaction_id = ?',
                          [oldestInteractionId],
                          (error3, results3) => {
                            if (error3) {
                              console.log(error3);
                              return reject('Failed to delete oldest user interaction');
                            } else {
                              return resolve('Stored user interaction successfully and maintained the limit of 5 interactions');
                            }
                          }
                        );
                      } else {
                        return resolve('Stored user interaction successfully');
                      }
                    }
                  );
                }
              }
            );
          } else {
           
            let viewProd = results[0].viewed;
            let addedToCart = results[0].added_to_cart;
            let purchasedProd = results[0].purchased;

            if (view == 0 && viewProd == 1) {
              view = 1;
            }
            if (addToCart == 0 && addedToCart == 1) {
              addToCart = 1;
            }
            if (purchased == 0 && purchasedProd == 1) {
              purchased = 1;
            }
console.log('hhhhhhhellllllo');
            db.query(
              'UPDATE user_interaction SET viewed = ?, added_to_cart = ?, purchased = ? WHERE user_id = ? AND product_id = ?',
              [view, addToCart, purchased, userId, productId],
              (error2, results2) => {
                if (error2) {
                  console.log(error2);
                  return reject('Failed to update user interaction');
                } else {
                  return resolve('Updated user interaction successfully');
                }
              }
            );
          }
        }
      }
    );
  });
}
//
deliveryEmployee(type) {
  return new Promise((resolve, reject) => {


    db.query('SELECT user_id,first_name,last_name,email,phone_number,address,user_type FROM user WHERE user_type = ?', [type], (error, results) => {
      if (error || results.length==0) {
        console.error(error);
        reject(' not found');
      } 
      else{
        resolve({results});}
  });
  });
}

deliveryFromSellar(productId) {
  return new Promise((resolve, reject) => {
    console.log({productId});
    db.query('SELECT user_id FROM product WHERE product_id = ?', [productId], (error, results) => {
      if (error || results.length==0) {
        console.error(error);
        reject(' not found');
      } 
      else{
        const userId=results[0].user_id;
        console.log({userId});
       // resolve({results});
       db.query('SELECT user_id,first_name,last_name,email,phone_number,address,user_type FROM user WHERE user_id = ?', [userId], (error, results) => {
        if (error || results.length==0) {
          console.error(error);
          reject(' not found');
        } 
        else{
          resolve({results});}
    });
      }
  });

  });
}

deliverydetialsOfBuyer(userId) {
  return new Promise((resolve, reject) => {


    db.query('SELECT first_name,last_name,email,phone_number,address,user_type FROM user WHERE user_id = ?', [userId], (error, results) => {
      if (error || results.length==0) {
        console.error(error);
        reject(' not found');
      } 
      else{
        resolve({results});}
  });
  });
}

// yoyo

//addProfileImage


addProfileImage = (req, res) => {
  const { email, userId } = req.body;

  console.log(email, userId);

  return new Promise((resolve, reject) => {
    

      const firstimagePath = req.files[0].path;
      fs.readFile(firstimagePath, (err, datafirstimage) => {
        if (err) {
          return reject('Error reading file');
        }

      
    else {
      db.query(
        'UPDATE user SET profile_image = ? WHERE user_id = ?',
        [datafirstimage,userId],
        (error2, results2) => {
          if (error2) {
            return reject('Failed to update product');
          }
          else{

          }

         
        }
      );
    }
  });
    
  });
};

//getProfileImage

getProfileImage(userId) {
  return new Promise((resolve, reject) => {


    db.query('SELECT * FROM user WHERE user_id = ?', [userId], (error, results) => {
      if (error || results.length==0) {
        console.error(error);
        reject(' not found');
      } 
      else{
        resolve({results});}
  });
  });
}
// yoyo












































  /// product home page 


}
module.exports = UserRepository;