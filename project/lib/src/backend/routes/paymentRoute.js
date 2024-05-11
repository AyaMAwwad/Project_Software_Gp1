
const express = require('express');
const paymentController = require('../controllers/paymentController.js');
const router = express.Router();

router.post('/add', paymentController.addPayment);
router.put('/updateTheQuantityToPayment', paymentController.updateTheQuantityToPayment);
router.delete('/deleteFromCartProductThatPaied', paymentController.deleteFromCartProductThatPaied);
router.get('/checkTheQuantityToPayment', paymentController.checkTheQuantityToPayment);
module.exports = router;