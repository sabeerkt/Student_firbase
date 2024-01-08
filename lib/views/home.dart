// home_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:students/model/student_model.dart';
import 'package:students/service/firbase_service.dart';

import 'package:students/views/add.dart';
import 'package:students/views/deatil.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person List'),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot<StudentModel>>(
            stream: FirebaseService().getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Snapshot has error'),
                );
              } else {
                List<QueryDocumentSnapshot<StudentModel>> studentsDoc = snapshot.data?.docs ?? [];
                return Expanded(
                  child: ListView.builder(
                    itemCount: studentsDoc.length,
                    itemBuilder: (context, index) {
                      final data = studentsDoc[index].data()!;
                      final id = studentsDoc[index].id;
                      return ListTile(
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
                              "Age: ${data.age.toString() ?? ''}",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Class: ${data.classs.toString() ?? ''}",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: Text(
                            data.name?.substring(0, 1) ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                // Add logic for editing the student data
                                // You may want to navigate to a different page for editing
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                FirebaseService().deleteStudent(id);
                                // Add logic for deleting the student data
                                // You may want to show a confirmation dialog before deletion
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
                      );
                    },
                  ),
                );
              }
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
