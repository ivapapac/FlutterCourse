import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowSimpleMap extends StatefulWidget {
  const ShowSimpleMap({Key? key}) : super(key: key);

  @override
  State<ShowSimpleMap> createState() => _ShowSimpleMapState();
}

class _ShowSimpleMapState extends State<ShowSimpleMap> {
  late GoogleMapController mapController;
  static const LatLng _center = LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maps"),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(target: _center, zoom: 11.0),
        onMapCreated: _onMapCreated,
        mapType: MapType.terrain,
        markers: {portlandMarker, milwaukieMarker},
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToIntel,
        label: const Text("Intel Coorp"),
        icon: const Icon(Icons.place),
      ),
    );
  }

  static const CameraPosition intelPosition = CameraPosition(
      target: LatLng(45.5418324, -122.917043), zoom: 14.780, bearing: 191.789, tilt: 34.89);

  Future<void> _goToIntel() async {
    final GoogleMapController controller = mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(intelPosition));
  }

  Marker portlandMarker = Marker(
    markerId: const MarkerId("Portland"),
    position: _center,
    infoWindow: const InfoWindow(title: "Portland", snippet: "This is a great city!"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
  );

  Marker milwaukieMarker = Marker(
      markerId: const MarkerId("Milwaukie"),
      position: const LatLng(45.446111, -122.639167),
      infoWindow: const InfoWindow(title: "Milwaukie", snippet: "Smaller city than Portland!"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan));
}
