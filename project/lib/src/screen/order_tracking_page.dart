import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/src/screen/home_page.dart';
import 'package:project/src/screen/user_select_location.dart';
import 'package:project/widgets/button_2.dart';
import 'package:project/widgets/order_details_user.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';

class OrderTrackingPage extends StatefulWidget {
  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  GoogleMapController? gmc;
  static double? firstLatLng;
  static double? secondLatLng;
  StreamSubscription<Position>? positionStream;

  final LatLng sourceLocation = LatLng(32.224405, 395.233819);
//  late final LatLng destinationLocation;
  final LatLng destinationLocation = LatLng(32.161794, 395.285528);
  /*final LatLng destinationLocation = LatLng(
      userSelectLocationState.firstLatLng1!,
      userSelectLocationState.secondLatLng2!);*/ //streetAddress

  List<Marker> markers = [];
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  int polylineIndex = 0;

  @override
  void initState() {
    updateStreetAddress();
    super.initState();
    markers = [
      Marker(
        markerId: MarkerId("src"),
        position: sourceLocation,
      ),
      Marker(
        markerId: MarkerId("dest"),
        position: destinationLocation,
      ),
    ];
    setPolylines();
  }

  void updateStreetAddress() async {
    if (orederDetailsUSerState.address.text == '') {
      //  destinationLocation = LatLng(userSelectLocationState.firstLatLng1!,
      ///  userSelectLocationState.secondLatLng2!);
    } else {
      await cityToLatLng(orederDetailsUSerState.address.text);
    }
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  Future<void> cityToLatLng(String address) async {
    List<Location> locations = await locationFromAddress("$address");
    double latitude = locations[0].latitude;
    double longitude = locations[0].longitude;
    print(
        "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    print("Latitude: $latitude, Longitude: $longitude");
    //  List<geocoding.Location> locations = await geocoding.locationFromAddress("Ramallah");
    if (locations.isNotEmpty) {
      //  destinationLocation =
      //   LatLng(locations[0].latitude, locations[0].longitude);
    } else {
      print("No locations found");
    }
  }

  setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDrgXyoZlKMUDQIet_5ywTkLwdPC4BEwYo",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      animateMarker();
    });
  }

  void animateMarker() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (polylineIndex >= polylineCoordinates.length - 1) {
        timer.cancel();
        return;
      }

      setState(() {
        final nextPosition = polylineCoordinates[polylineIndex++];
        markers[0] = Marker(
          markerId: MarkerId("src"),
          position: nextPosition,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        );
      });
    });
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
              'Tracking Order',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF0D6775),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: sourceLocation,
          zoom: 13.5,
        ),
        markers: markers.toSet(),
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinates,
            color: Color(0xFF0D6775),
            width: 6,
          ),
        },
        onMapCreated: (controller) {
          gmc = controller;
        },
      ),
    );
  }
}


/*
static const LatLng sourceLocation = LatLng(32.1635515, 35.2877109);
  static const LatLng destination = LatLng(32.2635515, 35.2077109);
  List<LatLng> polyLineCoordinates = [];
  LocationData? currentLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
      //  print(currentLocation);
    });
    GoogleMapController googleMapController = await controller.future;
/*
    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            //  zoom: 13.5,
            target: LatLng(
          newLocation.latitude!,
          newLocation.longitude!,
        )),
      ));
      setState(() {});
    });*/
  }

  void getPolyPoint() async {
    PolylinePoints polylinePoint = PolylinePoints();
    PolylineResult result = await polylinePoint.getRouteBetweenCoordinates(
      'AIzaSyDrgXyoZlKMUDQIet_5ywTkLwdPC4BEwYo',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polyLineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
    }

    /// setState(() {});
  }

  void setCustomMarker() {}
  @override
  void initState() {
    getCurrentLocation();
    getPolyPoint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracking'),
      ),
      body: currentLocation == null
          ? Center(
              child: Text('Loading'),
            )
          : GoogleMap(
              /* mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,

              initialCameraPosition: CameraPosition(
                target: //sourceLocation,
                    LatLng(0, 0),
                zoom: 13.5,
              ),
              onMapCreated: (GoogleMapController controller) {},*/
              // mapType: MapType.normal,
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: //sourceLocation,
                    LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                zoom: 10.5,
              ),
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: polyLineCoordinates,
                  color: Colors.black,
                  width: 8,
                ),
              },
              markers: {
                Marker(
                  markerId: MarkerId("currentLocation"),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation,
                ),
                Marker(
                  markerId: MarkerId("destination"),
                  position: destination,
                ),
              },
              onMapCreated: (mapController) {
                gmc = mapController;
                // controller.complete(mapController);
              },
            ),
    );
  }
*/