


const mysql = require('mysql2');

const path = require('path');
const fs = require('fs');
const { Console } = require('console');
const { use } = require('../../routes/userRoute');

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


addProduct(req, res) {
  
//numberofimage
  const { email,name, category, state, description, price, quantity,image, numberofimage,detailsOfState,typeOfCategory,productFreeCond,imagedata,currency,delivery } = req.body;

  console.log(email,name, category, state, description, price, quantity,image,numberofimage,detailsOfState,typeOfCategory,productFreeCond,imagedata,currency);
  
 let prodID=0;
  return new Promise((resolve, reject) => {
   
    
   

    db.query(
      'SELECT user_id FROM user WHERE email = ? ',
      [email],
      (error, results) => {
        if (error) {
          return reject('you are not user');
        }
        console.log('aaaaa');
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
                return resolve('inserted new product successfully.');
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
                return resolve('inserted Used product successfully.');
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
  
                return resolve('inserted Free product successfully.');
              }


            );
            
          }
   

              }

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
          db.query('SELECT product_id,name,description,quantity,user_id,image,Delivery_option,currency FROM product WHERE category_id = ? AND product_type = ?', [categoryId,state], (error1, res1) => {
            if (error1) {
              console.error(error1);
              reject('Failed to retrieve product data');
            } else {
              // Add the product data for the current category ID to the array
              allProductData.push(...res1);
              console.log(allProductData);
           
             
             if (allProductData.length <= theRes.length) {
             let Query='';
              if(state== 'New' || state== 'جديد'){
                Query='SELECT warranty_period,price FROM new_product WHERE product_id = ?'
              }
              else if(state=='Used'|| state== 'مستعمل'){
                Query='SELECT product_condition,price FROM used_product WHERE product_id = ?'
              }
              else if(state=='Free'|| state== 'مجاني'){
                Query='SELECT product_condition,state_free FROM free_product WHERE product_id = ?'
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
                        if (!found || prevId!=productId) {
                            allProductDetails.push(entry);
                            prevId=productId;
                        }
                    });
                     // allProductDetails.push(...res2);
                     
                      console.log(allProductDetails);
                      console.log('aaaayyya ouuuuut ');
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
                   Query='SELECT warranty_period,price FROM new_product WHERE product_id = ?'
                 }
                 else if(state=='Used'|| state== 'used'|| state== 'مستعمل'){
                   Query='SELECT product_condition,price FROM used_product WHERE product_id = ?'
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
  return new Promise((resolve, reject) => {
//p.image AS image,
    const query = `
    SELECT p.name AS product_name, p.description AS product_description, c.name AS category_name, c.type AS category_type
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

deleteItemSellar(productId,state) {
  return new Promise((resolve, reject) => {

    
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
  });
  
};

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
}
   


module.exports = ProductRepository;