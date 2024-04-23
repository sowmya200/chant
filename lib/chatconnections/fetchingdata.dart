
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chant/chatconnections/message.dart';

class DocumentListPage extends StatefulWidget {
  final TextEditingController nameController;
 // final TextEditingController passwordController;

  DocumentListPage({
    required this.nameController,
    //required this.phoneNumberController,
    //required this.passwordController,
  });
  @override
  _DocumentListPageState createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255,242,242,242),
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
                 

                  // return Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //    child: //ElevatedButton(
                  //   //   onPressed: () {
                  //   //     // Handle button press
                  //   //     Navigator.push(
                  //   //         context,
                  //   //         MaterialPageRoute(
                  //   //           builder: (context) => MessagePage(
                  //   //             senderName: widget.nameController,
                  //   //             receiverName: name,
                  //   //           ),
                  //   //         ));
                  //   //   },
                      
                  //   //   child: Text(
                  //   //     name,
                  //   //     style: TextStyle(
                  //   //         color: const Color.fromARGB(255, 0, 0, 0)),
                  //   //   ),
                  //   // ),
                    
    return Container(
      color: const Color.fromARGB(255,242,242,242), // Set the background color for the text
      padding: EdgeInsets.all(8.0), // Add padding to the container
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0), // Add margin to the container
      child: GestureDetector(
  onTap: () {
    // Handle onTap event here
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MessagePage(
          senderName: widget.nameController,
          receiverName: name,
        ),
      ),
    );
  },child:ListTile(
        title:Column(children: [
          Row(children: [
           CircleAvatar(
                      radius: 30, // Adjust the size of the avatar as needed
                      backgroundImage: AssetImage(
                          "assets/default profile.jpg"),),
                          SizedBox(width: 10,),
                          Text(
          name,
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
             fontWeight: FontWeight.bold,
            // Set the text color
          ),
          
        ),],),
        SizedBox(height: 10,),
         Divider(
              color: Color.fromARGB(255, 131, 70, 201)
            )
        ],)
        // subtitle: Text(
        //   messages,
        //   style: TextStyle(
        //     color: Colors.white, // Set the text color
        //   ),
        // ),
      ),
    ),);
  


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

