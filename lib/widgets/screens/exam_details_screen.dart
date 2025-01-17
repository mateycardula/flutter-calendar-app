import 'package:exams/services/providers/exam_provider.dart';
import 'package:exams/services/providers/locations_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/exam.dart';
import '../../models/location.dart';
import 'location_details.dart'; // Import LocationDetailsScreen

class ExamDetailsScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailsScreen({
    Key? key,
    required this.exam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final examProvider = Provider.of<ExamProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    // Fetch the location using the locationId from the exam
    final location = ExamProvider().getLocationForExam(exam, locationProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(exam.courseName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course: ${exam.courseName}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 10),
            Text(
              'Exam Date: ${exam.examDate.toLocal().toString().split(' ')[0]}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 10),
            Text(
              'Location: ${location.name}', // Will display location ID for now
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 10),
            Text(
              'Reminder: ${exam.reminder ? "Enabled" : "Disabled"}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 20),

            // Add a button to open the LocationDetailsScreen
            ElevatedButton(
              onPressed: () {
                // Navigate to the LocationDetailsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationDetailsScreen(location: location),
                  ),
                );
              },
              child: Text('View Location Details'),
            ),
          ],
        ),
      ),
    );
  }
}
