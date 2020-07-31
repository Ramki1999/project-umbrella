import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:umbrella/IntroScreens/HomeScreen.dart';

///Map Interface to show the necessary relief centers and its navigation
///This uses static data points however could cache dynamic data once the server with the necessary data is ready

String markerType;

class MapSearch extends StatefulWidget {
  final String markerOpt;
  MapSearch({this.markerOpt});
  @override
  _MapSearchState createState() => _MapSearchState();
}

Marker initaialmarker1 = Marker(
    markerId: MarkerId("myLocation"),
    position: LatLng(13.0739988, 80.2106934),
    infoWindow: InfoWindow(title: "My Location"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

class _MapSearchState extends State<MapSearch> {
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    setState(() {
      markers = new Set.from([initaialmarker1]);
      print(widget.markerOpt);
    });
  }

  static CameraPosition get initial => CameraPosition(
        target: LatLng(uLat, uLng),
        zoom: 12,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                      content: ListTile(
                    title: Text(
                      "NOTE",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "Marker points are static(located in chennai).Will show dynamic points near your place once server is ready"),
                  )));
        },
        label: Text("Note"),
        icon: Icon(Icons.info_outline),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: GoogleMap(
        initialCameraPosition: initial,
        onMapCreated: (controller) {
          print(widget.markerOpt);
          if (widget.markerOpt == "Animal") {
            setState(() => markers = new Set.from(
                [initaialmarker1, Amarker1, Amarker2, Amarker3, Amarker4]));
          } else if (widget.markerOpt == "Food") {
            setState(() => markers = new Set.from(
                [initaialmarker1, Fmarker1, Fmarker2, Fmarker3, Fmarker4]));
          } else if (widget.markerOpt == "Shelter") {
            setState(() => markers = new Set.from(
                [initaialmarker1, Smarker1, Smarker2, Smarker3, Smarker4]));
          }
        },
        markers: markers,
      ),
    );
  }
}

Marker Amarker1 = Marker(
    markerId: MarkerId("marker1"),
    position: LatLng(12.981291, 80.264288),
    infoWindow: InfoWindow(title: "Animal Aid"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet));
Marker Amarker2 = Marker(
    markerId: MarkerId("marker2"),
    position: LatLng(12.913652, 80.172234),
    infoWindow: InfoWindow(title: "Animal Welfare and Protection Trust"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    draggable: true);

Marker Amarker3 = Marker(
    markerId: MarkerId("marker3"),
    position: LatLng(13.005839, 80.173083),
    infoWindow: InfoWindow(title: "INCARE - Animals"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    draggable: true);

Marker Amarker4 = Marker(
    markerId: MarkerId("marker4"),
    position: LatLng(12.961095, 80.259186),
    infoWindow: InfoWindow(title: "Indian Institute of animal welfare"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    draggable: true);

Marker Fmarker1 = Marker(
    markerId: MarkerId("marker1"),
    position: LatLng(13.086781, 80.220257),
    infoWindow: InfoWindow(title: "Government Relief center"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange));
Marker Fmarker2 = Marker(
    markerId: MarkerId("marker2"),
    position: LatLng(13.071933, 80.240466),
    infoWindow: InfoWindow(title: "Food Reief center"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    draggable: true);

Marker Fmarker3 = Marker(
    markerId: MarkerId("Amma unavagam"),
    position: LatLng(13.083527, 80.239347),
    infoWindow: InfoWindow(title: "Amma unavagam"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    draggable: true);

Marker Fmarker4 = Marker(
    markerId: MarkerId("Free food for elderly"),
    position: LatLng(13.0515777, 80.2485393),
    infoWindow: InfoWindow(
        title: "Free food for Elderly",
        snippet: "click the navigation to know more"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    draggable: true);

Marker Smarker1 = Marker(
    markerId: MarkerId("Public Night Shelter,Elderly"),
    position: LatLng(13.082684, 80.270723),
    infoWindow: InfoWindow(title: "Public Night Shelter,Elderly"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
Marker Smarker2 = Marker(
    markerId: MarkerId("Public Night Shelter,Transgender"),
    position: LatLng(13.074279, 80.242828),
    infoWindow: InfoWindow(title: "Public Night Shelter,Transgender"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    draggable: true);

Marker Smarker3 = Marker(
    markerId: MarkerId("Public Night Shelter,Men"),
    position: LatLng(13.073216, 80.259505),
    infoWindow: InfoWindow(title: "Public Night Shelter,Men"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    draggable: true);

Marker Smarker4 = Marker(
    markerId: MarkerId("Public Night Shelter,Women"),
    position: LatLng(13.085334, 80.245384),
    infoWindow: InfoWindow(title: "Public Night Shelter,Women"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    draggable: true);
