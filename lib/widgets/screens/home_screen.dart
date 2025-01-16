import 'package:flutter/material.dart';
import '../../models/exam.dart';
import '../calendar/calendar_widget.dart';
import '../grids/exam_grid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

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
      examDate: DateTime.now(),
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

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  void _onDateSelected(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter exams based on the selected date
    final filteredExams = mockExams.where((exam) {
      return exam.examDate.year == _selectedDay.year &&
          exam.examDate.month == _selectedDay.month &&
          exam.examDate.day == _selectedDay.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
      ),
      body: Column(
        children: [
          CalendarWidget(  // Corrected parameter names
            selectedDay: _selectedDay, // Use selectedDay here
            onDaySelected: _onDateSelected, // Use onDaySelected here
          ),
          const SizedBox(height: 16.0), // Add some space

          // Show the filtered exams for the selected date
          Expanded(
            child: ExamGrid(exams: filteredExams),
          ),
        ],
      ),
    );
  }
}
