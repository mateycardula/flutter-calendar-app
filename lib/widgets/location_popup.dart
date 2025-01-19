// lib/widgets/popups/marker_popup.dart
import 'package:flutter/material.dart';
import '../../models/location.dart';

class MarkerPopup extends StatelessWidget {
  final Location location;
  final VoidCallback onNavigate;
  final VoidCallback onOpenDetails;

  const MarkerPopup({
    Key? key,
    required this.location,
    required this.onNavigate,
    required this.onOpenDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(location.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Building: ${location.building}'),
            Text('Floor: ${location.floor}'),
            const SizedBox(height: 8),
            Text(
              'Lat: ${location.latitude.toStringAsFixed(4)}, '
                  'Lon: ${location.longitude.toStringAsFixed(4)}',
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: onNavigate, child: const Text('Navigate')),
                TextButton(onPressed: onOpenDetails, child: const Text('Details')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
