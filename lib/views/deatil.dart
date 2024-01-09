import 'package:flutter/material.dart';
import 'package:students/model/student_model.dart';

class Detail extends StatelessWidget {
  final StudentModel student;

  const Detail({required this.student, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(student.name ?? 'Student Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${student.name ?? ''}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Age: ${student.age ?? ''}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Class: ${student.classs ?? ''}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
