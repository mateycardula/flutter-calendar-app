import 'package:flutter/material.dart';
import '../../models/location.dart';

class LocationProvider with ChangeNotifier {
  List<Location> _locations = [
    Location(
      building: 'Engineering Block',
      floor: '1st Floor',
      name: 'Room 101',
      latitude: 41.9981,
      longitude: 21.4254,
      id: '0',
    ),
    Location(
      building: 'Science Block',
      floor: '2nd Floor',
      name: 'Room 202',
      latitude: 41.9990,
      longitude: 21.4270,
      id: '1',
    ),
    Location(
      building: 'Library',
      floor: 'Ground Floor',
      name: 'Study Hall',
      latitude: 42.0005,
      longitude: 21.4265,
      id: '2',
    ),
    Location(
      building: 'Administration',
      floor: '3rd Floor',
      name: 'Conference Room',
      latitude: 41.9955,
      longitude: 21.4240,
      id: '3',
    ),
  ];

  Location getLocationById(String locationId) {
    return _locations.firstWhere((location) => location.id == locationId);
  }

  List<Location> get locations => _locations;
}
