// osm_map_with_markers.dart
import 'dart:math';
import 'package:exams/widgets/screens/location_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import '../../models/location.dart';
import '../configuration/default_osm_config.dart';
import '../services/map_service.dart';
import 'loading_overlay.dart';
import 'location_popup.dart';

class OSMMapWithMarkers extends StatefulWidget {
  final List<Location> locations;
  final Location? focusLocation;

  const OSMMapWithMarkers({
    Key? key,
    required this.locations,
    this.focusLocation,
  }) : super(key: key);

  @override
  State<OSMMapWithMarkers> createState() => _OSMMapWithMarkersState();
}

class _OSMMapWithMarkersState extends State<OSMMapWithMarkers> {
  late MapController _mapController;
  bool _isLoading = true;
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController(
      initMapWithUserPosition: UserTrackingOption(),
    );

    // Setup single-tap detection for marker "clicks"
    _setupMarkerTapListener();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: OSMFlutter(
        controller: _mapController,
        osmOption: DefaultOSMConfig.buildOSMOption(),
        onMapIsReady: (bool isReady) async {
          if (isReady && !_isMapReady) {
            _isMapReady = true;

            // Place markers for each location
            await MapService.addLocationMarkers(
              controller: _mapController,
              locations: widget.locations,
            );

            // Focus logic
            if (widget.focusLocation != null) {
              await _mapController.setZoom(zoomLevel: 14);
              await _mapController.changeLocation(
                GeoPoint(
                  latitude: widget.focusLocation!.latitude,
                  longitude: widget.focusLocation!.longitude,
                ),
              );
            } else {
              // Default to Skopje
              await _mapController.setZoom(zoomLevel: 14);
              await _mapController.changeLocation(
                 GeoPoint(latitude: 41.9981, longitude: 21.4254),
              );
            }

            // Hide the loading overlay
            setState(() {
              _isLoading = false;
            });
          }
        },
      ),
    );
  }

  void _setupMarkerTapListener() {
    _mapController.listenerMapSingleTapping.addListener(() async {
      final tappedPoint = _mapController.listenerMapSingleTapping.value;
      if (tappedPoint == null) return;

      final tappedLocation = _findLocationByTap(
        lat: tappedPoint.latitude,
        lon: tappedPoint.longitude,
        locations: widget.locations,
        thresholdMeters: 100,
      );

      if (tappedLocation != null) {
        showLocationPopup(
          context: context,
          location: tappedLocation,
          onNavigate: () => _onNavigate(tappedLocation),
          onOpenDetails: () => _onOpenDetails(tappedLocation),
        );
      }
    });
  }

  Location? _findLocationByTap({
    required double lat,
    required double lon,
    required List<Location> locations,
    required double thresholdMeters,
  }) {
    for (final loc in locations) {
      final dist = _distanceInKm(loc.latitude, loc.longitude, lat, lon) * 1000; // meters
      if (dist < thresholdMeters) {
        return loc;
      }
    }
    return null;
  }

  double _distanceInKm(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295; // pi/180
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void _onNavigate(Location location) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigate to: ${location.name}')),
    );
  }

  void _onOpenDetails(Location location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationDetailsScreen(location: location),
      ),
    );
  }
}
