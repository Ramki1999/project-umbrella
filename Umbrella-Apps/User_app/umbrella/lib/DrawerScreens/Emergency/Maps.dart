import 'dart:async';
import 'package:umbrella/IntroScreens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

///Uses google maps to show safe zones near ur place
///Uses static data but can use dynamic data once server is established
class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Umbrella",
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "Maps",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 9.0,
        ),
        body: MapSample());
  }
}

//My Location : 80.212045 , 13.0755837
// uLat, uLng ------> Declared in HomeScreen
class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Set<Marker> markers = {};
  Completer<GoogleMapController> _controller = Completer();

  void initState() {
    setState(() {
      markers = new Set.from([_initaialmarker]);
    });
  }

  Marker _initaialmarker = Marker(
      markerId: MarkerId("myLocation"),
      position: LatLng(uLat, uLng),
      infoWindow: InfoWindow(title: "My Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
  Marker _safezonemarker = Marker(
      markerId: MarkerId("SafeZone"),
      position: LatLng(13.076742, 80.211113),
      infoWindow: InfoWindow(
          title:
              "Tallest Building  - SAFE"), //Static data however the safe zones can be cached from the server once the server and data collection is deployed.
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

  static CameraPosition get _initialLocation => CameraPosition(
        target: LatLng(uLat, uLng),
        zoom: 17.2746,
      );

  static final CameraPosition _safeZone = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(13.076742, 80.211113),
      tilt: 29.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _initialLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _goToTheSafeZone();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Safe zone here is a static point\nHowever will deploy a true value once the server is ready"),
              duration: Duration(seconds: 5),
            ),
          );
        },
        label: Text('To the Safe Zoner!'),
        icon: Icon(Icons.settings_input_antenna),
      ),
    );
  }

  Future<void> _goToTheSafeZone() async {
    setState(() {
      markers = new Set.from([_initaialmarker, _safezonemarker]);
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_safeZone));
  }
}
