import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students/model/student_model.dart';
import 'package:students/service/firbase_service.dart';
import 'package:students/views/home.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController classController = TextEditingController();

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File? selectedImage;
  ImagePicker imagePicker = ImagePicker();

  void setImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(source: source);
    setState(() {
      selectedImage = pickedImage != null ? File(pickedImage.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: widget.nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: widget.classController,
              decoration: InputDecoration(labelText: 'Class'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: widget.rollController,
              decoration: InputDecoration(labelText: 'Roll no'),
            ),
            SizedBox(height: 16.0),
            // Padding(
            //   padding: const EdgeInsets.only(left: 80),
            //   child: CircleAvatar(
            //     backgroundImage: selectedImage != null
            //         ? FileImage(selectedImage!)
            //         : AssetImage('assets/images/profile.png'),
            //     radius: 60,
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setImage(ImageSource.camera);
                  },
                  child: const Text('Camera'),
                ),
                const SizedBox(
                  width: 30,
                ),
                TextButton(
                  onPressed: () {
                    setImage(ImageSource.gallery);
                  },
                  child: const Text('Gallery'),
                ),
              ],
            ),
            if (selectedImage != null)
              Image.file(
                selectedImage!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addStudent(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void addStudent(BuildContext context) async {
    final name = widget.nameController.text;
    final roll = widget.rollController.text;
    final classs =
       widget.classController.text; // Parse as an integer

    final student = StudentModel(
      name: name,
      age: roll,
      classs: classs,
    );

    // Now, you should call the addStudent method from FirebaseService
    await FirebaseService().addStudent(student);

    // After adding the student, navigate back to the home page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}
