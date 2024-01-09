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
        backgroundColor: Colors.deepPurple, // Set app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display student details with improved styling
            ListTile(
              title: Text(
                "Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.name ?? '',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                "Age",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.age ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(
                "Class",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.classs ?? '',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
