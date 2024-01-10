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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
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
                      pro.setImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.photo),
                    label: const Text('Choose from Gallery'),
                  ),
                ],
              ),
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
              ElevatedButton(
                onPressed: () {
                  if (_validateFields()) {
                    addStudent(context);
                  } else {
                    _showAlert(context, 'Please fill in all fields.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 248, 248, 248),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateFields() {
    return widget.nameController.text.isNotEmpty &&
        widget.classController.text.isNotEmpty &&
        widget.rollController.text.isNotEmpty;
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void addStudent(BuildContext context) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final pro = Provider.of<BaseProvider>(context, listen: false);
    final name = widget.nameController.text;
    final roll = widget.rollController.text;
    final classs = widget.classController.text;

    await provider.imageAdder(File(pro.selectedImage!.path));

    final student = StudentModel(
      name: name,
      age: roll,
      classs: classs,
      image: provider.downloadurl,
    );

    provider.addStudent(student);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
}
