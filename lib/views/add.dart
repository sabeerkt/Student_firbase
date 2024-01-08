import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students/views/home.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String name = "";
  int age = 0;
  String bloodGroup = "";
  // You can use a File variable for the selected image
  File? selectedImage;
  imagePicker({required source}) async {
    final returnedimage = await ImagePicker().pickImage(source: source);
    selectedImage = File(returnedimage!.path);
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
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'class'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  age = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Roll no'),
              onChanged: (value) {
                setState(() {
                  bloodGroup = value;
                });
              },
            ),
            SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: CircleAvatar(
                  backgroundImage: selectedImage != null
                      ? FileImage(selectedImage!)
                      : const AssetImage('assets/images/profile.png')
                          as ImageProvider,
                  radius: 60,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        imagePicker(source: ImageSource.camera);
                      },
                      child: const Text('Camera')),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                      onPressed: () {
                       imagePicker(source: ImageSource.gallery);
                      },
                      child: const Text('Gallery')),
                ],
              ),
            // Add image selection field here, e.g., using InkWell and image_picker plugin
            InkWell(
              onTap: () {
                // Implement image selection logic here
              },
              child: selectedImage == null
                  ? Text('Select Image')
                  : Image.file(selectedImage!),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
