import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:students/controller/baseprovider.dart';
import 'package:students/controller/student_provider.dart';
import 'package:students/model/student_model.dart';

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
  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<BaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        backgroundColor: Colors.deepPurple, // Set app bar color
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
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: widget.classController,
                decoration: const InputDecoration(labelText: 'Class'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: widget.rollController,
                decoration: const InputDecoration(labelText: 'Roll no'),
              ),
              const SizedBox(height: 16.0),

              // Redesigned image picker buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // setImage(ImageSource.camera);
                      pro.setImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo'),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // setImage(ImageSource.gallery);
                      pro.setImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text('Choose from Gallery'),
                  ),
                ],
              ),

              // Display selected image if available
              if (pro.selectedImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      pro.selectedImage!,
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
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(
                      255, 248, 248, 248), // Set button color
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addStudent(BuildContext context) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final pro = Provider.of<BaseProvider>(context, listen: false);
    final name = widget.nameController.text;
    final roll = widget.rollController.text;
    final classs = widget.classController.text;
    // final image = provider.downloadurl;
    await provider.imageAdder(File(pro.selectedImage!.path));

    final student = StudentModel(
        name: name, age: roll, classs: classs, image: provider.downloadurl);

    // Now, you should call the addStudent method from FirebaseService
    provider.addStudent(student);

    // After adding the student, navigate back to the home page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
}
