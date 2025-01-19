import 'package:flutter/material.dart';
import '../../models/location.dart';

Future<void> showLocationPopup({
  required BuildContext context,
  required Location location,
  required VoidCallback onNavigate,
  required VoidCallback onOpenDetails,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text(location.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Building: ${location.building}'),
            Text('Floor: ${location.floor}'),
            const SizedBox(height: 16),
            Text(
              'Latitude: ${location.latitude.toStringAsFixed(4)}, '
                  'Longitude: ${location.longitude.toStringAsFixed(4)}',
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onNavigate();
            },
            child: const Text('Navigate'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onOpenDetails();
            },
            child: const Text('Open Details'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
