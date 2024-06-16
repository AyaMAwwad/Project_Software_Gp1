const prodRep = require('../data/database/ProdRepo');
const prod = new prodRep();





exports.getproduct = (req, res) => {
  prod.getproduct(req, res);
  };


  
  exports.getProductImages = (req, res) => {
    const { productId } = req.query;
    console.log({productId});

    prod.getProductImages(productId)
        .then((images) => {
            console.log({images});

            res.status(200).json(images);
        })
        .catch((error) => {
            console.error({error});
            res.status(500).json({ message: 'Internal server error' });
        });
};


exports.getnewprice = (req, res) => {
    const { id } = req.query;
    console.log({id});

    prod.getnewprice(id)
        .then((price) => {
            console.log({price});
            console.log('Price:', price);
            res.status(200).json(price);
        })
        .catch((error) => {
            console.error({error});
            res.status(500).json({ message: 'Internal server error' });
        });
};
// ibtisam 

exports.getusedprice = (req, res) => {
  const { id } = req.query;
  console.log({id});

  prod.getusedprice(id)
      .then((price) => {
          console.log({price});
          console.log('Price:', price);
          res.status(200).json(price);
      })
      .catch((error) => {
          console.error({error});
          res.status(500).json({ message: 'Internal server error' });
      });
};



// ibtisam


  exports.addProduct = (req, res) => {
    prod
      .addProduct(req, res)
      .then((message) => {
        res.status(201).json({ message }); 
      })
      .catch((error) => {
        res.status(400).json({ message: error }); 
      });
    }

    // new gettypeofproduct
    exports.gettypeofproduct = (req, res) => {
      const { category,type,state } = req.query;//req.query;
      
  //substring(1)
      prod.gettypeofproduct(category,type,state)
          .then((res1) => {
              console.log({res1});
             // console.log('Price:', price);
              res.status(200).json(res1);
          })
          .catch((error) => {
              console.error({error});
              res.status(500).json({ message: 'Not have data in database to retrieve' });
          });
  };
  //// neeeeeew addToShopCart
  exports.addToShopCart = (req, res) => {
    prod
      .addToShopCart(req, res)
      .then((message) => {
        res.status(201).json({ message }); 
      })
      .catch((error) => {
        res.status(400).json({ message: error }); 
      });
    }

    //getToShopCart
    exports.getToShopCart = (req, res) => {
      //prod.getToShopCart()
      const userId=req.query.userId;
      prod.getToShopCart(userId)
      .then((res1) => {
        console.log({res1});
       // console.log('Price:', price);
        res.status(200).json(res1);
    })
    .catch((error) => {
        console.error({error});
        res.status(500).json({ message: 'Not have data in database to retrieve' });
    });
      };
    ///deleteFromShopCart
    exports.deleteFromShopCart = (req, res) => {
      const productId = req.query.product_id; // Extracting product_id from query parameters
      if (!productId) {
          return res.status(400).json({ message: 'Product ID is required' });
      }
  
      // Call the function to delete the item from the shopping cart based on the product_id
      // Replace `deleteFromShopCart` with your actual function to delete the item from the database
      prod.deleteFromShopCart(productId)
          .then((result) => {
              console.log('Item deleted successfully');
              res.status(200).json({ message: 'Item deleted successfully' });
          })
          .catch((error) => {
              console.error('Error deleting item:', error);
              res.status(500).json({ message: 'Internal server error' });
          });
  };

  ///////retriveWordOfsearch
  exports.retriveWordOfsearch = (req, res) => {
    const { name } = req.query;//req.query;
    

    prod.retriveWordOfsearch(name)
        .then((res1) => {
            console.log({res1});
          
            res.status(200).json(res1);
        })
        .catch((error) => {
            console.error({error});
            res.status(500).json({ message: 'Not have thing to retrieve' });
        });
};

//retriveProductOfsearch 1-MAY
exports.retriveProductOfsearch = (req, res) => {
  const { name } = req.query;//req.query;
  

  prod.retriveProductOfsearch(name)
      .then((res1) => {
          console.log({res1});
        
          res.status(200).json(res1);
      })
      .catch((error) => {
          console.error({error});
          res.status(500).json({ message: 'Not have thing to retrieve' });
      });
};

//updateItemOnShopCart 2_MAY

exports.updateItemOnShopCart = (req, res) => {
  prod
    .updateItemOnShopCart(req, res)
    .then((message) => {
      console.log(message);
      res.status(201).json({ message }); 
    })
    .catch((error) => {
      res.status(400).json({ message: error }); 
    });
  };
  

  // aya

  exports.sallerProduct = (req, res) => {
    console.log('*** in controller userId');
    const { userId } = req.query;


    prod.sallerProduct(userId)
        .then((res1) => {
            //console.log({res1});

            res.status(200).json(res1);
        })
        .catch((error) => {
            console.error({error});
            res.status(500).json({ message: 'Not have thing to retrieve' });
        });
  };
// ayaaaaa

/// 18/5 deleteItemSellar
exports.deleteItemSellar = (req, res) => {
  const productId = req.query.productid; 
  const state = req.query.state;
  if (!productId) {
      return res.status(400).json({ message: 'Product ID is required' });
  }
  prod.deleteItemSellar(productId,state)
      .then((result) => {
          console.log('Item deleted successfully');
          res.status(200).json({ message: 'Item deleted successfully' });
      })
      .catch((error) => {
          console.error('Error deleting item:', error);
          res.status(500).json({ message: 'Internal server error' });
      });
};

