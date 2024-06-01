
const express = require('express');
const paymentController = require('../controllers/paymentController.js');
const router = express.Router();

router.post('/add', paymentController.addPayment);
router.put('/updateTheQuantityToPayment', paymentController.updateTheQuantityToPayment);
router.delete('/deleteFromCartProductThatPaied', paymentController.deleteFromCartProductThatPaied);
router.get('/checkTheQuantityToPayment', paymentController.checkTheQuantityToPayment);

// ibtisam new 
router.delete('/paydelete/:paymentId', paymentController.deletepaymentadmin);

module.exports = router;