// widgets/screens/location_map_screen.dart
import 'package:exams/services/navigation_service.dart';
import 'package:exams/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/location.dart';
import '../../services/providers/locations_provider.dart';
import '../osm_map_with_markers.dart';

class LocationMapScreen extends StatelessWidget {
  final Location? focusLocation;
  final NavigationService navigationService;
  const LocationMapScreen({Key? key, this.focusLocation, required this.navigationService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final locations = locationProvider.locations;

    return Scaffold(
      appBar: AppBar(
        title: Text('Locations Map'),
      ),
      drawer: AppDrawer(navigationService: navigationService),
      body: FlutterMapWithRouting(
        locations: locations,
        focusLocation: focusLocation,
      ),
    );
  }
}
