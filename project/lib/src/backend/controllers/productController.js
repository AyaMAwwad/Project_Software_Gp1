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
      prod.getToShopCart()
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
  