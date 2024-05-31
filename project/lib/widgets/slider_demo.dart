import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SliderPage extends StatelessWidget {
  double ii = 0.0;
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    double adjustedWidth = containerWidth - 70;
    double yyy = 0.00;
    if (containerWidth > 1000) {
      adjustedWidth = containerWidth - 300;
    }
    if (kIsWeb) {
      ii = 400.0;
      yyy = adjustedWidth;
    } else {
      ii = 200.0;
      yyy = containerWidth;
    }

    print('sssssss$containerWidth');
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 10), // Adjust the horizontal margin as needed
      child: SizedBox(
        height: ii, //200
        // if(kIsWeb),
        width: yyy,

        /// ibti
        // margin: 89,
        // padding: EdgeInsets.all(60), //10
        child: AnotherCarousel(
          images: [
            AssetImage('images/icon/fash_C.jpg'),
            AssetImage('images/icon/gam_A.png'),
            AssetImage('images/icon/fur_A.jpg'),
            AssetImage('images/icon/book_A.jpg'),
            AssetImage('images/icon/psA.jpeg'),
          ],
          // width:100,
          // maxWidth:2900,
          borderRadius: true,
          radius: Radius.circular(18),
          dotBgColor: Colors.transparent,
          dotIncreasedColor: Color(0xFF063A4E),
          animationCurve: Curves.fastOutSlowIn,

          animationDuration: Duration(
            milliseconds: 800,
          ),
        ),
      ),
    );
  }
}
