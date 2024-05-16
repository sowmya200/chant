import 'package:chant/loginpage.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:chant/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:permission_handler/permission_handler.dart';
class AddContactPage extends StatefulWidget {
  AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    getAllContacts();
  }

  getAllContacts() async {
    List<Contact> fetchedContacts =
        (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = fetchedContacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // Set the height here
        child: AppBar(
          backgroundColor:
              Color.fromARGB(255, 123, 63, 211), // Setting the background color
          title: Text('Add contacts', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
              child: Container(
                  child: Column(children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Text(
              'ADD NEW CONTACT',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  hintText: '+43 123-456-7890',
                  prefixIcon: Icon(
                    IconData(0xe4a2, fontFamily: 'MaterialIcons'),
                    color:
                        Colors.grey, // Adjust the color of the icon as needed
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            ElevatedButton(
              onPressed: () {
                // Add your button's onPressed logic here
              },
              child: Text('ADD CONTACT'),
            )
          ]))),
          // Draggable Scrollable Sheet
          DraggableScrollableSheet(
            initialChildSize:
                0.5, // initial height, in proportion to screen height
            minChildSize: 0.1, // minimum height when fully collapsed
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 239, 231, 250),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2.0,
                            blurRadius: 4.0),
                      ]),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 7,
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              130), // Adjust horizontal margin as needed
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 117, 113, 113),
                        borderRadius: BorderRadius.circular(
                            2), // Adjust border radius to control corner roundness
                      ),
                    ),
                    SizedBox(
                      height: 19,
                    ),
                    Text(
                      'EXISTING CONTACT IN PHONE',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 123, 63, 211)),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        controller: scrollController,
                        itemCount: contacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          Contact contact = contacts[index];
                          checkPhoneNumbers([contact]);
                          return ListTile(
                            title: Text(contact.displayName ?? 'Unknown'),
                            subtitle: Text(
                              (contact.phones?.isNotEmpty ?? false)
                                  ? contact.phones!.first.value ??
                                      'No phone number'
                                  : 'No phone number',
                            ),
                            leading: (contact.avatar != null &&
                                    contact.avatar!.isNotEmpty)
                                ? CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(contact.avatar!),
                                  )
                                : CircleAvatar(
                                    child: Text(contact.initials()),
                                  ),
                                  
                            // trailing: 
                            // ElevatedButton(
                            //   onPressed: () {
                            //     // Call checkPhoneNumbers function here passing the list of contacts
                            //     checkPhoneNumbers([contact]);
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor:
                            //         Color.fromARGB(255, 123, 63, 211),
                            //     padding: EdgeInsets.symmetric(
                            //         vertical: 5, horizontal: 10),
                            //   ),
                            //   child: Text(
                            //     'Add',
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            // ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(); // Add a divider between each item
                        },
                      ),
                    )
                  ]));
            },
          ),
        ],
      ),
    );
  }
}

void checkPhoneNumbers(List<Contact> contacts) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  contacts.forEach((contact) {
    String? phoneNumber = contact.phones?.first.value;
    if (phoneNumber != null) {
      // Extract last 10 digits
      String last10Digits = phoneNumber.substring(phoneNumber.length - 10);

      // Remove non-numeric characters
      last10Digits = last10Digits.replaceAll(RegExp(r'[^0-9]'), '');

      if (last10Digits.length >= 10) {
        // Trim to the last 10 digits
        last10Digits = last10Digits.substring(last10Digits.length - 10);

        firestore
            .collection('client')
            .where('phonenumber', isEqualTo: last10Digits)
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            print('$last10Digits exists in Firestore');
          } else {
            print('$last10Digits does not exist in Firestore');
          }
        }).catchError((error) {
          void checkPhoneNumbers(List<Contact> contacts) {
            FirebaseFirestore firestore = FirebaseFirestore.instance;

            contacts.forEach((contact) {
              String? phoneNumber = contact.phones?.first.value;
              if (phoneNumber != null) {
                // Extract last 10 digits
                String last10Digits =
                    phoneNumber.substring(phoneNumber.length - 10);

                // Remove non-numeric characters
                last10Digits = last10Digits.replaceAll(RegExp(r'[^0-9]'), '');

                if (last10Digits.length >= 10) {
                  // Trim to the last 10 digits
                  last10Digits =
                      last10Digits.substring(last10Digits.length - 10);

                  firestore
                      .collection('client')
                      .where('phonenumber', isEqualTo: last10Digits)
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    if (querySnapshot.docs.isNotEmpty) {
                      trailing:
                      ElevatedButton(
                        onPressed: () {
                          // Call checkPhoneNumbers function here passing the list of contacts
                          checkPhoneNumbers([contact]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 123, 63, 211),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      trailing:
                      ElevatedButton(
                        onPressed: () {
                          // Call checkPhoneNumbers function here passing the list of contacts
                          checkPhoneNumbers([contact]);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 123, 63, 211),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                        child: Text(
                          'Send SMS',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  }).catchError((error) {
                    print('Error querying Firestore: $error');
                  });
                } else {
                  print('Invalid phone number: $phoneNumber');
                }
              }
            });
          }
        });
      } else {
        print('Invalid phone number: $phoneNumber');
      }
    }
  });
}
