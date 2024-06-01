
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

router.get('/usedprice', productController.getusedprice);

router.get('/typeofproduct', productController.gettypeofproduct);
router.post('/add', productController.addToShopCart);
router.get('/getCartItem', productController.getToShopCart);
router.delete('/deleteCartItem', productController.deleteFromShopCart);
// new 2_MAY
router.put('/updateItemOnShopCart', productController.updateItemOnShopCart);

router.get('/retriveWordOfsearch', productController.retriveWordOfsearch);

router.get('/retriveProductOfsearch', productController.retriveProductOfsearch);
// new 12/5 
router.get('/sallerProduct', productController.sallerProduct);
// 18/5 deleteItemSellar
router.delete('/deleteItemSellar', productController.deleteItemSellar);
// 19/5 updateSellarProduct
router.put('/updateSellarProduct', productController.updateSellarProduct);
// 20/5
router.post('/addRatingProduct', productController.addRatingProduct);

// 22/5
router.get('/retriveProductHomeRecomendedSystem', productController.retriveProductHomeRecomendedSystem);
// new 28/5
router.get('/productThisMonth', productController.productThisMonth);

router.get('/productlistt', productController.gettproducttoadmin); // gettproducttoadmin

module.exports = router;