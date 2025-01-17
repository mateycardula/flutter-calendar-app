import 'package:flutter/material.dart';
import '../../models/location.dart';
import '../cards/location_card.dart';
import '../screens/location_details.dart';

class LocationGrid extends StatelessWidget {
  final List<Location> locations;

  const LocationGrid({
    Key? key,
    required this.locations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Add padding to the grid
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 16, // Horizontal spacing between cards
          mainAxisSpacing: 16,  // Vertical spacing between cards
          childAspectRatio: 2.0, // Adjusts height/width ratio
        ),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the LocationDetailsScreen when the card is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationDetailsScreen(location: location),
                ),
              );
            },
            child: LocationCard(location: location), // Use the LocationCard widget here
          );
        },
      ),
    );
  }
}
