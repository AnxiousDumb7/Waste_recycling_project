import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// For web, google maps needs API key in web/index.html as a script tag
// For Android, API key goes into AndroidManifest.xml (provided below)

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  final LatLng _initialPos = const LatLng(19.0760, 72.8777); // Mumbai sample
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('glass1'),
      position: LatLng(19.0760, 72.8777),
      infoWindow: InfoWindow(title: 'Glass Collection Center'),
    ),
    const Marker(
      markerId: MarkerId('paper1'),
      position: LatLng(19.0700, 72.8850),
      infoWindow: InfoWindow(title: 'Paper Recycling Point'),
    ),
  };

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    // On web, google maps widget works via the plugin web implementation.
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Collection Points')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _initialPos, zoom: 12.0),
        markers: _markers,
        myLocationEnabled: false,
        zoomControlsEnabled: true,
      ),
    );
  }
}
