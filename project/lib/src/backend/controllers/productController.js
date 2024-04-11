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
  