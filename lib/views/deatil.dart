import 'package:flutter/material.dart';
import 'package:students/model/student_model.dart';

class Detail extends StatefulWidget {
  final StudentModel student;

  const Detail({required this.student, Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student.name ?? 'Student Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${widget.student.name ?? ''}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Age: ${widget.student.age ?? ''}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Class: ${widget.student.classs ?? ''}",
              style: TextStyle(
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
