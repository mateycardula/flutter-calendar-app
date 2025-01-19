import 'package:flutter/material.dart';
import '../../models/location.dart';
import '../app_drawer.dart';
import '../../services/navigation_service.dart';

class LocationDetailsScreen extends StatelessWidget {
  final Location location;

  LocationDetailsScreen({
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${location.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8.0),
            Text(
              'Building: ${location.building}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 4.0),
            Text(
              'Floor: ${location.floor}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/map',
                  arguments: location,
                );
              },
              child: Text('See on Map'),
            ),
          ],
        ),
      ),
    );
  }
}
