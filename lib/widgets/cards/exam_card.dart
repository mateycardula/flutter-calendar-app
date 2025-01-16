import 'package:flutter/material.dart';
import '../../models/exam.dart'; // Import your Exam model

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard({
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Location: ${exam.location}',
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
