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
          Expanded(
              child: StreamBuilder<QuerySnapshot<StudentModel>>(
            stream: FirebaseService().getData(),
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
                return ListView.builder(
                  itemCount: studentsDoc.length,
                  itemBuilder: (context, index) {
                    final data = studentsDoc[index].data();
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
                            "Age: ${data.age ?? ''}",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Class: ${data.classs ?? ''}",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                        // You can customize the leading widget, e.g., an image or an icon
                        backgroundColor: Colors.deepPurple,
                        child: Text(
                          data.name?.substring(0, 1) ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.deepPurple,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Detail(
                                    student: data,
                                  )),
                        );
                      },
                    );
                  },
                );
              }
            },
          )),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddPage(),
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
