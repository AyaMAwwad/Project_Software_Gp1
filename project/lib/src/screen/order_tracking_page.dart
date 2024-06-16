/*import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> controller = Completer();
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

    location.onLocationChanged.listen((newLocation) {
      currentLocation = newLocation;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            zoom: 13.5,
            target: LatLng(
              newLocation.latitude!,
              newLocation.longitude!,
            )),
      ));
      setState(() {});
    });
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
    setState(() {});
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
                zoom: 13.5,
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
                controller.complete(mapController);
              },
            ),
    );
  }
}
*/