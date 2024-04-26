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

//  
router.get('/userName', userController.userName);
router.get('/AllUserName', userController.AllUserName);
router.get('/sellarChat', userController.sellarChat);
// new UpdatePass
router.put('/UpdatePass', userController.UpdatePass);
module.exports = router;