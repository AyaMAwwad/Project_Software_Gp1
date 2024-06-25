import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/widgets/button_2.dart';

class userSelectLocation extends StatefulWidget {
  @override
  State<userSelectLocation> createState() => userSelectLocationState();
}

class userSelectLocationState extends State<userSelectLocation> {
  GoogleMapController? gmc;
  static double? firstLatLng;
  static double? secondLatLng;
  List<Marker> marker = [];
  bool _dialogShown = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showLocationDialog());
  }

  void _showLocationDialog() {
    if (!_dialogShown) {
      _dialogShown = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Text(
              'Select Your Location',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 2, 92, 123),
                  fontSize: 20,

                  // decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Text(
              'Tap on the map to select your location.',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 1, 3, 4),
                  fontSize: 14,

                  // decoration: TextDecoration.underline,
                  decorationThickness: 1,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: <Widget>[
              CustomeButton2(
                text: "ok",
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Location',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 22,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ $firstLatLng');
                print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ $secondLatLng');
                if (firstLatLng == null || secondLatLng == null) {
                  Flushbar(
                    message: "Please select your location",
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.red,
                    margin: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8),
                  ).show(context);
                } else {
                  firstLatLng = null;
                  secondLatLng = null;
                  /*  Flushbar(
                    message: "Your Location has been saved successfully",
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.green,
                    margin: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8),
                  ).show(context);*/
                  Navigator.of(context).pop();
                  /* showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        title: Text(
                          'Thank you',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: Color.fromARGB(255, 2, 92, 123),
                              fontSize: 20,

                              // decoration: TextDecoration.underline,
                              decorationThickness: 1,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        content: Text(
                          'You can Track your Order after start the delivery process, we will send notifications to you',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              color: Color.fromARGB(255, 1, 3, 4),
                              fontSize: 14,

                              decorationThickness: 1,
                       
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          CustomeButton2(
                            text: "Done",
                            onPressed: () {
                              firstLatLng = null;
                              secondLatLng = null;
                              Get.to(() => HomePage());
                            },
                          ),
                        ],
                      );
                    },
                  );*/
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 255, 255, 255), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Done',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF0D6775),
      ),
      body: GoogleMap(
        onTap: (LatLng latlng) {
          print('++++++++++++++++++++++++++');
          print('${latlng.latitude}');
          print('${latlng.longitude}');
          print('++++++++++++++++++++++++++');
          marker.add(Marker(
            markerId: MarkerId("1"),
            position: LatLng(latlng.latitude, latlng.longitude),
          ));
          firstLatLng = latlng.latitude;
          secondLatLng = latlng.longitude;
          setState(() {});
        },
        mapType: MapType.normal,

        initialCameraPosition: CameraPosition(
          target: //sourceLocation,
              LatLng(32.161301, 35.283588),
          zoom: 13.5,
        ),
        markers: marker.toSet(),
        onMapCreated: (controller) {
          gmc = controller;
        },
        //
      ),
    );
  }
}
