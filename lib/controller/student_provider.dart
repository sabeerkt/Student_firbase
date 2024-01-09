import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:students/model/student_model.dart';
import 'package:students/service/firbase_service.dart';

class StudentProvider extends ChangeNotifier {
  FirebaseService _firebaseService = FirebaseService();
   Stream<QuerySnapshot<StudentModel>> getData() {
    return _firebaseService. studentref.snapshots();
  }
  addStudent(StudentModel student) async {
    await _firebaseService. studentref.add(student);
  }
   deleteStudent(id) async {
    await _firebaseService. studentref.doc(id).delete();
  }
  
  updateStudent(id, StudentModel student) async {
    await _firebaseService. studentref.doc(id).update(student.toJson());
    
  }
}
