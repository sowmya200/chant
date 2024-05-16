import 'package:chant/chat_page.dart';
import 'dart:io';
import 'package:chant/imageConnection.dart';
import 'package:flutter/material.dart';
import 'package:chant/loginpage.dart';
import 'package:chant/SignInVerification.dart';
import 'package:chant/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //late MyAppBar myAppBar;
  Uint8List? _image;
  // String? _imageUrl;

  // void selectImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     try {
  //       final File imageFile = File(pickedFile.path);
  //       final Uint8List imageBytes = await imageFile.readAsBytes();
  //       _imageUrl = await uploadImageToFirebaseStorage(imageFile);

  //       // Save user information including image URL to Firestore

  //       // Update state to reflect the selected image
  //       setState(() {
  //         _image = imageBytes;
  //       });
  //     } catch (e) {
  //       print('Error selecting image: $e');
  //     }
  //   }
  // }

  // Future<String> uploadImageToFirebaseStorage(File imageFile) async {
  //   try {
  //     String fileName =
  //         DateTime.now().millisecondsSinceEpoch.toString(); // Unique file name
  //     Reference storageRef =
  //         FirebaseStorage.instance.ref().child('images/$fileName.jpg');
  //     UploadTask uploadTask = storageRef.putFile(imageFile);
  //     TaskSnapshot taskSnapshot = await uploadTask;
  //     return await taskSnapshot.ref.getDownloadURL();
  //   } catch (e) {
  //     print('Error uploading image to Firebase Storage: $e');
  //     throw e; // Re-throw the error to handle it in the calling function
  //   }
  // }

  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //appBar:const MyAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add your circular avatar here
              // _image != null
              //     ? CircleAvatar(
              //         radius: 50,
              //         backgroundImage: MemoryImage(_image!),
              //       )
              //     : CircleAvatar(
              //         radius: 50, // Adjust the size of the avatar as needed
              //         backgroundImage: AssetImage(
              //             "assets/default profile.jpg"), // Replace with your avatar image
              //         child: Stack(children: [
              //           Align(
              //             alignment: Alignment.bottomRight,
              //             child: GestureDetector(
              //               onTap: selectImage,
              //               child: CircleAvatar(
              //                 radius: 15,
              //                 backgroundColor:
              //                     Color.fromARGB(255, 187, 166, 246),
              //                 child: Icon(Icons.add),
              //               ),
              //             ),
              //           ),
              //         ]),
              //       ),
              SizedBox(
                height: 70,
              ),
              const Text(
                "SignIn For Account                           ",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 18,
              ),
              Row(children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Color.fromARGB(255, 90, 50, 200)),
                      ),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        IconData(0xe3b2, fontFamily: 'MaterialIcons'),
                        color: Color.fromARGB(255, 90, 50,
                            200), // Adjust the color of the icon as needed
                      ),
                      label: const Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.verified_user,
                        size: 24, // Adjust the size of the icon as needed
                        color: Colors.black87,
                        //IconData(0xe5ca, fontFamily: 'MaterialIcons'),
                      ),
                      label: const Text(
                        'Verification',
                        style: TextStyle(color: Colors.black87),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ]),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: nameController,
                  //obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                    hintText: 'Enter full name...',
                    prefixIcon: Icon(
                      Icons.person,
                      color:
                          Colors.grey, // Adjust the color of the icon as needed
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: phoneNumberController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10)
                  ], // Restrict to 10 characters
                  keyboardType:
                      TextInputType.phone, // Set keyboard type to phone
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
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: passwordController,
                  //   obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Set a Password',
                    hintText: 'Enter Your Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color:
                          Colors.grey, // Adjust the color of the icon as needed
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                        10), // Set max length of password
                    FilteringTextInputFormatter.allow(RegExp(
                        r'^[a-zA-Z0-9@#$%^&+=]*$')), // Allow only certain characters
                  ],
                  onEditingComplete: () {
            // Custom validation logic to check minimum length
            if (passwordController.text.length < 8) {
              // Show an alert if password is less than 8 characters
              _showPasswordLengthAlert(context);
            }
          },
                ),
              ),

              // SizedBox(
              //   height: 30,
              // ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  label: const Text('Next Step',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 19)),
                  onPressed: () {
                    CollectionReference collRef =
                        FirebaseFirestore.instance.collection('client');
                    String customDocumentId = nameController.text;
                    collRef.doc(customDocumentId).set({
                      'name': nameController.text,
                      'phonenumber': phoneNumberController.text,
                      'password': passwordController.text,
                      // 'imageUrl': _imageUrl,
                    });

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignInVerification(
                                nameController: nameController,
                                phoneNumberController: phoneNumberController,
                                passwordController: passwordController,
                              )),
                      (route) => false, // Remove all routes below the new page
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 90, 50, 200)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("You Have Account?"),
                    TextButton(
                      onPressed: () {
                        // Navigate to signup page

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) =>
                              false, // Remove all routes below the new page
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ]),

              ///////////

              // Add other child content here if needed
            ],
          ), /* add child content here */
        ),
      ),

      //body:
    );
  }
}
 void _showPasswordLengthAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password Length'),
          content: Text('Password must contain at least 8 characters.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  void _showNotification(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password entered successfully!'),
      ),
    );
  }


