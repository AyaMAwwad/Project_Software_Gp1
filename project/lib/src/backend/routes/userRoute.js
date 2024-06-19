const express = require('express');
const userController = require('../controllers/UserController.js');
//const { authenticateUser } = require('../middlewares/authenticateUser');
const authController = require('../controllers/authController');
// yoyo
const multer = require('multer');
const path = require('path');
// yoyo

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

// ibtisam 
router.get('/list', userController.getdatauser );
router.put('/updateadmin', userController.updateadminofuser);


// aya 
router.put('/Interaction', userController.userInteraction);
// 15_MAY 
router.get('/deliveryEmployee', userController.deliveryEmployee);
router.get('/deliveryFromSellar', userController.deliveryFromSellar);
router.get('/deliverydetialsOfBuyer', userController.deliverydetialsOfBuyer);

// ibtisam new data 
router.post('/adduseradmin', userController.adduserfromadmin); // adduserfromadmin

// yoyo 


const imageStorage = multer.diskStorage({
  // Destination to store image     
  destination: 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads', 
    filename: (req, file, cb) => {
        cb(null, file.fieldname  +'_'+Date.now()
           + path.extname(file.originalname))
          // file.fieldname is name of the field (image)
          // path.extname get the uploaded file extension
  }
});

const imageUpload = multer({
  storage: imageStorage,
  limits: {
    fileSize: 1000000 // 1000000 Bytes = 1 MB
  },
  fileFilter(req, file, cb) {
    if (!file.originalname.match(/\.(png|jpg)$/)) { 
       // upload only png and jpg format
       return cb(new Error('Please upload a Image'))
     }
   cb(undefined, true)
}
})
router.put('/addProfileImage',imageUpload.array('image',4 ), userController.addProfileImage); 
router.get('/getProfileImage', userController.getProfileImage);
router.get('/getProfileImageForChat', userController.getProfileImage);
// yoyo 



module.exports = router;