import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:students/model/student_model.dart';

class FirebaseService {
  String collectionref = 'Donor';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference<StudentModel> studentref;
  FirebaseService() {
    studentref =
        firestore.collection(collectionref).withConverter<StudentModel>(
              fromFirestore: (snapshot, options) =>
                  StudentModel.fromJson(snapshot.data()!),
              toFirestore: (value, options) => value.toJson(),
            );
  }
  Stream<QuerySnapshot<StudentModel>>getData() {
    return studentref.snapshots();
  }
  
  addStudent(StudentModel student) async {
    studentref.add(student);
    
  }
}
