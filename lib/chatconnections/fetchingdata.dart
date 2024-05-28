import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chant/chatconnections/message.dart';
import 'package:chant/addaccountpage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

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
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      // Upload image to Firebase Cloud Storage
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    try {
      // Upload file to Firebase Cloud Storage
      String fileName = Path.basename(_imageFile!.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
      await uploadTask.whenComplete(() => null);

      // Get download URL
      String downloadURL = await firebaseStorageRef.getDownloadURL();

      // Optionally, you can use the downloadURL for further operations (e.g., saving to database)
      print('Image uploaded to Firebase: $downloadURL');

      // Optionally, you can navigate to another screen or show a success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Image uploaded successfully!'),
      ));
    } catch (e) {
      print('Error uploading image to Firebase: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to upload image. Please try again later.'),
      ));
    }
  }

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
            onPressed:
             _pickImage,
             
            
          ),
           _imageFile != null
                ? Image.file(_imageFile!)
                : Text('No image selected'),
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
