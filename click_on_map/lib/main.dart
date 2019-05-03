import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final String title = 'Choose the place';

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(52.5200, 13.4050);
  LatLng _lastMapPosition = _center;
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text(widget.title),
      ),
      body: GoogleMap(
        onTap: _onmapClicked,
        onMapCreated: _onMapCreated,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        markers: _markers,
        onCameraMove: _onCameraMove,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }

  _onmapClicked(LatLng location) {
    print(location);
    setState(() {

      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: location,
        infoWindow: InfoWindow(
          title: 'This place coordinates',
          snippet: '$location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
// The result will be the location you've been selected
// something like this LatLng(12.12323,34.12312)
// you can do whatever you do with it

  }
}
