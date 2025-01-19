import 'package:exams/widgets/screens/location_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:collection/collection.dart';

import '../../models/location.dart';
import '../services/map_service.dart';
import 'loading_overlay.dart';
import 'location_popup.dart';

class FlutterMapWithRouting extends StatefulWidget {
  final List<Location> locations;
  final Location? focusLocation;

  const FlutterMapWithRouting({
    Key? key,
    required this.locations,
    this.focusLocation,
  }) : super(key: key);

  @override
  _FlutterMapWithRoutingState createState() => _FlutterMapWithRoutingState();
}

class _FlutterMapWithRoutingState extends State<FlutterMapWithRouting> {
  final MapController _mapController = MapController();
  final PopupController _popupController = PopupController();

  bool _isLoading = true;
  bool _hasFocused = false;

  late List<Marker> _markers;
  LatLng? _userLatLng;
  List<LatLng> _routePoints = [];

  final MapService _mapService = MapService();

  @override
  void initState() {
    super.initState();

    // Convert `Location` objects into markers
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

    try {
      final userLocation = await _mapService.getCurrentLocation();
      if (userLocation != null) {
        setState(() {
          _userLatLng = userLocation;

          // Add user marker
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
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user location: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _onNavigate(Location location) async {
    if (_userLatLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User location is unknown')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final routePoints = await _mapService.getRoute(
        _userLatLng!,
        LatLng(location.latitude, location.longitude),
      );

      setState(() {
        _routePoints = routePoints;

      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch route: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onOpenDetails(Location location) {
    _popupController.hideAllPopups();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LocationDetailsScreen(location: location),
      ),
    );
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
              subdomains: const ['a', 'b', 'c'],
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
                  builder: (context, marker) {
                    final location = _findLocationByMarker(marker);
                    if (location == null) return const SizedBox();
                    return MarkerPopup(
                      location: location,
                      onNavigate: () => _onNavigate(location),
                      onOpenDetails: () => _onOpenDetails(location),
                    );
                  },
                ),
              ),
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: _routePoints,
                  color: Colors.blue,
                  strokeWidth: 4.0,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _centerOnUserLocation,
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }

  Location? _findLocationByMarker(Marker marker) {
    return widget.locations.firstWhereOrNull(
          (loc) =>
      loc.latitude == marker.point.latitude &&
          loc.longitude == marker.point.longitude,
    );
  }
}
