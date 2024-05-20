import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chant/loginpage.dart'; // Import your login page if not already imported
import 'package:chant/chat_page.dart';
import 'package:chant/chatconnections/message.dart'; // Import your chat page if not already imported

class AddContactPage extends StatefulWidget {
  AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  List<Contact> contacts = [];

  get avatarUrl => null;

  @override
  void initState() {
    super.initState();
    getAllContacts();
  }
  Future<void> getAllContacts() async {
    List<Contact> fetchedContacts =
        (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = fetchedContacts;
    });
  }

  // Function to check phone numbers against Firestore
  Future<String> checkPhoneNumbers(List<Contact> contacts) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Iterate through each contact in the list
    for (Contact contact in contacts) {
      String? phoneNumber = contact.phones?.first.value;
      if (phoneNumber != null) {
        // Remove spaces and hyphens from phone number
        String cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[ -]'), '');

        // Extract last 10 digits
        String last10Digits = cleanedPhoneNumber.substring(
            cleanedPhoneNumber.length - 10 < 0
                ? 0
                : cleanedPhoneNumber.length - 10);

        // Remove non-numeric characters
        last10Digits = last10Digits.replaceAll(RegExp(r'[^0-9]'), '');

        if (last10Digits.length >= 10) {
          // Perform Firestore query
          try {
            QuerySnapshot querySnapshot = await firestore
                .collection('client')
                .where('phonenumber', isEqualTo: last10Digits)
                .get();
            //.update({'avatar': avatarUrl});

            //print('Avatar updated in Firestore');
            if (querySnapshot.docs.isNotEmpty) {
              // Phone number exists in Firestore
              return "Add";
            } else {
              // Phone number doesn't exist in Firestore
              return "Send SMS";
            }
          } catch (error) {
            // Error querying Firestore

            print('Error querying Firestore: $error');
            return "Error: $error";
          }
        } else {
          // Invalid phone number format
          print('Invalid phone number: $phoneNumber');
          return "Invalid phone number";
        }
      }
    }

    // Default return if no valid phone numbers found
    return "No valid phone numbers";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 123, 63, 211),
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
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ADD NEW CONTACT',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: '+43 123-456-7890',
                    prefixIcon: Icon(Icons.phone, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press to add contact
                  },
                  child: Text('ADD CONTACT'),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.1,
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
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 7,
                      margin: EdgeInsets.symmetric(horizontal: 130),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 117, 113, 113),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(height: 19),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'EXISTING CONTACTS IN PHONE',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 123, 63, 211),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        itemCount: contacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          Contact contact = contacts[index];
                          return FutureBuilder<String>(
                            future: checkPhoneNumbers([contact]),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return buildListTile(
                                    contact, 'Loading...'); // Loading state
                              } else if (snapshot.hasError) {
                                return buildListTile(contact,
                                    'Error: ${snapshot.error}'); // Error state
                              } else {
                                String value =
                                    snapshot.data ?? ''; // Fetched value
                                return buildListTile(contact, value);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildListTile(Contact contact, String value) {
    return ListTile(
      title: Text(contact.displayName ?? 'Unknown'),
      subtitle: Text(
        (contact.phones?.isNotEmpty ?? false)
            ? contact.phones!.first.value ?? 'No phone number'
            : 'No phone number',
      ),
      leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
          ? CircleAvatar(
              backgroundImage: MemoryImage(contact.avatar!),
            )
          : CircleAvatar(child: Text(contact.initials())),
      trailing: ElevatedButton(
        onPressed: () {
          if (value == "Add") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddContactPage()));
          }
          // Handle button press here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 123, 63, 211),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        ),
        child: Text(
          value,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
