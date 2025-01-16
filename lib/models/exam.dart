class Exam {
  final String id;
  final String courseName;
  final DateTime examDate;
  final String location;
  final bool reminder;

  Exam({
    required this.id,
    required this.courseName,
    required this.examDate,
    required this.location,
    this.reminder = false,
  });

  factory Exam.fromMap(Map<String, dynamic> data, String documentId) {
    return Exam(
      id: documentId,
      courseName: data['courseName'] ?? '',
      examDate: (data['examDate']).toDate(),
      location: data['location'] ?? '',
      reminder: data['reminder'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'examDate': examDate,
      'location': location,
      'reminder': reminder,
    };
  }
}
