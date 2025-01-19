import 'package:collection/collection.dart';
import 'package:exams/widgets/screens/location_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/location.dart';
import 'loading_overlay.dart';
import 'location_popup.dart';

class FlutterMapWithMarkers extends StatefulWidget {
  final List<Location> locations;
  final Location? focusLocation;

  const FlutterMapWithMarkers({
    Key? key,
    required this.locations,
    this.focusLocation,
  }) : super(key: key);

  @override
  _FlutterMapWithMarkersState createState() => _FlutterMapWithMarkersState();
}

class _FlutterMapWithMarkersState extends State<FlutterMapWithMarkers> {
  final MapController _mapController = MapController();
  final PopupController _popupController = PopupController();

  bool _isLoading = true;
  bool _hasFocused = false;

  // List of markers for your app's `Location`s + user marker
  late List<Marker> _markers;

  // Store the user's location as a LatLng, if known
  LatLng? _userLatLng;

  @override
  void initState() {
    super.initState();

    // Convert `Location` objects into `Marker`s
    _markers = widget.locations.map((loc) {
      return Marker(
        width: 40,
        height: 40,
        point: LatLng(loc.latitude, loc.longitude),
        child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
      );
    }).toList();

    _getUserLocation();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasFocused) {
        _hasFocused = true;
        _focusInitialLocation();
      }
    });
  }

  // 1) Focus on either `focusLocation` or default to Skopje
  Future<void> _focusInitialLocation() async {
    setState(() => _isLoading = true);

    const zoom = 14.0;
    if (widget.focusLocation != null) {
      final loc = widget.focusLocation!;
      _mapController.move(LatLng(loc.latitude, loc.longitude), zoom);
    } else {
      // Default: Skopje
      _mapController.move(const LatLng(41.9981, 21.4254), zoom);
    }

    setState(() => _isLoading = false);
  }

  Future<void> _getUserLocation() async {
    setState(() => _isLoading = true);

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() => _isLoading = false);
        return;
      }
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLatLng = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          width: 40,
          height: 40,
          point: _userLatLng!,
          child: const Icon(
            Icons.person_pin_circle,
            color: Colors.red,
            size: 40,
          ),
        ),
      );
      _isLoading = false;
    });
  }

  void _centerOnUserLocation() {
    if (_userLatLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User location not available')),
      );
      return;
    }
    _mapController.move(_userLatLng!, 16.0);
  }

  // Build the map with markers and popups
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        body: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: const LatLng(41.9981, 21.4254),
            initialZoom: 4.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a','b','c'],
            ),

            MarkerLayer(
              markers: _markers,
            ),

            PopupMarkerLayer(
              options: PopupMarkerLayerOptions(
                markers: _markers,
                popupController: _popupController,
                markerCenterAnimation: MarkerCenterAnimation(),
                popupDisplayOptions: PopupDisplayOptions(
                  builder: (BuildContext context, Marker marker) {
                    final location = _findLocationByMarker(marker);
                    if (location == null) {

                      return const SizedBox();
                    }

                    return MarkerPopup(
                      location: location,
                      onNavigate: () => _onNavigate(location),
                      onOpenDetails: () => _onOpenDetails(location),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        // 4) A button to center on user location if available
        floatingActionButton: FloatingActionButton(
          onPressed: _centerOnUserLocation,
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }

  Location? _findLocationByMarker(Marker marker) {
    // If the marker's lat/lon matches a known location, return that
    return widget.locations.firstWhereOrNull(
          (loc) =>
      loc.latitude == marker.point.latitude &&
          loc.longitude == marker.point.longitude,
    );
  }

  // Called when "Navigate" is tapped in the popup
  void _onNavigate(Location location) {
    _popupController.hideAllPopups();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigate to: ${location.name}')),
    );
  }

  // Called when "Open Details" is tapped
  void _onOpenDetails(Location location) {
    _popupController.hideAllPopups();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationDetailsScreen(location: location),
      ),
    );
  }
}
