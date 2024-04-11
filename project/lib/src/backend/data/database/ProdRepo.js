


const mysql = require('mysql2');

const path = require('path');
const fs = require('fs');
const { Console } = require('console');

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
  
 let prodID=0;
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
             
                if(i==0) {
             db.query(
              'INSERT INTO product (name, description, quantity, category_id, user_id,image,product_type) VALUES ( ?, ?, ?, ?, ?,?,?)',
              [name, description, quantity, categoryid, userid, data,state
        

              ],
              (error2, results2) => {
                if (error2) {
                  return reject('Failed to insert product');
                }
               
            
                const productId = results2.insertId;
                prodID=results2.insertId;
              
          if (state == 'New') {
        
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
          else if (state == 'Used'){
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
          else if (state == 'Free'){
           
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
       /////////////
        

              }
////////////////////////
             );
            }
            else {
              console.log('aaaaaaaaaaaaaaaa');
              console.log(prodID);
              console.log(data);
              db.query(
                'SELECT product_id FROM product WHERE category_id = ? ',
                [categoryid],
                (error6, results) => {
                  if (error6) {
                    return reject('you are not user');
                  }
                  const IDOfProd=results[0].product_id;
                  console.log(IDOfProd);
                  //console.log(data);
              
              db.query(
            
                'INSERT INTO productimage (product_id, image_data ) VALUES (?, ?)',
                 [IDOfProd, data],
                (error5, results3) => {
                 
                   if (error5) {
                     return reject('Failed to insert Sub Image product ');
                   }
     
                   return resolve('inserted Sub Image successfully.');
                 }
   
   
               );});

            }
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

//new gettypeofproduct
gettypeofproduct(category,type,state) {
  console.log(category);
  console.log(type);
  console.log(state);
  return new Promise((resolve, reject) => {
    db.query('SELECT category_id FROM category WHERE name = ? AND type = ?', [category,type], (error, results) => {
      if (error || results.length==0) {
        console.error(error);
        reject('Failed to retrive category');
      } else {
        const theRes= results;
        console.log(theRes);
        const allProductData = [];
        const allProductDetails = [];

        // Iterate over each category ID
        theRes.forEach(categoryRow => {
          const categoryId = categoryRow.category_id; // Assuming your category ID column name is category_id
          // Perform a query to retrieve product data for the current category ID
          db.query('SELECT product_id,name,description,quantity,user_id,image FROM product WHERE category_id = ? AND product_type = ?', [categoryId,state], (error1, res1) => {
            if (error1) {
              console.error(error1);
              reject('Failed to retrieve product data');
            } else {
              // Add the product data for the current category ID to the array
              allProductData.push(...res1);
              console.log(allProductData);
              // Check if this was the last category ID, then resolve the promise with all product data
             // if (allProductData.length === theRes.length) {
             //   resolve(allProductData);
             // }
             
             if (allProductData.length <= theRes.length) {
             let Query='';
              if(state== 'New'){
                Query='SELECT warranty_period,price FROM new_product WHERE product_id = ?'
              }
              else if(state=='Used'){
                Query='SELECT product_condition,price FROM used_product WHERE product_id = ?'
              }
              else if(state=='Free'){
                Query='SELECT product_condition,state_free FROM free_product WHERE product_id = ?'
              }
             
             // Iterate over each product in allProductData
            allProductData.forEach(product => {
          //  console.log(allProductData[0]['product_id']); =allProductData[0]['product_id']; 
                 const productId =product.product_id;
                 db.query(Query, [productId], (error2, res2) => {
                  if (error2) {
                      console.error(error2);
                      reject('Failed to retrieve data from new_product table');
                  } else {
                      // Add the retrieved data to allProductDetails
                      res2.forEach(entry => {
                        const found = allProductDetails.find(item => JSON.stringify(item) === JSON.stringify(entry));
                        if (!found) {
                            allProductDetails.push(entry);
                        }
                    });
                     // allProductDetails.push(...res2);
                     
                      console.log(allProductDetails);
                      // Check if all products have been processed
                    if (allProductDetails.length == allProductData.length) {
                        resolve({ allProductData, allProductDetails });// resolve(allProductDetails);
                      }
                      else if(allProductDetails.length==0) {
                        reject('Not have data to retrieve ');
                      }
                    
                  }
              });
             });

            }
            else if(allProductData.length==0) {
              reject('Not have data to retrieve ');
            }
            }
          });
        });
    
      }
    }); 
   
  });
}
}
   
module.exports = ProductRepository;
