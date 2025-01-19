// services/maps/map_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import '../../models/location.dart';

class MapService {
  static Future<void> addLocationMarkers({
    required MapController controller,
    required List<Location> locations,
    Icon? icon,
  }) async {
    final markerIcon = MarkerIcon(icon: icon ?? const Icon(Icons.location_on, size: 36, color: Colors.blue));
    for (final loc in locations) {
      await controller.addMarker(
        GeoPoint(latitude: loc.latitude, longitude: loc.longitude),
        markerIcon: markerIcon,
      );
    }
  }
}
