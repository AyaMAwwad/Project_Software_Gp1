


const mysql = require('mysql2');

const path = require('path');
const fs = require('fs');

// Inside your addProduct function


const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '12345678',
  database: 'shoppingdatabse',
});

class ProductRepository {

 
  /// product home page 
   /// product home page 
   getproduct(req, res) {
    db.query('SELECT * FROM Product', (error, results) => {
      console.log({results});
      if (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error' });
      } else {
        res.status(200).json(results);
        //   print("coreecttttttt");
      }
    });
  }
// getnewprice

  getProductImages(productId) {
    return new Promise((resolve, reject) => {
      db.query('SELECT image_data FROM ProductImage WHERE product_id = ?', [productId], (error, results) => {
        console.log({results});
        if (error) {
          console.error(error);
          reject('Failed to fetch product images');
        } else {
          console.log({results});
          resolve(results);
        }
      });
    });
  }
  getnewprice(id) {
    return new Promise((resolve, reject) => {
      db.query('SELECT price FROM New_Product WHERE product_id = ?', [id], (error, results) => {
        if (error) {
          console.error(error);
          reject('Failed to fetch product images');
        } else {
        //  console.log({results});
          resolve(results);
        }
      });
    });
  }


addProduct(req, res) {
  
//numberofimage
  const { email,name, category, state, description, price, quantity,image, numberofimage,detailsOfState,typeOfCategory,productFreeCond,imagedata } = req.body;

  console.log(email,name, category, state, description, price, quantity,image,numberofimage,detailsOfState,typeOfCategory,productFreeCond,imagedata);
  
 
  return new Promise((resolve, reject) => {
   
   


    db.query(
      'SELECT user_id FROM user WHERE email = ? ',
      [email],
      (error, results) => {
        if (error) {
          return reject('you are not user');
        }
       const userid=results[0].user_id;
          db.query(
            'INSERT INTO Category (name, type) VALUES (?, ?)',
            [category, typeOfCategory],
            (error1, results1) => {
              if (error1) {
                return reject('Failed to insert category');
              }
              
             const categoryid=results1.insertId;
           
            
              for (let i = 0; i < numberofimage; i++) {
                const aya = req.files[i].path;
              fs.readFile(aya, (err, data) => {
                if (err) {
                  return reject('Error reading file');
                }
             
              
             db.query(
              'INSERT INTO product (name, description, quantity, category_id, user_id,image) VALUES ( ?, ?, ?, ?, ?,?)',
              [name, description, quantity, categoryid, userid, data
        

              ],
              (error2, results2) => {
                if (error2) {
                  return reject('Failed to insert product');
                }
               
            
                const productId = results2.insertId;
                if(i==0) {
          if (state === 'New') {
          
           
            db.query(
              'INSERT INTO new_product (product_id, warranty_period,price) VALUES (?, ?, ?)',
              [productId,detailsOfState,price],
              (error3, results3) => {
                if (error3) {
                  return reject('Failed to insert New product ');
                }
                return resolve('inserted new product successfully.');
              }


            );

          } 
          else if (state === 'Used'){
              db.query(
                'INSERT INTO used_product (product_id, product_condition, price) VALUES (?, ?, ?)',
                [productId, detailsOfState,price],
              (error4, results3) => {
                if (error4) {
                  return reject('Failed to insert Used product ');
                }
                return resolve('inserted Used product successfully.');
              }


            );

          }
          else if (state === 'Free'){
           
            db.query(
             
             'INSERT INTO free_product (product_id, state_free,product_condition) VALUES (?, ?, ?)',
              [productId, detailsOfState,productFreeCond],
             (error5, results3) => {
              
                if (error5) {
                  return reject('Failed to insert Free product ');
                }
  
                return resolve('inserted Free product successfully.');
              }


            );
            
          }
        }

              }

             );
            });}
            }

            ///aegosh
            
            );
            }

           
          );
        
      },
    );
 //});
}

}
   
module.exports = ProductRepository;
