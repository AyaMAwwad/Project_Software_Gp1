
const express = require('express');
//const { authenticateUser } = require('../middlewares/authenticateUser');
const productController = require('../controllers/productController.js');
const router = express.Router();
const multer = require('multer');
const path = require('path');

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


router.post('/AddProduct' ,imageUpload.array('image',4 ),productController.addProduct);


router.get('/products' , productController.getproduct);

router.get('/productImages', productController.getProductImages);

router.get('/pricenew', productController.getnewprice);
router.get('/typeofproduct', productController.gettypeofproduct);
//new new 
router.post('/add', productController.addToShopCart);
router.get('/getCartItem', productController.getToShopCart);
router.delete('/deleteCartItem', productController.deleteFromShopCart);
module.exports = router;
