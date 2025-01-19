// widgets/maps/osm_map_with_markers.dart
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import '../../models/location.dart';
import '../configuration/default_osm_config.dart';
import '../services/map_service.dart';
import 'loading_overlay.dart';

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

            await MapService.addLocationMarkers(controller: _mapController, locations: widget.locations);

            if (widget.focusLocation != null) {
              await _mapController.setZoom(zoomLevel: 14);
              await _mapController.changeLocation(
                GeoPoint(latitude: widget.focusLocation!.latitude, longitude: widget.focusLocation!.longitude),
              );
            } else {
              await _mapController.setZoom(zoomLevel: 14);
              await _mapController.changeLocation(
                 GeoPoint(latitude: 41.9981, longitude: 21.4254),
              );
            }

            // Hide loading indicator
            setState(() {
              _isLoading = false;
            });
          }
        },
      ),
    );
  }
}
