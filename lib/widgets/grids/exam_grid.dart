import 'package:flutter/material.dart';
import '../../models/exam.dart';
import '../cards/exam_card.dart';
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
          child: ExamCard(exam: exam), // Use the ExamCard widget here
        );
      },
    );
  }
}
