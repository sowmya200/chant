
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentListPage extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController passwordController;

  DocumentListPage({
    required this.nameController,
    //required this.phoneNumberController,
    required this.passwordController,
  });
  @override
  _DocumentListPageState createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('client').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Check if snapshot data is not null before accessing docs
          if (snapshot.data != null) {
            // Extract document names from the snapshot
            List<String> documentNames = [];
            snapshot.data!.docs.forEach((doc) {
              if (doc.exists) {
                documentNames.add(doc.id);
              }
            });

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: documentNames.map((name) {
                  // Generate a random color for each button
                 

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button press
                      },
                      child: Text(
                        name,
                        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}

