import 'package:flutter/material.dart';
import '../../models/exam.dart';
import '../../models/location.dart';
import 'locations_provider.dart';

class ExamProvider with ChangeNotifier {
  List<Exam> _exams = [
    Exam(
      id: '1',
      courseName: 'Mathematics',
      examDate: DateTime.now(),
      locationId: '1',
      reminder: true,
    ),
    Exam(
      id: '2',
      courseName: 'Physics',
      examDate: DateTime.now(),
      locationId: '1',
      reminder: false,
    ),
    Exam(
      id: '3',
      courseName: 'Chemistry',
      examDate: DateTime.now().add(Duration(days: 4)),
      locationId: '2',
      reminder: true,
    ),
    // More mock exams...
  ];

  Location getLocationForExam(Exam exam, LocationProvider locationProvider) {
    return locationProvider.getLocationById(exam.locationId);
  }

  List<Exam> get exams => _exams;
}
