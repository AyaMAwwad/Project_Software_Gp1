const express = require('express');
const userController = require('../controllers/UserController.js');
//const { authenticateUser } = require('../middlewares/authenticateUser');
const authController = require('../controllers/authController');
const productController = require('../controllers/productController.js');

const router = express.Router();

// Routes for user registration and authentication
router.post('/login', userController.loginUser);

router.post('/signup', authController.signup);
router.post('/editprofile', userController.Editprofile);

//new  
router.get('/userName', userController.userName);
router.get('/AllUserName', userController.AllUserName);
router.get('/sellarChat', userController.sellarChat);

router.post('/delete', userController.deleteacountt);

router.put('/UpdatePass', userController.UpdatePass);
router.post('/oldpassword', userController.oldpassword); 
/////////// 12/5 new 
router.put('/Interaction', userController.userInteraction);
// 15_MAY 
router.get('/deliveryEmployee', userController.deliveryEmployee);
router.get('/deliveryFromSellar', userController.deliveryFromSellar);
router.get('/deliverydetialsOfBuyer', userController.deliverydetialsOfBuyer);

// ibtisam 
router.get('/list', userController.getdatauser );
router.put('/updateadmin', userController.updateadminofuser);
router.post('/adduseradmin', userController.adduserfromadmin);
module.exports = router;