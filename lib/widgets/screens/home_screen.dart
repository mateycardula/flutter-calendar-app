import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import '../../models/exam.dart';
import '../../services/providers/exam_provider.dart';
import '../app_drawer.dart';
import '../calendar/calendar_widget.dart';
import '../grids/exam_grid.dart';
import '../../services/navigation_service.dart';

class HomeScreen extends StatefulWidget {
  final NavigationService navigationService; // Receive the navigation service

  HomeScreen({required this.navigationService});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

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
    // Get the exams from the provider
    final examProvider = Provider.of<ExamProvider>(context);

    // Filter exams based on the selected date
    final filteredExams = examProvider.exams.where((exam) {
      return exam.examDate.year == _selectedDay.year &&
          exam.examDate.month == _selectedDay.month &&
          exam.examDate.day == _selectedDay.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
      ),
      drawer: AppDrawer(navigationService: widget.navigationService),
      body: Column(
        children: [
          CalendarWidget(
            selectedDay: _selectedDay,
            onDaySelected: _onDateSelected,
          ),
          const SizedBox(height: 16.0), // Add some space

          Expanded(
            child: ExamGrid(exams: filteredExams),
          ),
        ],
      ),
    );
  }
}
