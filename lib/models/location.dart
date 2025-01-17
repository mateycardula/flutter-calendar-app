class Location {
  final String id; // Unique ID for the location
  final String building;
  final String floor;
  final String name;
  final double latitude;
  final double longitude;

  Location({
    required this.id,
    required this.building,
    required this.floor,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  // Optionally, you can add a factory method to create Location from a Map (e.g., for Firebase or API calls)
  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'],
      building: map['building'],
      floor: map['floor'],
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'building': building,
      'floor': floor,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
