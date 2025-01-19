// services/maps/default_osm_config.dart
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class DefaultOSMConfig {
  static OSMOption buildOSMOption({
    bool showZoomController = true,
    bool enableRotationByGesture = true,
    RoadOption? roadOption,
    bool showContributorBadge = false,
    bool showDefaultInfoWindow = false,
    bool isPicker = false,
    ZoomOption? zoomOption,
  }) {
    return OSMOption(
      showZoomController: showZoomController,
      userLocationMarker: UserLocationMaker(
        personMarker: MarkerIcon(
          icon: Icon(
            Icons.location_history,
            color: Colors.red,
            size: 48,
          ),
        ),
        directionArrowMarker: MarkerIcon(
          icon: Icon(
            Icons.double_arrow,
            color: Colors.redAccent,
            size: 48,
          ),
        ),
      ),
      roadConfiguration: roadOption ?? RoadOption(roadColor: Colors.blue),
      zoomOption: zoomOption ??
          ZoomOption(
            minZoomLevel: 3,
            maxZoomLevel: 19,
            initZoom: 3,
            stepZoom: 1.0,
          ),
      enableRotationByGesture: enableRotationByGesture,
      showDefaultInfoWindow: showDefaultInfoWindow,
      isPicker: isPicker,
      showContributorBadgeForOSM: showContributorBadge,
      staticPoints: const [], // Generally override if needed
    );
  }
}
