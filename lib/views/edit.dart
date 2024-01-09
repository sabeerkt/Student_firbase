// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:students/controller/baseprovider.dart';
import 'package:students/controller/student_provider.dart';
import 'package:students/model/student_model.dart';

class EditPage extends StatefulWidget {
  StudentModel student;
  String id;
  EditPage({
    Key? key,
    required this.student,
    required this.id,
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController classController = TextEditingController();
  File? selectedImage; // Use File for image selection
  bool clicked = true;

  ImagePicker imagePicker = ImagePicker();

  void setImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(source: source);
    setState(() {
      selectedImage = pickedImage != null ? File(pickedImage.path) : null;
    });
  }

  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    rollController = TextEditingController(text: widget.student.age);
    classController = TextEditingController(text: widget.student.classs);
    Provider.of<BaseProvider>(context, listen: false).selectedImage =
        File(widget.student.image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<BaseProvider>(
            builder: (context, value, child) => Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: classController,
                  decoration: InputDecoration(labelText: 'Class'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: rollController,
                  decoration: InputDecoration(labelText: 'Roll no'),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // setImage(ImageSource.camera);
                        value.setImage(ImageSource.camera);
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
                        value.setImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.photo),
                      label: const Text('Choose from Gallery'),
                    ),
                  ],
                ),
                if (value.selectedImage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        value.selectedImage!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    editStudent(context, widget.student.image);
                    //addStudent(context);
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  editStudent(context, imageurl) async {
    final provider = Provider.of<StudentProvider>(context, listen: false);
    final pro = Provider.of<BaseProvider>(context, listen: false);

    final editedname = nameController.text;
    final editedage = rollController.text;
    final editclass = classController.text;
    final editedimage = provider.downloadurl;
    await provider.updateImage(imageurl, File(pro.selectedImage!.path));

    //await prodata.updateImage(imageurl, File(pro.selectedimage!.path));
    final updatedstudent = StudentModel(
      image: editedimage,
      name: editedname,
      age: editedage,
      classs: editclass,
    );

    provider.updateStudent(widget.id, updatedstudent);
    Navigator.pop(context);
  }
}
