// widgets/screens/location_map_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/location.dart';
import '../../services/providers/locations_provider.dart';
import '../osm_map_with_markers.dart';

class LocationMapScreen extends StatelessWidget {
  final Location? focusLocation;

  const LocationMapScreen({Key? key, this.focusLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Grab locations from the provider
    final locationProvider = Provider.of<LocationProvider>(context);
    final locations = locationProvider.locations;

    return Scaffold(
      appBar: AppBar(
        title: Text('Locations Map'),
      ),
      body: OSMMapWithMarkers(
        locations: locations,
        focusLocation: focusLocation,
      ),
    );
  }
}
