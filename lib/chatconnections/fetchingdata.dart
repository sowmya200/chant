import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chant/chatconnections/message.dart';
import 'package:chant/addaccountpage.dart';
import 'package:flutter/widgets.dart';

class DocumentListPage extends StatefulWidget {
  final TextEditingController nameController;

  DocumentListPage({
    required this.nameController,
  });

  @override
  _DocumentListPageState createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255,123,63,211),
        title: Text('ChantApp',style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.bold),),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add,color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddContactPage()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
  preferredSize: Size.fromHeight(120), // Adjust the height as needed
  child: Container(
    //color: Colors.white,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            style: TextStyle(color: Colors.black), // Change text color here
          ),
        ),
        SizedBox(height: 15),
      ],
    ),
  ),
),


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

          if (snapshot.data != null) {
            List<String> documentNames = [];
            snapshot.data!.docs.forEach((doc) {
              if (doc.exists) {
                documentNames.add(doc.id);
              }
            });

            return ListView.builder(
              itemCount: documentNames.length,
              itemBuilder: (context, index) {
                String name = documentNames[index];

                // Check if the current document matches the search query
                if (_searchQuery.isNotEmpty &&
                    !name.toLowerCase().contains(_searchQuery.toLowerCase())) {
                  return SizedBox.shrink(); // Hide if not matching
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagePage(
                            senderName: widget.nameController,
                            receiverName: name,
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/default_profile.jpg"),
                    ),
                    title: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Tap to open chat",
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddContactPage()));
          },
          child: Icon(Icons.person_add,color: Colors.white,), // Icon for the floating action button
          backgroundColor: const Color.fromARGB(255,123,63,211), // Background color of the button
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
