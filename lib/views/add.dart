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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Existing form fields remain unchanged
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

              // Redesigned image picker buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setImage(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text('Camera'),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setImage(ImageSource.gallery);
                    },
                    icon: Icon(Icons.photo),
                    label: Text('Gallery'),
                  ),
                ],
              ),

              // Display selected image if available
              if (selectedImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      selectedImage!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              // Save button
              ElevatedButton(
                onPressed: () {
                  addStudent(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addStudent(BuildContext context) async {
    final name = widget.nameController.text;
    final roll = widget.rollController.text;
    final classs = widget.classController.text; // Parse as an integer

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
