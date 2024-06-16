
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
//newwwww 1-MAY
//router.get('/retriveProductOfsearch', productController.retriveProductOfsearch);
router.get('/retriveProductOfsearch', productController.retriveProductOfsearch);
// new 12/5 
router.get('/sallerProduct', productController.sallerProduct);


// new ibtisam 

router.get('/productlistt', productController.gettproducttoadmin); // gettproducttoadmin

// ayaaa
// 18/5 deleteItemSellar
router.delete('/deleteItemSellar', productController.deleteItemSellar);
// 19/5 updateSellarProduct
router.put('/updateSellarProduct', productController.updateSellarProduct);

router.get('/productThisMonth', productController.productThisMonth);
router.get('/retriveProductHomeRecomendedSystem', productController.retriveProductHomeRecomendedSystem);
router.post('/addRatingProduct', productController.addRatingProduct);
// aya
router.get('/checkQuantityForNotification', productController.checkQuantityForNotification);
router.get('/ProductNewCollectionForNotification', productController.ProductNewCollectionForNotification);



// statistics 
router.get('/totalproduct', productController.totalnumberproductforstatistics);
router.get('/totalproductsold', productController.totalnumbersoldproduct);

router.get('/totalrevenue', productController.totalRevenue);

// aya 
router.post('/addToWishList', productController.addToWishList);
router.get('/retriveFromWishList', productController.retriveFromWishList);
router.delete('/deleteFromWishList', productController.deleteFromWishList);
router.get('/findSimilar', productController.findSimilar);
//aya 


// ayosh
router.get('/totalnumberproductofSeller', productController.totalnumberproductofSeller);
router.get('/totalproductsoldofSeller', productController.totalproductsoldofSeller);

router.get('/totalrevenueofseller', productController.totalrevenueofseller);

// ayosh


module.exports = router;