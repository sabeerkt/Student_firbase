import 'dart:io';

import 'package:flutter/material.dart';
import 'package:students/views/home.dart';
import 'package:image_picker/image_picker.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String name = "";
  int age = 0;
  String bloodGroup = "";
  File? selectedImage; // Use File for image selection

  // Image picker function
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                _getImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                _getImage(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  age = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Blood Group'),
              onChanged: (value) {
                setState(() {
                  bloodGroup = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            InkWell(
              onTap: _pickImage, // Call the image picker function
              child: selectedImage == null
                  ? Text('Select Image')
                  : Image.file(selectedImage!),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement save logic here
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
