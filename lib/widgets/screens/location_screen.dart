import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/providers/locations_provider.dart';
import '../app_drawer.dart';
import '../grids/location_grid.dart';
import '../../services/navigation_service.dart';

class LocationScreen extends StatelessWidget {
  final NavigationService navigationService;

  LocationScreen({required this.navigationService});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      drawer: AppDrawer(
        navigationService: navigationService, // Use the service here
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // Use the locations from the provider
        child: LocationGrid(locations: locationProvider.locations),
      ),
    );
  }
}
