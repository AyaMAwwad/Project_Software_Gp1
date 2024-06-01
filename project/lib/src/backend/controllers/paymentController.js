const PaymentRepository = require('../data/database/paymentRepo');

const paymentRepository = new PaymentRepository();
exports.addPayment = (req, res) => {
    paymentRepository
      .addPayment(req, res)
      .then((message) => {
        res.status(201).json({ message }); 
      })
      .catch((error) => {
        res.status(400).json({ message: error }); 
      });
    }

    //updateTheQuantityToPayment
    exports.updateTheQuantityToPayment = (req, res) => {
      paymentRepository
        .updateTheQuantityToPayment(req, res)
        .then((message) => {
          console.log(message);
          res.status(201).json({ message }); 
        })
        .catch((error) => {
          res.status(400).json({ message: error }); 
        });
      };
      
//deleteFromCartProductThatPaied
exports.deleteFromCartProductThatPaied = (req, res) => {
  let  productIds  = req.query.productIds; 
  productIds = JSON.parse(productIds);
  /*if (!productIds) {
      return res.status(400).json({ message: 'Product ID is required' });
  }*/

  paymentRepository.deleteFromCartProductThatPaied(productIds)
      .then((result) => {
          console.log(' deleted successfully');
          res.status(200).json({ message: ' deleted successfully' });
      })
      .catch((error) => {
          console.error('Error deleting :', error);
          res.status(500).json({ message: 'Internal server error' });
      });
};
//checkTheQuantityToPayment
exports.checkTheQuantityToPayment = (req, res) => {
      
  const userId=req.query.userId;
  paymentRepository.checkTheQuantityToPayment(userId)
    .then((res1) => {
      console.log({res1});
      res.status(200).json(res1);
  })
  .catch((error) => {
      console.error({error});
      res.status(500).json({ message: 'the product sold out' });
  });
    };

// new ibtisam 
    exports.deletepaymentadmin = (req, res) => {
      const paymentId = req.params.paymentId; 
    // parameters order.paymentid 
      paymentRepository.deletepaymentadmin(paymentId)
        .then((message) => {
          res.status(200).json({ message }); 
        })
        .catch((error) => {
          res.status(400).json({ message: error }); 
        });
    };