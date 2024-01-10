import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:students/model/student_model.dart';
import 'package:students/service/firbase_service.dart';

class StudentProvider extends ChangeNotifier {
  FirebaseService _firebaseService = FirebaseService();
  String uniquename = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadurl = '';
  //qurysnapshot=firbase data snapmodel ann varn
  Stream<QuerySnapshot<StudentModel>> getData() {
    return _firebaseService.studentref.snapshots();
  }

  addStudent(StudentModel student) async {
    await _firebaseService.studentref.add(student);
    notifyListeners();
  }

  deleteStudent(id) async {
    await _firebaseService.studentref.doc(id).delete();
    notifyListeners();
  }

  updateStudent(id, StudentModel student) async {
    await _firebaseService.studentref.doc(id).update(student.toJson());
    notifyListeners();
  }

  imageAdder(image) async {
    //for the image saving path  .ref().child('images'); refrence and the folder name image
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

  updateImage(imageurl, File? newimage) async {
  try {
    if (newimage != null && newimage.existsSync()) {
      Reference storedimage = FirebaseStorage.instance.refFromURL(imageurl);
      await storedimage.putFile(newimage);
      downloadurl = await storedimage.getDownloadURL();
      print("Image uploaded successfully. Download URL: $downloadurl");
    } else {
      // If no new image or new image is null or doesn't exist, keep the existing URL
      downloadurl = imageurl;
      print("No new image provided. Using existing URL: $downloadurl");
    }
  } catch (e) {
    // Handle exceptions appropriately (e.g., show an error message)
    print("Error updating image: $e");
  }
}


  deleteImage(imageurl) async {
    Reference storedimage = FirebaseStorage.instance.refFromURL(imageurl);
    await storedimage.delete();
  }
}
