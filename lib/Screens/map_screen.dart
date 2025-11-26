import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /*late GoogleMapController mapController;

  // Starting camera position (Talegaon)
  static const LatLng _initialPosition = LatLng(18.7196, 73.6811);
*/

  // Static recycling centers dummy info with real location
  final List<Map<String, dynamic>> recycleCenters = [
    {
      'name': 'Green Planet Recyclers',
      'lat': 18.7196,
      'lng': 73.6811,
      'address': 'Main Rd, Talegaon Dabhade',
      'url': 'https://www.google.com/maps?q=18.7196,73.6811'
    },
    {
      'name': 'Talegaon Waste Management Center',
      'lat': 18.7234,
      'lng': 73.6778,
      'address': 'MIDC Area, Talegaon Dabhade',
      'url': 'https://www.google.com/maps?q=18.7234,73.6778'
    },
    {
      'name': 'Eco Recycle Hub',
      'lat': 18.7182,
      'lng': 73.6870,
      'address': 'Station Rd, Talegaon Dabhade',
      'url': 'https://www.google.com/maps?q=18.7182,73.6870'
    },
    {
      'name': 'Clean Earth Recycling Depot',
      'lat': 18.7165,
      'lng': 73.6792,
      'address': 'Shivaji Nagar, Talegaon Dabhade',
      'url': 'https://www.google.com/maps?q=18.7165,73.6792'
    },
    {
      'name': 'GreenFuture Scrap Dealers',
      'lat': 18.7212,
      'lng': 73.6855,
      'address': 'Datta Nagar, Talegaon Dabhade',
      'url': 'https://www.google.com/maps?q=18.7212,73.6855'
    },
    {
      'name': 'EcoSmart Paper Recycling',
      'lat': 18.7258,
      'lng': 73.6833,
      'address': 'Indrayani Nagar, Talegaon Dabhade',
      'url': 'https://www.google.com/maps?q=18.7258,73.6833'
    },
    {
      'name': 'Swachh Waste Solutions',
      'lat': 18.7144,
      'lng': 73.6809,
      'address': 'Ganesh Nagar, Talegaon Dabhade',
      'url': 'https://www.google.com/maps?q=18.7144,73.6809'
    },
    {
      'name': 'GreenBins Recycling Center',
      'lat': 18.7271,
      'lng': 73.6797,
      'address': 'Old Pune-Mumbai Hwy, Talegaon Dabhade',
      'url': 'https://www.google.com/maps?q=18.7271,73.6797'
    },
    {
      'name': 'PlanetSafe Paper & Glass Center',
      'lat': 18.7207,
      'lng': 73.6899,
      'address': 'Sai Nagar, Talegaon Dabhade',
      'url': 'https://www.google.com/maps?q=18.7207,73.6899'
    },
    {
      'name': 'EcoRoots Recycling Station',
      'lat': 18.7151,
      'lng': 73.6838,
      'address': 'Bhairavnath Rd, Talegaon Dabhade',
      'url': 'https://www.google.com/maps?q=18.7151,73.6838'
    },
  ];

  /*final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    for (var center in recycleCenters) {
      _markers.add(
        Marker(
          markerId: MarkerId(center['name']),
          position: LatLng(center['lat'], center['lng']),
          infoWindow: InfoWindow(title: center['name']),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }
  }

  // Move camera to selected center
  void _goToLocation(double lat, double lng) {
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15),
    );
  }
*/

  // Open Google Map links externally
  Future<void> _openMap(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Talegaon Recycling Centers")),
      body: Column(
        children: [
          /*
          Expanded(
            flex: 2,
            child: GoogleMap(
              onMapCreated: (controller) => mapController = controller,
              initialCameraPosition: const CameraPosition(
                target: _initialPosition,
                zoom: 14,
              ),
              markers: _markers,
            ),
          ),
*/
          // List of Centers 
          Expanded(
            flex: 2,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: recycleCenters.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final center = recycleCenters[index];
                return ListTile(
                  leading: const Icon(Icons.recycling, color: Colors.green),
                  title: Text(center['name']),
                  subtitle: Text(center['address']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min, // don't use any free space
                    children: [
                      IconButton(
                        icon: const Icon(Icons.location_on_rounded, color: Colors.blue),
                        onPressed: () => _openMap(center['url']),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
