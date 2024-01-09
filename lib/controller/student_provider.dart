import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:students/model/student_model.dart';
import 'package:students/service/firbase_service.dart';

class StudentProvider extends ChangeNotifier {
  FirebaseService _firebaseService = FirebaseService();
  String uniquename = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadurl = '';
  Stream<QuerySnapshot<StudentModel>> getData() {
    return _firebaseService.studentref.snapshots();
  }

  addStudent(StudentModel student) async {
    await _firebaseService.studentref.add(student);
  }

  deleteStudent(id) async {
    await _firebaseService.studentref.doc(id).delete();
  }

  updateStudent(id, StudentModel student) async {
    await _firebaseService.studentref.doc(id).update(student.toJson());
  }

  imageAdder(image) async {
    Reference folder = _firebaseService.storage.ref().child('images');
    Reference images = folder.child("$uniquename.jpg");
    try {
      await images.putFile(image);
      downloadurl = await images.getDownloadURL();
      notifyListeners();
      print(downloadurl);
    } catch (e) {
      throw Exception(e);
    }
  }
  updateImage(imageurl, newimage) async {
    try {
      if (newimage != null && newimage.existsSync()) {
        Reference storedimage = FirebaseStorage.instance.refFromURL(imageurl);
        await storedimage.putFile(newimage);
        downloadurl = await storedimage.getDownloadURL();
      } else {
        downloadurl = imageurl;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  deleteImage(imageurl) async {
    Reference storedimage = FirebaseStorage.instance.refFromURL(imageurl);
    await storedimage.delete();
  }
}
