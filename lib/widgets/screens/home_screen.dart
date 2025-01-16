import 'package:flutter/material.dart';
import '../../models/exam.dart';
import '../grids/exam_grid.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock data for exams
    List<Exam> mockExams = [
      Exam(
        id: '1',
        courseName: 'Mathematics',
        examDate: DateTime.now(),
        location: 'Room 101',
        reminder: true,
      ),
      Exam(
        id: '2',
        courseName: 'Physics',
        examDate: DateTime.now().add(Duration(days: 2)),
        location: 'Room 202',
        reminder: false,
      ),
      Exam(
        id: '3',
        courseName: 'Chemistry',
        examDate: DateTime.now().add(Duration(days: 4)),
        location: 'Room 303',
        reminder: true,
      ),
      // Add more mock exams as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
      ),
      body: ExamGrid(exams: mockExams),
    );
  }
}