//updateSellarProduct
exports.updateSellarProduct = (req, res) => {
prod
  .updateSellarProduct(req, res)
  .then((message) => {
    console.log(message);
    res.status(201).json({ message }); 
  })
  .catch((error) => {
    res.status(400).json({ message: error }); 
  });
};




// ayaaa
  // admin new shopping 

  
exports.gettproducttoadmin = (req, res) => {
  prod
    .gettproducttoadmin(req, res)
    .then((message) => {
      res.status(201).json({ message }); // Registration was successful, return the success message
    })
    .catch((error) => {
      res.status(400).json({ message: error }); // Registration encountered an error, return the error message
    });
};


// ayaaaaa newwww



  //addRatingProduct
  exports.addRatingProduct = (req, res) => {
    prod
      .addRatingProduct(req, res)
      .then((message) => {
        res.status(201).json({ message }); 
      })
      .catch((error) => {
        res.status(400).json({ message: error }); 
      });
    }
    //retriveProductHomeRecomendedSystem
    exports.retriveProductHomeRecomendedSystem = (req, res) => {
      const { userId } = req.query;


      prod.retriveProductHomeRecomendedSystem(userId)
          .then((res1) => {
              console.log({res1});

              res.status(200).json(res1);
          })
          .catch((error) => {
              console.error({error});
              res.status(500).json({ message: 'Not have thing to retrieve' });
          });
    };

    exports.productThisMonth = (req, res) => {
      //const { userId } = req.query;
      
    
      prod.productThisMonth(req, res)
          .then((res1) => {
              console.log({res1});
            
              res.status(200).json(res1);
          })
          .catch((error) => {
              console.error({error});
              res.status(500).json({ message: 'Not have thing to retrieve' });
          });
    };
// aya 

    //checkQuantityForNotification
    exports.checkQuantityForNotification = (req, res) => {
      const { userId } = req.query;


      prod.checkQuantityForNotification(userId)
          .then((result) => {
              console.log({result});

              res.status(200).json(result);
          })
          .catch((error) => {
              console.error({error});
              res.status(500).json({ message: 'Internal server error' });
          });
      };
//ProductNewCollectionForNotification
exports.ProductNewCollectionForNotification = (req, res) => {
  const { userId } = req.query;

  prod.ProductNewCollectionForNotification(userId)
      .then((result) => {
          console.log({result});

          res.status(200).json(result);
      })
      .catch((error) => {
          console.error({error});
          res.status(500).json({ message: 'Internal server error' });
      });
  };




    // ibtisam******************** admin satistic
    exports.totalnumberproductforstatistics= (req, res) => {
      //const { userId } = req.query;
      
    
      prod.totalnumberproductforstatistics(req, res);
       /*   .then((res1) => {
              console.log({res1});
            
              res.status(200).json(res1);
          })
          .catch((error) => {
              console.error({error});
              res.status(500).json({ message: 'total number not retrive of product ' });
          });*/
    };


    exports.totalnumbersoldproduct = (req, res) => {
      //const { userId } = req.query;
      
    
      prod.totalnumbersoldproduct(req, res);};



      exports.totalRevenue  = (req, res) => {
        //const { userId } = req.query;
        
      
        prod.totalRevenue(req, res);};



        /// aya 
  //addToWishList
  exports.addToWishList = (req, res) => {
    prod
      .addToWishList(req, res)
      .then((message) => {
        res.status(201).json({ message }); 
      })
      .catch((error) => {
        res.status(400).json({ message: error }); 
      });
    }

    //retriveFromWishList
    exports.retriveFromWishList = (req, res) => {
      const { userId } = req.query;

      prod.retriveFromWishList(userId)
          .then((result) => {
              console.log({result});

              res.status(200).json(result);
          })
          .catch((error) => {
              console.error({error});
              res.status(500).json({ message: 'Internal server error' });
          });
      };

      exports.deleteFromWishList = (req, res) => {
        const productId = req.query.productId; 
        const userId = req.query.userId;

        prod.deleteFromWishList(productId,userId)
            .then((result) => {
                console.log('Item deleted successfully');
                res.status(200).json({ message: 'Item deleted successfully' });
            })
            .catch((error) => {
                console.error('Error deleting item:', error);
                res.status(500).json({ message: 'Internal server error' });
            });
    };

    exports.findSimilar = (req, res) => {
      const { productId , productType } = req.query;

      prod.findSimilar(productId,productType)
          .then((result) => {
              console.log({result});

              res.status(200).json(result);
          })
          .catch((error) => {
              console.error({error});
              res.status(500).json({ message: 'Internal server error' });
          });
      };

      /// aya 

 /////// ayosh

 exports.totalnumberproductofSeller= (req, res) => {
  const { userId } = req.query;
  prod.totalnumberproductofSeller(userId,res);
};
//totalproductsoldofSeller

exports.totalproductsoldofSeller = (req, res) => {
  const { userId } = req.query;
  prod.totalproductsoldofSeller(userId, res);};

  //totalrevenueofseller
  exports.totalrevenueofseller  = (req, res) => {
    const { userId } = req.query;


    prod.totalrevenueofseller(userId, res);};
// ayosh




  