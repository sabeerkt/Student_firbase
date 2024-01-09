// home_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students/controller/baseprovider.dart';
import 'package:students/controller/student_provider.dart';
import 'package:students/model/student_model.dart';

import 'package:students/views/add.dart';
import 'package:students/views/deatil.dart';
import 'package:students/views/edit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<BaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person List'),
        backgroundColor: Colors.deepPurple, // Set app bar color
      ),
      body: SafeArea(
        child: Consumer<StudentProvider>(
          builder: (context, value, child) => Column(
            children: [
              StreamBuilder<QuerySnapshot<StudentModel>>(
                stream: value.getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Snapshot has error'),
                    );
                  } else {
                    List<QueryDocumentSnapshot<StudentModel>> studentsDoc =
                        snapshot.data?.docs ?? [];
                    return Expanded(
                      child: ListView.builder(
                        itemCount: studentsDoc.length,
                        itemBuilder: (context, index) {
                          final data = studentsDoc[index].data();
                          final id = studentsDoc[index].id;
                          return Card(
                            elevation: 3, // Add elevation for a card-like look
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(
                                data.name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Age: ${data.age.toString()}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "Class: ${data.classs.toString()}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                backgroundImage: NetworkImage(data.image!),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditPage(
                                            id: id,
                                            student: data,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      value.deleteStudent(id);
                                      value.deleteImage(data.image);
                                    },
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.deepPurple,
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Detail(
                                      student: data,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 0, 0, 0)),
        ),
        child: const Text(
          'Add',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
