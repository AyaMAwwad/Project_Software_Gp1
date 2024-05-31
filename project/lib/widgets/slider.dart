// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
//SliderPage

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  CarouselController carouselController = CarouselController();

  int currPage = 0;
  double ii = 0.0;

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    double adjustedWidth = containerWidth - 70;
    double yyy = 0.00;
    final List<String> finalImg = kIsWeb ? AppData.imagesWeb : AppData.images;
    if (containerWidth > 1000) {
      adjustedWidth = containerWidth - 300;
    }
    if (kIsWeb) {
      ii = 450.0;
      yyy = adjustedWidth;
    } else {
      ii = MediaQuery.of(context).size.height * 0.25;
      yyy = containerWidth;
    }
    double viewportFraction = kIsWeb ? 1 : 0.8;
    return SizedBox(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: ii, //200
                // if(kIsWeb),
                width: yyy,
                //  height: MediaQuery.of(context).size.height * 0.25,
                //  width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: CarouselSlider(
                        carouselController: carouselController,
                        items: finalImg.map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ImageView.show(
                                url: imagePath,
                                context: context,
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          viewportFraction: viewportFraction,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currPage = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.02,
                      child: Row(
                        children: List.generate(finalImg.length, (index) {
                          bool isSelected = currPage == index;
                          return GestureDetector(
                            onTap: () {
                              carouselController.animateToPage(
                                index,
                                // more
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: AnimatedContainer(
                              height: 10,
                              width: isSelected ? 55 : 10,
                              margin: EdgeInsets.symmetric(
                                  horizontal: isSelected ? 6 : 3),
                              //color: isSelected ? Colors.red : Colors.black,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color.fromARGB(255, 2, 92, 123)
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              duration: Duration(
                                milliseconds: 300,
                              ),
                              curve: Curves.ease,
                            ),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      left: 11,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.2),
                        child: IconButton(
                          onPressed: () {
                            carouselController.animateToPage(currPage - 1);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Color.fromARGB(255, 2, 92, 123),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 11,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.2),
                        child: IconButton(
                          onPressed: () {
                            carouselController.animateToPage(currPage + 1);
                          },
                          icon: Icon(
                            color: Color.fromARGB(255, 2, 92, 123),
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageView {
  ImageView._();
  static show({
    required BuildContext context,
    required String url,
    BoxFit? fit,
    double? radius,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit ?? BoxFit.cover,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(radius ?? 25),
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) => Container(),
      errorWidget: (context, url, error) => Icon(Icons.error_outline_outlined),
    );
  }
}

class AppData {
  AppData._();
  static final List<String> images = [
    'https://www.shopashore.co.uk/wp-content/uploads/2023/06/Untitled-design-15-1024x512.png?1000',
    'https://i.pinimg.com/736x/1d/0a/b5/1d0ab5c395928af6c89c58b7cfe98f8a.jpg',
    'https://i.pinimg.com/736x/fb/fc/18/fbfc1888e91b0f02c9cf78a735812910.jpg',
    'https://i.pinimg.com/564x/5f/1b/8f/5f1b8fb64df6fcfa1d733ba21f071ae2.jpg',
    'https://i.pinimg.com/474x/27/a0/b9/27a0b9b4e7f55787992f07826857e465.jpg',
    'https://i.pinimg.com/736x/84/fe/2a/84fe2a4d84a5e91ae36aac244c5ee931.jpg',
    //'https://i.pinimg.com/736x/2d/b3/c5/2db3c5431974a4e76f5249501c90f141.jpg',
    // 'https://i.pinimg.com/564x/0c/d1/ba/0cd1bae7bbc3639b1addb93cd19a1468.jpg',
  ];
  //
  static final List<String> imagesWeb = [
    'https://www.shopashore.co.uk/wp-content/uploads/2023/06/Untitled-design-15-1024x512.png?1000',
    'https://i.pinimg.com/736x/e4/f8/94/e4f894048f06ea4bc0036e2332324de6.jpg', //'https://i.pinimg.com/564x/61/6f/a2/616fa2364e7f40cd21752ac1d2f15399.jpg', //'https://i.pinimg.com/564x/76/dc/c8/76dcc84b8f416a663ad0520047f03649.jpg',
    'https://i.pinimg.com/564x/c9/65/e6/c965e61f06df994bc3a5d40b17d7f971.jpg',
    'https://i.pinimg.com/564x/f7/e5/90/f7e590ef05dbf8da69b047d6d0f64abc.jpg',
    'https://i.pinimg.com/564x/7d/48/5a/7d485ad3e082fcb75128e8964fb4b161.jpg', //'https://i.pinimg.com/564x/83/c8/9f/83c89f1198913b8e38102cf31f3a2967.jpg',
    'https://i.pinimg.com/736x/84/fe/2a/84fe2a4d84a5e91ae36aac244c5ee931.jpg',
    // 'https://i.pinimg.com/564x/0c/d1/ba/0cd1bae7bbc3639b1addb93cd19a1468.jpg',
  ];
}


/*
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
*/
