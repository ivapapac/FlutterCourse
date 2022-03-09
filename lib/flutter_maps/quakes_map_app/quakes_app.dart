import 'dart:async';
import 'package:first_flutter_app/flutter_maps/quakes_map_app/model/quake.dart';
import 'package:first_flutter_app/flutter_maps/quakes_map_app/network/network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class QuakesApp extends StatefulWidget {
  const QuakesApp({Key? key}) : super(key: key);

  @override
  State<QuakesApp> createState() => _QuakesAppState();
}

class _QuakesAppState extends State<QuakesApp> {
  late Future<Quake> _quakesData;
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markerList = <Marker>[];
  double _zoomVal = 5.0;
  LatLng _selectedQuake = const LatLng(40.712776, -74.005974);

  @override
  void initState() {
    super.initState();
    _quakesData = Network().getAllQuakes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(context),
          _zoomMinus(),
          _zoomPlus(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          findQuakes();
        },
        label: const Text("Find Quakes"),
      ),
    );
  }

  Widget _zoomPlus() {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {
            _zoomVal++;
            _zoomInOrOut(_zoomVal, _selectedQuake);
          },
          icon: const Icon(
            FontAwesomeIcons.searchPlus,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _zoomMinus() {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
            onPressed: () {
              _zoomVal--;
              _zoomInOrOut(_zoomVal, _selectedQuake);
            },
            icon: const Icon(
              FontAwesomeIcons.searchMinus,
              color: Colors.black87,
            )),
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _selectedQuake,
          zoom: 3.0,
        ),
        markers: Set<Marker>.of(_markerList),
      ),
    );
  }

  void findQuakes() {
    setState(() {
      _markerList.clear();
      _handleResponse();
    });
  }

  void _handleResponse() {
    setState(() {
      _quakesData.then((quakes) => {
            quakes.features?.forEach((quake) {
              _markerList.add(Marker(
                  markerId: MarkerId(quake.id ?? ""),
                  infoWindow: InfoWindow(
                    title: quake.properties?.mag.toString(),
                    snippet: quake.properties?.title,
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
                  position: LatLng(
                      quake.geometry?.coordinates?[1] ?? 0, quake.geometry?.coordinates?[0] ?? 0),
                  onTap: () {
                    setState(() {
                      _selectedQuake = LatLng(
                          quake.geometry?.coordinates?[1] ?? _selectedQuake.latitude,
                          quake.geometry?.coordinates?[0] ?? _selectedQuake.longitude);
                      print(
                          "Earthquake location: ${_selectedQuake.latitude}, ${_selectedQuake.longitude}");
                    });
                  }));
            })
          });
    });
  }

  Future<void> _zoomInOrOut(double zoomVal, LatLng location) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: location,
        zoom: zoomVal,
      ),
    ));
  }
}
