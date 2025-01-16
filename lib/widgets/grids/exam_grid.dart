import 'package:exams/widgets/cards/exam_card.dart';
import 'package:flutter/material.dart';
import '../../models/exam.dart';

class ExamGrid extends StatelessWidget {
  final List<Exam> exams; // The list of exam data

  const ExamGrid({
    required this.exams,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.6,
        ),
        itemCount: exams.length,
        itemBuilder: (context, index) {
          return ExamCard(exam: exams[index]);
        },
      ),
    );
  }
}
