class Exam {
  final String id;
  final String courseName;
  final DateTime examDate;
  final String locationId; // This will refer to the location ID
  final bool reminder;

  Exam({
    required this.id,
    required this.courseName,
    required this.examDate,
    required this.locationId, // Link to the location via ID
    required this.reminder,
  });

  // Optionally, you can add a factory method to create Exam from a Map
  factory Exam.fromMap(Map<String, dynamic> map) {
    return Exam(
      id: map['id'],
      courseName: map['courseName'],
      examDate: DateTime.parse(map['examDate']),
      locationId: map['locationId'],
      reminder: map['reminder'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseName': courseName,
      'examDate': examDate.toIso8601String(),
      'locationId': locationId,
      'reminder': reminder,
    };
  }
}
