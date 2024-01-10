// firebase_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:students/model/student_model.dart';

class FirebaseService {
  String collectionref = 'Donor';
  //instnce data aces cheyn
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseStorage storage = FirebaseStorage.instance;
  late final CollectionReference<StudentModel> studentref;
    
  FirebaseService() {
    studentref =
    //donor olla collection studentmodel data leavl converted
    
        firestore.collection(collectionref).withConverter<StudentModel>(
              fromFirestore: (snapshot, options) =>
                  StudentModel.fromJson(snapshot.data()!),
              toFirestore: (value, options) => value.toJson(),
            );
  }
}
