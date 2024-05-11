const mysql = require('mysql2');


const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '12345678',
  database: 'shoppingdatabse',
});

class PaymentRepository {

    addPayment(req, res) {
  
        //numberofimage
          const { userId,amount,payMethod } = req.body;
          return new Promise((resolve, reject) => {

            let allProductInShopCartOfUser = [];
 
      db.query("SELECT * from shopping_cart WHERE user_id = ?", [userId],  (error, results) => {
        if (error) {
          console.error(error);
          reject('Failed  ');
        } else {
            if( results.length==0){
                reject('User not have product in shopping cart  ');
            }
            else{
                const theDate = new Date();
                allProductInShopCartOfUser=results;
                console.log(allProductInShopCartOfUser);
                allProductInShopCartOfUser.forEach(cartProduct => {
                    const cartId =cartProduct.cart_id;
                    db.query(
                        'INSERT INTO pay (user_id, payment_date, amount,payment_method) VALUES (?, ?, ?, ?)',
                        [userId, theDate, amount, payMethod],
                        (error2, results2) => {
                            if (error2) {
                                return reject('Failed payment');
                            }
                            return resolve('payment successfully');
                        }
                    );
                });
            }

        }
    });
          });
        };
//deleteFromCartProductThatPaied
deleteFromCartProductThatPaied(productIds) {
  let i=0;
    return new Promise((resolve, reject) => {
     console.log(productIds);
        
      productIds.forEach(productId => {
     
        if(productId != 0){
          db.query(
            'DELETE FROM shopping_cart WHERE product_id = ?',[productId],
            (error, results) => {
                if (error) {
                    reject('not found this product ');
                } else {
                  if(i==productIds.length){
                    resolve('updated successfully');
                  }
  
              
                }
            }
        );

        }
        i++;
      });
     


    });
 // return new Promise((resolve, reject) => {

    /*
    db.query('DELETE FROM shopping_cart WHERE product_id = ?',[productId], (error, results) => {
      if (error) {
        console.error(error);
        reject('Failed to Delete ');
      } else {
        resolve("success deleted");
      }
    });*/

  
};

updateTheQuantityToPayment(req, res) {
    const { productIds } = req.body;
    console.log(productIds);/// 1) that undifined reach show why  ---> done 
    //2) when user payment that make that forign key between payment and 
    //shop cart table then delete the prdouct from shop cart have error can 
    //not delete becuse forign ---> done 
    //3) after pay should remove the product from shop cart ---> done
    //4) if the quantity is zero the user can not add the product to shop cart and i need to
    // appear icon sold out  ----> done 

    let i=0;
    return new Promise((resolve, reject) => {
     
        
      productIds.forEach(productId => {
     
        if(productId != 0){
          db.query(
            'SELECT quantity from product WHERE product_id = ?',
            [productId],
            (error, results) => {
                if (error) {
                    reject('not found this product ');
                } else {
                   const Res=results[0].quantity;
                   if(Res>0){
                      let quantityUpdate=Res-1;
                      db.query(
                         
                          'UPDATE product SET quantity = ? WHERE product_id = ?',
                          [quantityUpdate,productId],
                          (error, results) => {
                              if (error) {
                                  reject('Failed to update quantity of this product  ');
                              } else {
                                console.log(` the length: ${productIds.length}`);
                                console.log(` the i: ${i}`);
                                if(i==productIds.length){
                                  resolve('updated successfully');
                                }
                              }
                          }
                      );
                   }
                   else if(Res==0){
                      reject('This product was Sold out ');
                   }
  
  
              
                }
            }
        );

        }
        i++;
      });
      /*  db.query(
          'SELECT quantity from product WHERE product_id = ?',
          [productIds],
          (error, results) => {
              if (error) {
                  reject('not found this product ');
              } else {
                 const Res=results[0].quantity;
                 if(Res>0){
                    let quantityUpdate=Res-1;
                    db.query(
                       
                        'UPDATE product SET quantity = ? WHERE product_id = ?',
                        [quantityUpdate,productId],
                        (error, results) => {
                            if (error) {
                                reject('Failed to update quantity of this product  ');
                            } else {
                                resolve('updated successfully');
                            }
                        }
                    );
                 }
                 else if(Res==0){
                    reject('This product was Sold out ');
                 }


            
              }
          }
      );
*/


    });
}
        //checkTheQuantityToPayment
        checkTheQuantityToPayment(userId) {

            return new Promise((resolve, reject) => {
              console.log(userId);
              
    db.query('SELECT product_id FROM shopping_cart WHERE user_id = ?',[userId], (error, results) => {
        if (error || results.length==0) {
          console.error(error);
          reject('Failed to retrive from cart ');
        } else {
            const theRes= results;
            const allProductData = [];
            theRes.forEach(cartRow => {
                const prodId = cartRow.product_id; 
                console.log(prodId);
                db.query('SELECT * FROM product WHERE product_id = ?', [prodId], (error1, res1) => {
                  if (error1) {
                    console.error(error1);
                    reject('Failed to retrieve product data');
                  } else {
                    console.log(res1);
                    if(cartRow.quantity==0){
                        console.log('aya');
                    allProductData.push(...res1);
                    console.log(allProductData);
                    }
                  
                    
                   if (allProductData.length == theRes.length) {
                   
                    resolve({theRes, allProductData });
                   
      
                  }
                  else if(res1.length==0) {
                    reject('Not have this product ');
                  }
                  
                  }
                });
              });
            /////
        }
    });
            });
        }
}


module.exports = PaymentRepository;