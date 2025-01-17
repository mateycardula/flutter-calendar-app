import 'package:flutter/material.dart';
import '../../models/location.dart';

class LocationProvider with ChangeNotifier {
  List<Location> _locations = [
    Location(
      building: 'Engineering Block',
      floor: '1st Floor',
      name: 'Room 101',
      latitude: 40.7128,
      longitude: -74.0060,
      id: '0',
    ),
    Location(
      building: 'Science Block',
      floor: '2nd Floor',
      name: 'Room 202',
      latitude: 34.0522,
      longitude: -118.2437,
      id: '1',
    ),
    Location(
      building: 'Library',
      floor: 'Ground Floor',
      name: 'Study Hall',
      latitude: 51.5074,
      longitude: -0.1278,
      id: '2',
    ),
    Location(
      building: 'Administration',
      floor: '3rd Floor',
      name: 'Conference Room',
      latitude: 48.8566,
      longitude: 2.3522,
      id: '3',
    ),
    // More mock locations...
  ];

  Location getLocationById(String locationId) {
    return _locations.firstWhere((location) => location.id == locationId);
  }

  List<Location> get locations => _locations;
}
