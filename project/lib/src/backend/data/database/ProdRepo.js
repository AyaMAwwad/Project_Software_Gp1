
const mysql = require('mysql2');
//const { PythonShell } = require('python-shell');
const path = require('path');
const fs = require('fs');
const { Console } = require('console');
const { use } = require('../../routes/userRoute');
const recommendations = require('../../AI/collaborative-filtering');
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
  }m
  // ibtisam used

  getusedprice(id) {
    return new Promise((resolve, reject) => {
      db.query('SELECT price FROM used_product WHERE product_id = ?', [id], (error, results) => {
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





  // ibtisam  used


  addProduct = (req, res) => {
    const { email, name, category, state, description, price, quantity, numberofimage, detailsOfState, typeOfCategory, productFreeCond, currency, delivery } = req.body;
  
    console.log(email, name, category, state, description, price, quantity, numberofimage, detailsOfState, typeOfCategory, productFreeCond, currency);
  
    return new Promise((resolve, reject) => {
      db.query('SELECT user_id, user_type FROM user WHERE email = ?', [email], (error, results) => {
        if (error) {
          return reject('You are not a user');
        }
  
        const userId = results[0].user_id;
        let userType = results[0].user_type;
  
        db.query('INSERT INTO Category (name, type) VALUES (?, ?)', [category, typeOfCategory], (error1, results1) => {
          if (error1) {
            return reject('Failed to insert category');
          }
  
          const categoryId = results1.insertId;
          let productId;
  
          const insertProduct = () => {
            const firstimagePath = req.files[0].path;
            fs.readFile(firstimagePath, (err, datafirstimage) => {
              if (err) {
                return reject('Error reading file');
              }

            
          else {
            db.query(
              'INSERT INTO product (name, description, quantity, category_id, user_id, image, product_type, currency, Delivery_option) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
              [name, description, quantity, categoryId, userId,datafirstimage, state, currency, delivery],
              (error2, results2) => {
                if (error2) {
                  return reject('Failed to insert product');
                }
  
                productId = results2.insertId;
                insertProductDetails();
                insertAdditionalImages();
              }
            );
          }
        });
            
          };
  
          const insertProductDetails = () => {
            if (state == 'New' || state == 'جديد') {
              db.query('INSERT INTO new_product (product_id, warranty_period, price) VALUES (?, ?, ?)', [productId, detailsOfState, price], (error3) => {
                if (error3) {
                  return reject('Failed to insert new product');
                }
              });
            } else if (state == 'Used' || state == 'مستعمل') {
              db.query('INSERT INTO used_product (product_id, product_condition, price) VALUES (?, ?, ?)', [productId, detailsOfState, price], (error4) => {
                if (error4) {
                  return reject('Failed to insert used product');
                }
              });
            } else if (state == 'Free' || state == 'مجاني') {
              db.query('INSERT INTO free_product (product_id, state_free, product_condition) VALUES (?, ?, ?)', [productId, detailsOfState, productFreeCond], (error5) => {
                if (error5) {
                  return reject('Failed to insert free product');
                }
              });
            }
          };
  
          const insertAdditionalImages = () => {
            for (let i = 1; i < numberofimage; i++) {
              const imagePath = req.files[i].path;
              fs.readFile(imagePath, (err, data) => {
                if (err) {
                  return reject('Error reading file');
                }
  
                db.query('INSERT INTO productimage (product_id, image_data) VALUES (?, ?)', [productId, data], (error6) => {
                  if (error6) {
                    return reject('Failed to insert product image');
                  }
                });
              });
            }
          };
  
          const updateUserType = () => {
            if (userType.toLowerCase() === 'buyer' || userType === 'مشتري') {
              userType = 'Seller';
              db.query('UPDATE user SET user_type = ? WHERE user_id = ?', [userType, userId], (error7) => {
                if (error7) {
                  return reject('Failed to update user type');
                }
              });
            }
          };
  
          insertProduct();
          updateUserType();
          resolve('Inserted product successfully');
        });
      });
    });
  };
  /*addProduct(req, res) {
  
//numberofimage
  const { email,name, category, state, description, price, quantity,image, numberofimage,detailsOfState,typeOfCategory,productFreeCond,imagedata,currency,delivery } = req.body;

  console.log(email,name, category, state, description, price, quantity,image,numberofimage,detailsOfState,typeOfCategory,productFreeCond,imagedata,currency);
  
 let prodID=0;
  return new Promise((resolve, reject) => {
   
    
   

    db.query(
      'SELECT user_id,user_type FROM user WHERE email = ? ',
      [email],
      (error, results) => {
        if (error) {
          return reject('you are not user');
        }
        console.log('aaaaa');
       const userid=results[0].user_id;
       let userType=results[0].user_type;
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
              'INSERT INTO product (name, description, quantity, category_id, user_id,image,product_type,currency,Delivery_option) VALUES ( ?, ?, ?, ?, ?,?,?,?,?)',
              [name, description, quantity, categoryid, userid, data,state,currency,delivery
        

              ],
              (error2, results2) => {
                if (error2) {
                  return reject('Failed to insert product');
                }
               
            
                const productId = results2.insertId;
                prodID=results2.insertId;
              
          if (state == 'New' || state == 'جديد') {
        
            db.query(
              'INSERT INTO new_product (product_id, warranty_period,price) VALUES (?, ?, ?)',
              [productId,detailsOfState,price],
              (error3, results3) => {
                if (error3) {
                  return reject('Failed to insert New product ');
                }
               // return resolve('inserted new product successfully.');
              }


            );

          } 
          else if (state == 'Used'|| state == 'مستعمل'){
              db.query(
                'INSERT INTO used_product (product_id, product_condition, price) VALUES (?, ?, ?)',
                [productId, detailsOfState,price],
              (error4, results3) => {
                if (error4) {
                  return reject('Failed to insert Used product ');
                }
               // return resolve('inserted Used product successfully.');
              }


            );

          }
          else if (state == 'Free'|| state == 'مجاني'){
           
            db.query(
             
             'INSERT INTO free_product (product_id, state_free,product_condition) VALUES (?, ?, ?)',
              [productId, detailsOfState,productFreeCond],
             (error5, results3) => {
              
                if (error5) {
                  return reject('Failed to insert Free product ');
                }
  
              //  return resolve('inserted Free product successfully.');
              }


            );
            
          }
          if(userType =='Buyer' || userType =='buyer' || userType =='مشتري'){
            userType='Sellar';
          db.query(
          
             
            'UPDATE user SET user_type = ? WHERE user_id = ?',
             [userType,userid],
            (error5, results3) => {
             
               if (error5) {
                 return reject('Failed to insert Free product ');
               }
 
             //  return resolve('inserted Free product successfully.');
             }


           );
          }
           return resolve('inserted  product successfully.');
   

              }

             );
            }
            else {
              console.log('aaaaaaaaaaaaaaaa');
              console.log(prodID);
              console.log(data);
              console.log(categoryid);
              db.query(
                'SELECT product_id FROM product WHERE category_id = ? ',
                [categoryid],
                (error6, results) => {
                  if (error6) {
                    return reject('you are not user');
                  }
                  console.log(results);
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
                   if(userType =='Buyer' || userType =='buyer' || userType =='مشتري'){
                    userType='Sellar';
                  db.query(
                  
                     
                    'UPDATE user SET user_type = ? WHERE user_id = ?',
                     [userType,userid],
                    (error5, results3) => {
                     
                       if (error5) {
                         return reject('Failed to insert Free product ');
                       }
         
                     //  return resolve('inserted Free product successfully.');
                     }
        
        
                   );
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
}*/
// aega
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
          db.query('SELECT product_id,name,description,quantity,user_id,image,Delivery_option,currency,average_rating FROM product WHERE category_id = ? AND product_type = ?', [categoryId,state], (error1, res1) => {
            if (error1) {
              console.error(error1);
              reject('Failed to retrieve product data');
            } else {
              // Add the product data for the current category ID to the array
              allProductData.push(...res1);
              
           
             
             if (allProductData.length <= theRes.length) {
             let Query='';
              if(state== 'New' || state== 'جديد'){
                Query='SELECT * FROM new_product WHERE product_id = ?'
              }
              else if(state=='Used'|| state== 'مستعمل'){
                Query='SELECT * FROM used_product WHERE product_id = ?'
              }
              else if(state=='Free'|| state== 'مجاني'){
                Query='SELECT * FROM free_product WHERE product_id = ?'
              }
             
             // Iterate over each product in allProductData
            allProductData.forEach(product => {
          //  console.log(allProductData[0]['product_id']); =allProductData[0]['product_id']; 
                 const productId =product.product_id;
                 let prevId='';
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
                   /*   res2.forEach(entry => {
                        const found = allProductDetails.find(item => JSON.stringify(item) === JSON.stringify(entry));
                        if (!found || prevId!=productId) {
                            allProductDetails.push(entry);
                            prevId=productId;
                        }
                    });*/
                     // allProductDetails.push(...res2);
                     
                      console.log(allProductDetails);
                      
                      // Check if all products have been processed
                    if (allProductDetails.length == allProductData.length) {
                      console.log('aaaayyya');
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
// aega
////// nnneeeeew addToShopCart
addToShopCart(req, res) {
  
  //numberofimage
    const { id,Number_Item,date,name,state ,description } = req.body;
  
    console.log(name,state,description );
    return new Promise((resolve, reject) => {

      db.query('SELECT product_id FROM product WHERE name = ? AND product_type = ? AND description=?', [name,state,description], (error1, res1) => {
        if (error1) {
         // console.error(error1);
          reject('Failed to store to cart ');
        } else {
          console.log(res1[0]);
          const productid=res1[0].product_id;
          const theDate = new Date();

          console.log(productid);
          db.query(
            'SELECT * FROM shopping_cart WHERE product_id = ?',
            [productid],
         
            (error3, results3) => {
                if (error3) {
                  
                  console.log('**************');
                    return reject('Failed to store to cart ');
                }
                else if (results3.length > 0) {
                  console.log(results3);
                  console.log('^^^^^^^^^^^^^^^');
                    return reject('This item is already in the cart');
                }
                else {
                    // Proceed with inserting into the shopping_cart table
                    db.query(
                        'INSERT INTO shopping_cart (item, date_cart, user_id, product_id) VALUES (?, ?, ?, ?)',
                        [Number_Item, theDate, id, productid],
                        (error2, results2) => {
                            if (error2) {
                                return reject('Failed to store to cart');
                            }
                            return resolve('Stored to cart successfully');
                        }
                    );
                }
            }
        );
        

     

          

        }
      });
   
 } );
  
    
}
//getToShopCart
getToShopCart(userId) {

  return new Promise((resolve, reject) => {
    console.log(userId);

    
    db.query('SELECT * FROM shopping_cart WHERE user_id = ?',[userId], (error, results) => {
      if (error || results.length==0) {
        console.error(error);
        reject('Failed to retrive from cart ');
      } else {
        const theRes= results;
        const allProductData = [];
        const allProductDetails = [];
        console.log(theRes);
      

        // Iterate over each category ID
        theRes.forEach(cartRow => {
          const prodId = cartRow.product_id; 
          console.log(prodId);
          db.query('SELECT * FROM product WHERE product_id = ?', [prodId], (error1, res1) => {
            if (error1) {
              console.error(error1);
              reject('Failed to retrieve product data');
            } else {
              // Add the product data for the current category ID to the array
              allProductData.push(...res1);
              console.log(allProductData);
            
              
             if (allProductData.length == theRes.length) {
             
             
             // Iterate over each product in allProductData
            allProductData.forEach(product => {
          //  console.log(allProductData[0]['product_id']); =allProductData[0]['product_id']; 
                 const productId =product.product_id;
                 const state= product.product_type;
                 console.log(state);
                 let Query='';
                 if(state== 'New' || state== 'new'|| state== 'جديد'){
                  // yosha convert to * 
                   Query='SELECT * FROM new_product WHERE product_id = ?'
                 }
                 else if(state=='Used'|| state== 'used'|| state== 'مستعمل'){
                   Query='SELECT * FROM used_product WHERE product_id = ?'
                 }
                /* else if(state=='Free'|| state== 'free' ||state== 'مجاني'){
                   Query='SELECT product_condition,state_free FROM free_product WHERE product_id = ?'
                 }*/
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
                        resolve({theRes, allProductData, allProductDetails });
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
             // resolve({theRes,allProductData});
             //}
            }
          });
        });

      }
    });
  });
}
//////deleteFromShopCart
deleteFromShopCart(productId) {
  return new Promise((resolve, reject) => {

    
    db.query('DELETE FROM shopping_cart WHERE product_id = ?',[productId], (error, results) => {
      if (error) {
        console.error(error);
        reject('Failed to Delete ');
      } else {
        resolve("success deleted");
      }
    });
  });
  
};



/////////////////// nneeeeeeeeeeew  retriveWordOfsearch
retriveWordOfsearch(name) {
  return new Promise((resolve, reject) => {//p.description AS product_description,
//p.image AS image,
    const query = `
    SELECT p.name AS product_name, c.name AS category_name, c.type AS category_type
    FROM Product p
    JOIN Category c ON p.category_id = c.category_id
    WHERE p.name LIKE CONCAT('%', ?, '%') OR c.name LIKE CONCAT('%', ?, '%')  OR c.type LIKE CONCAT('%', ?, '%')
  `;
    db.query(query, [name, name,name],  (error, results) => {
      if (error || results.length==0) {
        console.error(error);
        reject('Failed to Search ');
      } else {
        console.log('Search results:', results);
        resolve(results);
      }
    });
  });}

   //retriveProductOfsearch 1_MAY
   retriveProductOfsearch(name) {
    return new Promise((resolve, reject) => {
      const allProductDetails = [];
 
      const query = `
      SELECT Product.*
      FROM Product
      JOIN Category ON Product.category_id = Category.category_id
      WHERE LOWER(Product.name) = LOWER(?)
      OR LOWER(Category.type) = LOWER(?);

    `;
    console.log(name);
      db.query(query, [name, name],  (error, results) => {
        if (error || results.length==0) {
          console.error(error);
          reject('Failed to Search ');
        } else {
          console.log('ayyyyyyyyyyya');
          console.log( results);
          results.forEach(product => {
           
                   const productId =product.product_id;
                   let prevId='';
                   const state= product.product_type;
                   console.log(state);
                   let Query='';
                   if(state== 'New' || state== 'new'|| state== 'جديد'){
                     Query='SELECT warranty_period,price FROM new_product WHERE product_id = ?'
                   }
                   else if(state=='Used'|| state== 'used'|| state== 'مستعمل'){
                     Query='SELECT product_condition,price FROM used_product WHERE product_id = ?'
                   }
                   else if(state=='Free'|| state== 'free' ||state== 'مجاني'){
                     Query='SELECT product_condition,state_free FROM free_product WHERE product_id = ?'
                   }
                   db.query(Query, [productId], (error2, res2) => {
                    if (error2) {
                        console.error(error2);
                        reject('Failed to retrieve data from new_product table');
                    } else {
                       
                        res2.forEach(entry => {
                          const found = allProductDetails.find(item => JSON.stringify(item) === JSON.stringify(entry));
                          if (!found || prevId!=productId) {
                              allProductDetails.push(entry);
                              prevId=productId;
                          }
                      });
                      console.log(allProductDetails);
                      console.log(allProductDetails.length);
                      if (allProductDetails.length == results.length) {
                          resolve({results, allProductDetails });
                        }
                        else if(allProductDetails.length==0) {
                          reject('Not have data to retrieve ');
                        }
                      
                    }
                });
               });
        }
      });
    });}

    ///updateItemOnShopCart
    updateItemOnShopCart(req, res) {
      const { item,productId } = req.body;
      console.log(item);
      console.log(productId);
      return new Promise((resolve, reject) => {
      
          db.query(
            'UPDATE shopping_cart SET item = ? WHERE product_id = ?',
            [item,productId],
            (error, results) => {
                if (error) {
                    reject('Failed to update item in shop cart ');
                } else {
                    resolve('item in shop cart updated successfully');
                }
            }
        );
  
  
  
      });
  }
  ///// sallerProduct 12/5
  sallerProduct(userId) {
    return new Promise((resolve, reject) => {
      const allProductDetails = [];
  console.log(userId);
      db.query('SELECT * FROM product WHERE user_id = ? ', [userId],  (error, results) => {
        if (error ) {
          console.error(error);
          reject('Failed to retrive ');
        } else {
          if(results.length==0){
            reject('Not have data to retrieve ');
          }
          else{
          console.log('product saller results:', results);
          results.forEach(product => {
           
            const productId =product.product_id;
            let prevId='';
            const state= product.product_type;
            console.log(state);
            console.log(productId);
            let Query='';
            if(state== 'New' || state== 'new'|| state== 'جديد'){
              Query='SELECT * FROM new_product WHERE product_id = ?'
            }
            else if(state=='Used'|| state== 'used'|| state== 'مستعمل'){
              Query='SELECT * FROM used_product WHERE product_id = ?'
            }
            else if(state=='Free'|| state== 'free' ||state== 'مجاني'){
              Query='SELECT * FROM free_product WHERE product_id = ?'
            }
            db.query(Query, [productId], (error2, res2) => {
             if (error2) {
                 console.error(error2);
                 reject('Failed to retrieve data from new_product table');
             } else {
                console.log(res2);
                res2.forEach(entry => {
                  const found = allProductDetails.find(item => JSON.stringify(item) === JSON.stringify(entry));
                  if (!found || prevId!=productId) {
                      allProductDetails.push(entry);
                      prevId=productId;
                  }
              });
           
               if (allProductDetails.length == results.length) {
                   resolve({results, allProductDetails });
                 }
                 else if(allProductDetails.length==0) {
                   reject('Not have data to retrieve ');
                 }
               
             }
         });
         console.log('product saller :', allProductDetails);
        });
          //resolve(results);
          }
        }
      });
    });}
// 18/5 deleteItemSellar
// ayosh 
deleteItemSellar(productId,state) {
  console.log(productId);
  console.log(state);
  return new Promise((resolve, reject) => {
    db.query('DELETE FROM wishlist WHERE product_id = ?',[productId], (error, results) => {
      if (error) {
        console.error(error);
        reject('Failed to Delete ');
      } else {
    db.query('DELETE FROM user_interaction WHERE product_id = ?',[productId], (error, results) => {
      if (error) {
        console.error(error);
        reject('Failed to Delete ');
      } else {
    db.query('DELETE FROM productrating WHERE product_id = ?',[productId], (error, results) => {
      if (error) {
        console.error(error);
        reject('Failed to Delete ');
      } else {
    db.query('DELETE FROM shopping_cart WHERE product_id = ?',[productId], (error, results) => {
      if (error) {
        console.error(error);
        reject('Failed to Delete ');
      } else {
        db.query('DELETE FROM user_interaction WHERE product_id = ?',[productId], (error, results) => {
          if (error) {
            console.error(error);
            reject('Failed to Delete ');
          } else {
            db.query('DELETE FROM productimage WHERE product_id = ?',[productId], (error, results) => {
              if (error) {
                console.error(error);
                reject('Failed to Delete ');
              } else {
                let Query='';
                if(state== 'New' || state== 'new'|| state== 'جديد'){
                  Query='DELETE FROM new_product WHERE product_id = ?'
                }
                else if(state=='Used'|| state== 'used'|| state== 'مستعمل'){
                  Query='DELETE FROM used_product WHERE product_id = ?'
                }
                else if(state=='Free'|| state== 'free' ||state== 'مجاني'){
                  Query='DELETE FROM free_product WHERE product_id = ?'
                }
                db.query(Query, [productId], (error2, res2) => {
                 if (error2) {
                     console.error(error2);
                     reject('Failed to delete data from  table');
                 } else {
                  db.query('DELETE FROM product WHERE product_id = ?', [productId], (error2, res2) => {
                    if (error2) {
                        console.error(error2);
                        reject('Failed to delete data from table');
                    } else {
                      resolve("success deleted");
                    }});
                 }});
               // resolve("success deleted");
              }
            });
           // resolve("success deleted");
          }
        });
        //resolve("success deleted");
      }
    });
  }
});
  }
});
}
});
  });
  
};
// ayosh 

updateSellarProduct(req, res) {
  let { productId,name,type,prodState,quantity,cond } = req.body;

  console.log(productId,name,type,prodState,quantity,cond);
  return new Promise((resolve, reject) => {
  
      db.query(
        'UPDATE product SET name = ?, quantity = ?, product_type = ? WHERE product_id = ?',
        [name,quantity,type,productId],
        (error, results) => {
            if (error) {
                reject('Failed to update ');
            } else {
              let Query='';
                if(type== 'New' || type== 'new'|| type== 'جديد'){
                  Query='UPDATE new_product SET warranty_period =?, price = ? WHERE product_id = ?'
                }
                else if(type=='Used'|| type== 'used'|| type== 'مستعمل'){
                  Query='UPDATE used_product SET product_condition = ?, price = ? WHERE product_id = ?'
                }
                else if(type=='Free'|| type== 'free' ||type== 'مجاني'){
                  Query='UPDATE free_product SET product_condition = ?, state_free = ? WHERE product_id = ?'
                }
            
console.log(prodState,cond);
                
                db.query(Query, [cond,prodState ,productId], (error2, res2) => {
                  if (error2) {
                      console.error(error2);
                      reject('Failed to update data from  table');
                  } else {
                resolve('item updated successfully');
                  } 
                });
            }
        }
    );



  });
}
//addRatingProduct
addRatingProduct(req, res) {
  const { userId, ratings } = req.body;

  return new Promise((resolve, reject) => {
    const insertQueries = [];
    const updateQueries = [];

    console.log(userId);
    console.log(ratings);

    ratings.forEach((ratingV) => {
      const { product_id, rating } = ratingV;
      console.log(product_id, rating);

  
      db.query(
        'SELECT rating_id FROM ProductRating WHERE user_id = ? AND product_id = ?',
        [userId, product_id],
        (err, results) => {
          if (err) {
            console.error(err);
            return reject('Failed to fetch interactions');
          }

          if (results.length == 0) {
         
            db.query(
              'INSERT INTO ProductRating (user_id, product_id, rating) VALUES (?, ?, ?)',
              [userId, product_id, rating],
              (error2, results2) => {
                if (error2) {
                  console.error(error2);
                  return reject('Failed to store rating');
                } else {
         
                  db.query(
                    `UPDATE Product p
                    JOIN (
                      SELECT product_id, AVG(rating) AS avg_rating
                      FROM ProductRating
                      WHERE product_id = ?
                      GROUP BY product_id
                    ) pr ON p.product_id = pr.product_id
                    SET p.average_rating = pr.avg_rating
                    WHERE p.product_id = ?`,
                    [product_id, product_id],
                    (error3, results3) => {
                      if (error3) {
                        console.error(error3);
                        return reject('Failed to update average rating');
                      }
                    }
                  );
                }
              }
            );
          } else {
      
            db.query(
              'UPDATE ProductRating SET rating = ? WHERE user_id = ? AND product_id = ?',
              [rating, userId, product_id],
              (error2, results2) => {
                if (error2) {
                  console.error(error2);
                  return reject('Failed to update rating');
                } else {
              
                  db.query(
                    `UPDATE Product p
                    JOIN (
                      SELECT product_id, AVG(rating) AS avg_rating
                      FROM ProductRating
                      WHERE product_id = ?
                      GROUP BY product_id
                    ) pr ON p.product_id = pr.product_id
                    SET p.average_rating = pr.avg_rating
                    WHERE p.product_id = ?`,
                    [product_id, product_id],
                    (error3, results3) => {
                      if (error3) {
                        console.error(error3);
                        return reject('Failed to update average rating');
                      }
                    }
                  );
                }
              }
            );
          }
        }
      );
    });

    return resolve('Rated the product successfully');
  });
}

//retriveProductHomeRecomendedSystem
 retriveProductHomeRecomendedSystem(userId) {
  console.log(userId);
  return new Promise((resolve, reject) => {
    db.query(
      'SELECT product_id FROM user_interaction WHERE user_id = ? ORDER BY created_at DESC LIMIT 5',
      [userId],
      (err, interactionResults) => {
        if (err) {
          console.error(err);
          return reject('Failed to fetch interactions');
        }

        const productIds = interactionResults.map(row => row.product_id);

        if (productIds.length === 0) {
          return resolve('No interactions found');
        }

        const placeholders = productIds.map(() => '?').join(',');

        db.query(
          `SELECT p.product_id, p.name, p.description, p.category_id, c.name AS category_name, c.type AS category_type 
          FROM Product p 
          JOIN Category c ON p.category_id = c.category_id 
          WHERE p.product_id IN (${placeholders})`,
          productIds,
          (err2, productResults) => {
            if (err2) {
              console.error(err2);
              return reject('Failed to fetch product metadata');
            }

            db.query(
              `SELECT p.product_id, p.name, p.description, p.category_id, c.name AS category_name, c.type AS category_type 
              FROM Product p 
              JOIN Category c ON p.category_id = c.category_id`,
              (err3, allProducts) => {
                if (err3) {
                  console.error(err3);
                  return reject('Failed to fetch all products');
                }

                const productFeatures = allProducts.map(product => ({
                  id: product.product_id,
                  name: product.name,
                  category: product.category_type,
                  description: product.description
                }));

                const userInteractedProductIds = productResults.map(p => p.product_id);
                const userInteractions = allProducts.map(product => (
                  userInteractedProductIds.includes(product.product_id) ? 1 : 0
                ));

                const ratings = [
                  userInteractions,
                  ...new Array(4).fill(new Array(allProducts.length).fill(0))
                ];
                console.log(allProducts);

                const userInteractedTypes = new Set(productResults.map(p => p.category_type));

                const similarTypeProducts = allProducts.filter(product =>
                  userInteractedTypes.has(product.category_type)
                );

                const similarTypeProductIds = similarTypeProducts.map(p => p.product_id);
              /*  const r = [
                  [1, 1, 1],
                  [1, 0, 1],
                  [1, 1, 0],
                  [1, 1, 0],
                ];
*/
                const collabRecommendations = recommendations.cFilter(ratings, 0);
                console.log('collabRecommendations :' + collabRecommendations);

                const contentRecommendations = recommendations.contentBasedFiltering(productFeatures, productResults);
                console.log('contentRecommendations :' + contentRecommendations);

                const filteredContentRecommendations = contentRecommendations.filter(rec =>
                  similarTypeProductIds.includes(rec)
                );

                console.log('filteredContentRecommendations :' + filteredContentRecommendations);

                const hybridRecommendations = recommendations.combineRecommendations(collabRecommendations, filteredContentRecommendations);
                console.log('hybridRecommendations :' + hybridRecommendations);

                if (hybridRecommendations.length === 0) {
                  return resolve('No recommendations found');
                }

                const hybridPlaceholders = hybridRecommendations.map(() => '?').join(',');

                db.query(
                  `SELECT p.*, c.name AS category_name, c.type AS category_type 
                  FROM Product p 
                  JOIN Category c ON p.category_id = c.category_id 
                  WHERE p.product_id IN (${hybridPlaceholders})`,
                  hybridRecommendations,
                  (err4, recommendedProducts) => {
                    if (err4) {
                      console.error(err4);
                      return reject('Failed to fetch recommended product details');
                    }

                    const detailPromises = recommendedProducts.map(product => {
                      const productId = product.product_id;
                      const productType = product.product_type;

                      let query;
                      if (['New', 'جديد','new',].includes(productType)) {
                        query = `SELECT * FROM New_Product WHERE product_id = ?`;
                      } else if (['Used', 'used','مستعمل'].includes(productType)) {
                        query = `SELECT * FROM Used_Product WHERE product_id = ?`;
                      } else if (['Free', 'free','مجاني'].includes(productType)) {
                        query = `SELECT * FROM Free_Product WHERE product_id = ?`;
                      }

                      return new Promise((resolveDetail, rejectDetail) => {
                        if (query) {
                          db.query(query, [productId], (err5, detailResults) => {
                            if (err5) {
                              console.error(err5);
                              return rejectDetail(`Failed to fetch details for product ID ${productId}`);
                            }
                            resolveDetail({ ...product, ...detailResults[0] });
                          });
                        } else {
                          resolveDetail(product);
                        }
                      });
                    });

                    Promise.all(detailPromises)
                      .then(detailedProducts => {
                        resolve(detailedProducts);
                      })
                      .catch(err => {
                        console.error(err);
                        reject('Failed to fetch detailed product information');
                      });
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

//productThisMonth
productThisMonth(req, res) {
  
  return new Promise((resolve, reject) => {
    const oneWeekAgo = new Date();
    oneWeekAgo.setDate(oneWeekAgo.getDate() - 7);
    const formattedDate = oneWeekAgo.toISOString().slice(0, 19).replace('T', ' ');

    db.query(
        'SELECT * FROM Product WHERE created_at >= ?',
        [formattedDate],
        (error, results) => {
            if (error) {
                reject('Failed to retrieve products');
            } else {
                resolve(results);
            }
        }
    );
});
}

gettproducttoadmin(req, res){
  
  return new Promise((resolve, reject) => {
    // Check if the user already exists (Checking the email)
    db.query(
    //  'SELECT * FROM pay JOIN user ON pay.user_id = user.user_id LEFT JOIN product ON pay.idproduct = product.product_id',  // change alsooooo 
    //
    'SELECT pay.*, user.*, product.*, category.name AS category_name FROM pay JOIN user ON pay.user_id = user.user_id LEFT JOIN product ON pay.idproduct = product.product_id LEFT JOIN category ON product.category_id = category.category_id',
      (error, results) => {
        if (error) {
          return reject('Internal server error.');
        }

        return resolve(results);

      
        
     
      },
    );
  });
}

checkQuantityForNotification(userId) {

  console.error('AYYYYYYYYYYYYYYYYYYYYYYYYA');
  return new Promise((resolve, reject) => {
    db.query('SELECT product_id FROM shopping_cart WHERE user_id = ?', [userId], (error, results) => {
      if (error) {
        console.error(error);
        reject('Error retrieving shopping cart items');
      } else if (results.length === 0) {
        reject('No products found in shopping cart');
      } else {
        const productIds = results.map(row => row.product_id);

        if (productIds.length === 0) {
          reject('No products found in shopping cart');
        } else {
          
          const query = 'SELECT * FROM product WHERE product_id IN (?) AND quantity IN (1, 2)';
          db.query(query, [productIds], (error, results) => {
            if (error) {
              console.error(error);
              reject('Error retrieving product details');
            } else {
              const allProductDetails = [];
              results.forEach(product => {
               let Query='';
               if(product['product_type']== 'New' || product['product_type']== 'جديد'){
                 Query='SELECT warranty_period,price FROM new_product WHERE product_id = ?'
               }
               else if(product['product_type']=='Used'|| product['product_type']== 'مستعمل'){
                 Query='SELECT product_condition,price FROM used_product WHERE product_id = ?'
               }
               else if(product['product_type']=='Free'|| product['product_type']== 'مجاني'){
                 Query='SELECT product_condition,state_free FROM free_product WHERE product_id = ?'
               }

                  const productId =product.product_id;
                  let prevId='';
                  db.query(Query, [productId], (error2, res2) => {
                   if (error2) {
                       console.error(error2);
                       reject('Failed to retrieve data from new_product table');
                   } else {
                       // Add the retrieved data to allProductDetails
                       res2.forEach(entry => {
                         const found = allProductDetails.find(item => JSON.stringify(item) === JSON.stringify(entry));
                         if (!found || prevId!=productId) {
                             allProductDetails.push(entry);
                             prevId=productId;
                         }
                     });
                      // allProductDetails.push(...res2);
                      
                       console.log(allProductDetails);
                       console.log('aaaayyya ouuuuut ');
                       // Check if all products have been processed
                     if (allProductDetails.length == results.length) {
                       console.log('aaaayyya');
                         resolve({ results, allProductDetails });// resolve(allProductDetails);
                       }
                       else if(allProductDetails.length==0) {
                         reject('Not have data to retrieve ');
                       }
                     
                   }
               });
              });
             // resolve({results});
            }
          });
        }
      }
    });
  });
}

//ProductNewCollectionForNotification
 ProductNewCollectionForNotification(userId) {
  console.log(userId);
  return new Promise((resolve, reject) => {
    db.query(
      'SELECT product_id FROM user_interaction WHERE user_id = ? ORDER BY created_at DESC LIMIT 5',
      [userId],
      (err, results) => {
        if (err) {
          console.error(err);
          return reject('Failed to fetch interactions');
        }

        const productIds = results.map(row => row.product_id);
        console.log(productIds);

        if (productIds.length == 0) {
          return resolve('No interactions found');
        }

        const placeholders = productIds.map(() => '?').join(',');
        db.query(
          `SELECT p.product_id, p.category_id, c.type AS category_type 
          FROM Product p 
          JOIN Category c ON p.category_id = c.category_id 
          WHERE p.product_id IN (${placeholders})`,
          productIds,
          (err2, productResults) => {
            if (err2) {
              console.error(err2);
              return reject('Failed to fetch product metadata');
            }

            const categoryTypes = productResults.map(p => p.category_type);
            const uniqueCategoryTypes = [...new Set(categoryTypes)]; // Get unique category types
            const typePlaceholders = uniqueCategoryTypes.map(() => '?').join(',');

            db.query(
              `SELECT category_id FROM Category WHERE type IN (${typePlaceholders})`,
              uniqueCategoryTypes,
              (err3, categoryResults) => {
                if (err3) {
                  console.error(err3);
                  return reject('Failed to fetch related categories');
                }

                const categoryIds = categoryResults.map(row => row.category_id);
                const categoryPlaceholders = categoryIds.map(() => '?').join(',');
                db.query(
                  `SELECT * FROM Product WHERE category_id IN (${categoryPlaceholders}) AND created_at >= NOW() - INTERVAL 2 HOUR`,
                  categoryIds,
                  (err4, allProducts) => {
                    if (err4 || allProducts==0) {
                      console.error(err4);
                      return reject('Failed to fetch related products');
                    }

                    console.log(allProducts);
                    const allProductDetails = [];
                   allProducts.forEach(product => {
                    let Query='';
                    if(product['product_type']== 'New' || product['product_type']== 'جديد'){
                      Query='SELECT warranty_period,price FROM new_product WHERE product_id = ?'
                    }
                    else if(product['product_type']=='Used'|| product['product_type']== 'مستعمل'){
                      Query='SELECT product_condition,price FROM used_product WHERE product_id = ?'
                    }
                    else if(product['product_type']=='Free'|| product['product_type']== 'مجاني'){
                      Query='SELECT product_condition,state_free FROM free_product WHERE product_id = ?'
                    }

                       const productId =product.product_id;
                       let prevId='';
                       db.query(Query, [productId], (error2, res2) => {
                        if (error2) {
                            console.error(error2);
                            reject('Failed to retrieve data from new_product table');
                        } else {
                            // Add the retrieved data to allProductDetails
                            res2.forEach(entry => {
                              const found = allProductDetails.find(item => JSON.stringify(item) === JSON.stringify(entry));
                              if (!found || prevId!=productId) {
                                  allProductDetails.push(entry);
                                  prevId=productId;
                              }
                          });
                           // allProductDetails.push(...res2);
                           
                            console.log(allProductDetails);
                            console.log('aaaayyya ouuuuut ');
                            // Check if all products have been processed
                          if (allProductDetails.length == allProducts.length) {
                            console.log('aaaayyya');
                              resolve({ allProducts, allProductDetails });// resolve(allProductDetails);
                            }
                            else if(allProductDetails.length==0) {
                              reject('Not have data to retrieve ');
                            }
                          
                        }
                    });
                   });
                   
                   // resolve({allProducts});
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

/// aya 
///addToWishList 
addToWishList(req, res) {
  const { userId, productId } = req.body;

  return new Promise((resolve, reject) => {


    console.log(userId);
    console.log(productId);
    
    db.query(
      'SELECT * from wishlist  WHERE user_id = ? AND product_id = ?',
      [userId, productId],
      (error3, results3) => {
        if (error3) {
          console.error(error3);
          return reject('Failed to insert to wishlist');
        }
        else {
          if(results3.length ==0){
            
    db.query(
      'INSERT INTO wishlist (user_id, product_id) VALUES (?, ?)',
      [userId, productId],
      (error3, results3) => {
        if (error3) {
          console.error(error3);
          return reject('Failed to insert to wishlist');
        }
        else {
          
    return resolve('insert to wishlis successfully');
        }
      }
    );
          }
          else {
            return reject('product exsist in wishlist, can not add again');

          }
          
    
        }
      }
    );


  });
}


// retriveFromWishList
retriveFromWishList(userId) {
  return new Promise((resolve, reject) => {
    const ProductDataWishList = [];
    db.query(
      'SELECT * FROM wishlist WHERE user_id = ?', [userId],
      (error, results) => {
        if (error) {
          return reject('Internal server error.');
        } else {
          console.log('product in wishlist results:', results);
          results.forEach(product => {
            const productId = product.product_id;
            db.query(
              'SELECT p.*, c.name as category_name, c.type as category_type FROM product p JOIN category c ON p.category_id = c.category_id WHERE p.product_id = ?',
              [productId],
              (error3, productData) => {
                if (error3) {
                  console.error(error3);
                  return reject('Failed to retrieve product data');
                } else {
                  const ProductDetails = [];
                  productData.forEach(entry => {
                    const found = ProductDataWishList.find(item => JSON.stringify(item) == JSON.stringify(entry));
                    if (!found) {
                      ProductDataWishList.push(entry);
                    }
                  });
                  console.log('ProductDataWishList:', ProductDataWishList);
                  console.log(results.length);
                  console.log(ProductDataWishList.length);
                  if (ProductDataWishList.length === results.length) {
                    console.log('aaaayyya');
                    ProductDataWishList.forEach(product => {
                      let Query = '';
                      if (product['product_type'] === 'New' || product['product_type'] === 'جديد') {
                        Query = 'SELECT * FROM new_product WHERE product_id = ?';
                      } else if (product['product_type'] === 'Used' || product['product_type'] === 'مستعمل') {
                        Query = 'SELECT * FROM used_product WHERE product_id = ?';
                      } else if (product['product_type'] === 'Free' || product['product_type'] === 'مجاني') {
                        Query = 'SELECT * FROM free_product WHERE product_id = ?';
                      }

                      const prodId = product.product_id;
                      let prevId = '';
                      db.query(Query, [prodId], (error2, res2) => {
                        if (error2) {
                          console.error(error2);
                          reject('Failed to retrieve data from specific product table');
                        } else {
                          res2.forEach(entry => {
                            const found = ProductDetails.find(item => JSON.stringify(item) === JSON.stringify(entry));
                            if (!found || prevId !== prodId) {
                              ProductDetails.push(entry);
                              prevId = prodId;
                            }
                          });

                          if (ProductDataWishList.length == ProductDetails.length) {
                            console.log('aaaayyya');
                            console.log(ProductDataWishList,ProductDetails);
                            resolve({ ProductDataWishList, ProductDetails });
                          } else if (ProductDetails.length == 0) {
                            reject('No data to retrieve');
                          }
                        }
                      });
                    });
                  }
                }
              }
            );
          });
        }
      }
    );
  });
}


//deleteFromWishList

deleteFromWishList(productId,userId) {
  console.log(productId);
  console.log(userId);
  return new Promise((resolve, reject) => {
    db.query('DELETE FROM wishlist WHERE product_id = ? AND user_id = ?',[productId,userId], (error2, res2) => {
      if (error2) {
          console.error(error2);
          reject('Failed to delete data from  wishlist');
      } else {
      
           resolve("success deleted");
     
      }});

  });
  
};

findSimilar(productId,productType) {
  console.log(productType);
  console.log(productId);
  return new Promise((resolve, reject) => {
    const productSimilar = [];
    const ProductDetails = [];
    db.query(
        'SELECT * FROM category WHERE type = ?',
        [productType],
        (error, results) => {
            if (error) {
                reject('Failed to retrieve products');
            } else {
              let i=0;
              
    db.query(
        'SELECT * FROM category WHERE type = ?',
        [productType],
        (error, results) => {
            if (error) {
                reject('Failed to retrieve products');
            } else {
              console.log('product  results:', results);
              results.forEach(product => {
                const categoryId = product.category_id;
             
                db.query(
                  'SELECT p.*, c.name as category_name, c.type as category_type FROM product p JOIN category c ON p.category_id = c.category_id WHERE p.category_id = ?',
                  [categoryId],
                  (error3, productData) => {
                    if (error3) {
                     
                      return reject('Failed to retrieve product data');
                    } else {
                     
                      console.log('product  id:', productData['product_id'] );
       
                      productData.forEach(entry => {
                        if(entry.product_id!= productId){
                        const found = productSimilar.find(item => JSON.stringify(item) == JSON.stringify(entry));
                        if (!found) {
                          productSimilar.push(entry);
                        }}
                      });
                    
                     
                      if (productSimilar.length <= results.length && results.length== i) {
                     
                        let index=0;
                        productSimilar.forEach(product => {
              
                        
                          let Query = '';
                          if (product['product_type'] == 'New' || product['product_type'] == 'جديد') {
                            Query = 'SELECT *FROM new_product WHERE product_id = ?';
                          } else if (product['product_type'] == 'Used' || product['product_type'] == 'مستعمل') {
                            Query = 'SELECT * FROM used_product WHERE product_id = ?';
                          } else if (product['product_type'] == 'Free' || product['product_type'] == 'مجاني') {
                            Query = 'SELECT * FROM free_product WHERE product_id = ?';
                          }
                      
                          const prodId = product.product_id;
                          if(productId!=prodId){

                          
                          let prevId = '';
                          db.query(Query, [prodId], (error2, res2) => {
                            if (error2) {
                              console.error(error2);
                              reject('Failed to retrieve data from specific product table');
                            } else {
                            
                              res2.forEach(entry => {
                                const found = ProductDetails.find(item => JSON.stringify(item) == JSON.stringify(entry));
                                if (!found ) {
                                  ProductDetails.push(entry);
                                 // prevId = prodId;
                                }
                              });
   
                              if (productSimilar.length == ProductDetails.length  ) {
                           
                                resolve({ productSimilar, ProductDetails });
                              } else if (ProductDetails.length == 0) {
                                reject('No data to retrieve');
                              }
                            }
                          });
                        }
                      index++;
                        });
                      }
                    }
                  }
                );
                i++;
              });
              

                //resolve(results);
            }
        }
    );

                //resolve(results);
            }
        }
    );
});
}

/// aya 


// statitis code ****** ibtisam newwwww

totalnumberproductforstatistics(req, res){
  db.query('SELECT COUNT(*) AS totalProducts FROM Product', (error, results) => {
    if (error) {
      console.error(error);
      if (!res.headersSent) {
        res.status(500).json({ message: 'Internal server error' });
      }
    } else {
      if (!res.headersSent) {
        res.status(200).json(results[0]); // Sending only the first result
      }
    }
  });

  /*
  return new Promise((resolve, reject) => {
    // Check if the user already exists (Checking the email)
    db.query(
      'SELECT COUNT(*) AS totalProducts FROM Product',  // change alsooooo 
   
      (error, results) => {
        if (error) {
          return reject('Internal server error.');
        }

        return resolve(results);

      
        
     
      },
    );
  });*/
}
totalnumbersoldproduct(req, res){
  db.query('SELECT COUNT(*) AS totalProductsSold FROM pay', (error, results) => {
    if (error) {
      console.error(error);
      if (!res.headersSent) {
        res.status(500).json({ message: 'Internal server error' });
      }
    } else {
      if (!res.headersSent) {
        res.status(200).json(results[0]); // Sending only the first result
      }
    }
  });}




  //
  /*
  totalRevenue(req, res){
    db.query('SELECT SUM(amount) AS totalrevenue FROM pay', (error, results) => {
      if (error) {
        console.error(error);
        if (!res.headersSent) {
          res.status(500).json({ message: 'Internal server error' });
        }
      } else {
        if (!res.headersSent) {
          res.status(200).json(results[0]); // Sending only the first result
        }
      }
    });}*/
    totalRevenue(req, res) {
      // First, get the total revenue
      db.query('SELECT SUM(amount) AS totalrevenue FROM pay', (error, totalResults) => {
        if (error) {
          console.error(error);
          if (!res.headersSent) {
            res.status(500).json({ message: 'Internal server error' });
          }
        } else {
          const totalRevenue = totalResults[0].totalrevenue;
    
          // Then, get the revenue for each product
          db.query('SELECT idproduct, SUM(amount) AS productrevenue FROM pay GROUP BY idproduct', (error, productResults) => {
            if (error) {
              console.error(error);
              if (!res.headersSent) {
                res.status(500).json({ message: 'Internal server error' });
              }
            } else {
              // Calculate the admin profit for each product (10% of revenue)
              const resultsWithAdminProfit = productResults.map(product => {
                const adminProfit = 0.1 * product.productrevenue; // 10% of revenue
                const profitPercentage = (adminProfit / totalRevenue) * 100;
                return {
                  idproduct: product.idproduct,
                  productrevenue: product.productrevenue,
                  adminProfit: adminProfit,
                  profitPercentage: profitPercentage.toFixed(2) // Convert to percentage and format to 2 decimal places
                };
              });
    
              // Combine total revenue and product results with admin profit
              const combinedData = {
                totalRevenue: totalResults[0].totalrevenue,
                productsWithAdminProfit: resultsWithAdminProfit
              };
    
              if (!res.headersSent) {
                res.status(200).json(combinedData); // Send combined data
              }
            }
          });
        }
      });
    }
// ayosh
//totalnumberproductofSeller
totalnumberproductofSeller(userId,res){
  db.query('SELECT COUNT(*) AS totalProducts FROM Product WHERE user_id = ? ',[userId], (error, results) => {
    if (error) {
      console.error(error);
      if (!res.headersSent) {
        res.status(500).json({ message: 'Internal server error' });
      }
    } else {
      if (!res.headersSent) {
        res.status(200).json(results[0]); 
      }
    }
  });
}

totalproductsoldofSeller(userId, res) {
 
  db.query('SELECT product_id FROM Product WHERE user_id = ?', [userId], (error, results) => {
    if (error) {
      console.error(error);
      if (!res.headersSent) {
        res.status(500).json({ message: 'Internal server error' });
      }
    } else {
      if (results.length == 0) {
        res.status(404).json({ message: 'Seller has no products' });
      } else {
   
        const productIds = results.map(row => row.product_id);

        if (productIds.length === 0) {
          res.status(404).json({ message: 'No products found for this seller' });
          return;
        }

       
        db.query('SELECT COUNT(*) AS totalProductsSold FROM pay WHERE idproduct IN (?)', [productIds], (error, results) => {
          if (error) {
            console.error(error);
            if (!res.headersSent) {
              res.status(500).json({ message: 'Internal server error' });
            }
          } else {
            if (!res.headersSent) {
              res.status(200).json(results[0]); 
            }
          }
        });
      }
    }
  });
}

//totalrevenueofseller
totalrevenueofseller(userId, res) {
  db.query('SELECT product_id FROM Product WHERE user_id = ?', [userId], (error, results) => {
    if (error) {
      console.error(error);
      if (!res.headersSent) {
        res.status(500).json({ message: 'Internal server error' });
      }
    } else {
      if (results.length == 0) {
        res.status(404).json({ message: 'Seller has no products' });
      } else {
        const productIds = results.map(row => row.product_id);

        if (productIds.length === 0) {
          res.status(404).json({ message: 'No products found for this seller' });
          return;
        }

        db.query('SELECT SUM(amount) AS totalRevenue FROM pay WHERE idproduct IN (?)', [productIds], (error, totalResults) => {
          if (error) {
            console.error(error);
            if (!res.headersSent) {
              res.status(500).json({ message: 'Internal server error' });
            }
          } else {
            const totalRevenue = totalResults[0].totalRevenue || 0;
            const sellerRevenue = totalRevenue * 0.9;

       
            db.query('SELECT idproduct, SUM(amount) AS productRevenue FROM pay WHERE idproduct IN (?) GROUP BY idproduct', [productIds], (error, productResults) => {
              if (error) {
                console.error(error);
                if (!res.headersSent) {
                  res.status(500).json({ message: 'Internal server error' });
                }
              } else {
              
                const resultsWithSellerProfit = productResults.map(product => {
                  const sellerProfit = 0.9 * product.productRevenue;
                  const profitPercentage = (sellerProfit / totalRevenue) * 100;
                  return {
                    idproduct: product.idproduct,
                    productRevenue: product.productRevenue,
                    sellerProfit: sellerProfit,
                    profitPercentage: profitPercentage.toFixed(2) 
                  };
                });

                const combinedData = {
                  totalRevenue: totalResults[0].totalRevenue,
                  sellerRevenue: sellerRevenue,
                  resultsWithSellerProfit: resultsWithSellerProfit
                };

                if (!res.headersSent) {
                  res.status(200).json(combinedData); 
                }
              }
            });
          }
        });
      }
    }
  });
}



// ayosh 



//endddd ibtisamm


 /*
 my code 
 
 retriveProductHomeRecomendedSystem(userId) {
  console.log(userId);
  return new Promise((resolve, reject) => {
    db.query(
      'SELECT product_id FROM user_interaction WHERE user_id = ? ORDER BY created_at DESC LIMIT 5',
      [userId],
      (err, interactionResults) => {
        if (err) {
          console.error(err);
          return reject('Failed to fetch interactions');
        }

        const productIds = interactionResults.map(row => row.product_id);

        if (productIds.length === 0) {
          return resolve('No interactions found');
        }

        const placeholders = productIds.map(() => '?').join(',');

        db.query(
          `SELECT p.product_id, p.name, p.description, p.category_id, c.name AS category_name, c.type AS category_type 
          FROM Product p 
          JOIN Category c ON p.category_id = c.category_id 
          WHERE p.product_id IN (${placeholders})`,
          productIds,
          (err2, productResults) => {
            if (err2) {
              console.error(err2);
              return reject('Failed to fetch product metadata');
            }

            db.query(
              `SELECT p.product_id, p.name, p.description, p.category_id, c.name AS category_name, c.type AS category_type 
              FROM Product p 
              JOIN Category c ON p.category_id = c.category_id`,
              (err3, allProducts) => {
                if (err3) {
                  console.error(err3);
                  return reject('Failed to fetch all products');
                }

                const productFeatures = allProducts.map(product => ({
                  id: product.product_id,
                  name: product.name,
                  category: product.category_type,
                  description: product.description
                }));

                const userInteractedProductIds = productResults.map(p => p.product_id);
                const userInteractions = allProducts.map(product => (
                  userInteractedProductIds.includes(product.product_id) ? 1 : 0
                ));

                const ratings = [
                  userInteractions,
                  ...new Array(4).fill(new Array(allProducts.length).fill(0))
                ];
                console.log(allProducts);
   
                const userInteractedTypes = new Set(productResults.map(p => p.category_type));

                const similarTypeProducts = allProducts.filter(product =>
                  userInteractedTypes.has(product.category_type)
                );

                const similarTypeProductIds = similarTypeProducts.map(p => p.product_id);

                const collabRecommendations = recommendations.cFilter(ratings,0 );
                console.log('collabRecommendations :' + collabRecommendations);

            
                const contentRecommendations = recommendations.contentBasedFiltering(productFeatures, productResults);
                console.log('contentRecommendations :' + contentRecommendations);

        
                const filteredContentRecommendations = contentRecommendations.filter(rec =>
                  similarTypeProductIds.includes(rec)
                );

                console.log('filteredContentRecommendations :' + filteredContentRecommendations);

                const hybridRecommendations = recommendations.combineRecommendations(collabRecommendations, filteredContentRecommendations);
                console.log('hybridRecommendations :' + hybridRecommendations);

               
              //  resolve(hybridRecommendations);
              if (hybridRecommendations.length === 0) {
                return resolve('No recommendations found');
              }

              const hybridPlaceholders = hybridRecommendations.map(() => '?').join(',');

              db.query(
                `SELECT p.*, c.name AS category_name, c.type AS category_type 
                FROM Product p 
                JOIN Category c ON p.category_id = c.category_id 
                WHERE p.product_id IN (${hybridPlaceholders})`,
                hybridRecommendations,
                (err4, recommendedProducts) => {
                  if (err4) {
                    console.error(err4);
                    return reject('Failed to fetch recommended product details');
                  }
                  resolve(recommendedProducts);
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

}
   


module.exports = ProductRepository;