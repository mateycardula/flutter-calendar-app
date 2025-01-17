import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For accessing providers
import '../../models/exam.dart';
import '../../services/providers/exam_provider.dart';
import '../../services/providers/locations_provider.dart';
// Import the LocationProvider

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    // Access the ExamProvider and LocationProvider
    final examProvider = Provider.of<ExamProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    // Fetch the location for the exam using its locationId
    final location = examProvider.getLocationForExam(exam, locationProvider);

    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exam.courseName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: ${exam.examDate.toLocal()}',
              style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
            ),
            SizedBox(height: 4.0),
            // Display the location name instead of location ID
            Text(
              'Location: ${location.name}', // Fetch location name from the LocationProvider
              style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  exam.reminder ? Icons.notifications_active : Icons.notifications_off,
                  color: exam.reminder ? Colors.green : Colors.red,
                ),
                SizedBox(width: 4.0),
                Text(
                  exam.reminder ? 'Reminder Set' : 'No Reminder',
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
