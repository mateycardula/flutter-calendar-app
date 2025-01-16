import 'package:flutter/material.dart';
import '../../models/exam.dart';
import '../screens/exam_details_screen.dart';

class ExamGrid extends StatelessWidget {
  final List<Exam> exams;

  const ExamGrid({
    Key? key,
    required this.exams,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: exams.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
      ),
      itemBuilder: (context, index) {
        final exam = exams[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExamDetailsScreen(exam: exam),
              ),
            );
          },
          child: Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.courseName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text('Exam on: ${exam.examDate.toLocal().toString().split(' ')[0]}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
