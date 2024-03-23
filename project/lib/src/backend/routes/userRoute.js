const express = require('express');
const userController = require('../controllers/UserController.js');
//const { authenticateUser } = require('../middlewares/authenticateUser');
const authController = require('../controllers/authController');

const router = express.Router();

// Routes for user registration and authentication
router.post('/login', userController.loginUser);

router.post('/signup', authController.signup);
/*//example of get and delete
router.delete(
  '/deactivate',
  authenticateUser,
  userController.deactivateAccount,
);
router.get(
  '/contributions',
  authenticateUser,
  userController.getUsersContributions,
);

router.get('/sameUsers', authenticateUser, userController.getSameUsers);
*/

module.exports = router;